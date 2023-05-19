SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MergePatientByRequestId]
	(@requestId BIGINT,
	@primaryPaId INT,
	@secondaryPaId INT,
	@batchId BIGINT)
AS
DECLARE @TranName VARCHAR(20);
SELECT @TranName = 'MergeTransaction';
BEGIN
	  BEGIN TRY
			IF @primaryPaId<>0 AND @secondaryPaId <>0 
			BEGIN
				BEGIN TRANSACTION @TranName 
				
					EXEC mergePatients_New  @primaryPaId,@secondaryPaId, @batchId, @requestId
					
					UPDATE Patient_merge_request_queue SET status=2 WHERE pa_merge_reqid=@requestId
					
					INSERT INTO Patient_merge_transaction(pa_merge_reqid,status,created_date)VALUES(@requestid,2,GETDATE())
						
				COMMIT TRANSACTION @TranName
			END
	  END TRY
	  BEGIN CATCH
	    ROLLBACK TRANSACTION @TranName
	   
		UPDATE Patient_merge_request_queue SET status=3 WHERE pa_merge_reqid=@requestId
					
		INSERT INTO Patient_merge_transaction(pa_merge_reqid,status,created_date)VALUES(@requestid,3,GETDATE())
	  
	    DECLARE @bkErrorMessage AS NVARCHAR(4000),@bkErrorSeverity AS INT,@bkErrorState AS INT;
		SELECT 
			@bkErrorMessage = ERROR_MESSAGE(),
			@bkErrorSeverity = ERROR_SEVERITY(),
			@bkErrorState = ERROR_STATE();
			
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','MergePatientByRequestId','Primary PatientId:'+CONVERT(VARCHAR(500),@primaryPaId)+',Secondry PatientId:'+CONVERT(VARCHAR(500),@secondaryPaId),ERROR_LINE ())				   	
		
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
