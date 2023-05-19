SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UnmergePatientByRequestId]
(	@MergeRequestBatchId BIGINT,
	@MergeRequestQueueId BIGINT,
	@PatientUnmergeRequestId BIGINT,
	@CompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@primaryPaId INT, 
	@secondaryPaId INT,
	@CheckBatchId BIT
)
AS
DECLARE @TranName VARCHAR(20);
SELECT @TranName = 'UnMergeTransaction';
DECLARE @StatusId As INT
BEGIN
	  BEGIN TRY
		IF @primaryPaId<>0 AND @secondaryPaId <>0 
		BEGIN
			BEGIN TRANSACTION @TranName 
			
				EXEC usp_UnmergePatients @MergeRequestQueueId, @MergeRequestBatchId, @PatientUnmergeRequestId, @primaryPaId, @secondaryPaId, @CheckBatchId
				
				SELECT @StatusId = StatusId FROM dbo.Patient_merge_status WITH (NOLOCK) WHERE Status = 'UnmergeCompleted'
				
				UPDATE Patient_merge_request_queue SET status = @StatusId WHERE pa_merge_reqid = @MergeRequestQueueId AND pa_merge_batchid = @MergeRequestBatchId
				
				INSERT INTO Patient_merge_transaction(pa_merge_reqid, status, created_date)VALUES(@MergeRequestQueueId, @StatusId, GETDATE())
					
			COMMIT TRANSACTION @TranName
		END
	  END TRY
	  BEGIN CATCH
	    ROLLBACK TRANSACTION @TranName
	   
		SELECT @StatusId = StatusId FROM dbo.Patient_merge_status WITH (NOLOCK) WHERE Status = 'UnMergeFailed'
		
		UPDATE Patient_merge_request_queue SET status = @StatusId WHERE pa_merge_reqid = @MergeRequestQueueId AND pa_merge_batchid = @MergeRequestBatchId
					
		INSERT INTO Patient_merge_transaction(pa_merge_reqid,status,created_date)VALUES(@MergeRequestQueueId, @StatusId, GETDATE())
	  
	    DECLARE @bkErrorMessage AS NVARCHAR(4000),@bkErrorSeverity AS INT,@bkErrorState AS INT;
		SELECT 
			@bkErrorMessage = ERROR_MESSAGE(),
			@bkErrorSeverity = ERROR_SEVERITY(),
			@bkErrorState = ERROR_STATE();
			
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','UnMergePatientByRequestId','Primary PatientId:'+CONVERT(VARCHAR(500),@primaryPaId)+',Secondry PatientId:'+CONVERT(VARCHAR(500),@secondaryPaId),ERROR_LINE ())				   	
		
		RAISERROR (@bkErrorMessage, -- Message text.
				   @bkErrorSeverity, -- Severity.
				   @bkErrorState -- State.
				   );
	  END CATCH
	  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
