SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to create merge request for Patients Deduplications
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_CreateMergePatientsRequest]
(
	@CompanyId						BIGINT,
	@DoctorId						BIGINT,
	@BatchName						VARCHAR(100),
	@PrimaryPatientId				BIGINT,
	@SecondaryPatientIds			XML,
	@RequestDate					DATETIME2
)
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @SecondaryPatientId AS BIGINT
	DECLARE @MergeStatusId As BIGINT
	DECLARE @MergeRequestId AS BIGINT
	DECLARE @MergeQueueId AS BIGINT
	
	DECLARE @errorMsg NVARCHAR(4000),
			@errorSeverity INT,
			@errorState INT;
	
	SELECT  @MergeStatusId = StatusId
	FROM	dbo.Patient_merge_status
	WHERE	Status = 'Pending'

	BEGIN TRY
		BEGIN TRAN
		DECLARE @ProcessMsg AS VARCHAR(4000)
		
		INSERT INTO dbo.Patient_merge_request_batch (dc_id,created_by,created_date,active,batch_name,status)
		VALUES (@CompanyId, @DoctorId, @RequestDate, 1, @BatchName, @MergeStatusId)
		
		SELECT @MergeRequestId = Scope_Identity();
		
		SET @ProcessMsg = 'Merge Request is created to the Primary Patient ' + CONVERT(VARCHAR(50), @PrimaryPatientId) + ' , Merge Request Id: ' + CONVERT(VARCHAR(50), @MergeRequestId);

		DECLARE mergecursor CURSOR LOCAL FAST_FORWARD FOR
			SELECT  A.S.value('(text())[1]', 'BIGINT') AS 'SecondaryPatientId'
					FROM @SecondaryPatientIds.nodes('ArrayOfLong/long') A(S);

		OPEN mergecursor
		FETCH NEXT FROM mergecursor into @SecondaryPatientId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO Patient_merge_request_queue (pa_merge_batchid,primary_pa_id,secondary_pa_id,created_by,created_date,active,status)
			VALUES(@MergeRequestId, @PrimaryPatientId, @SecondaryPatientId, @DoctorId, @RequestDate, 1, @MergeStatusId)
			
			SELECT @MergeQueueId = Scope_Identity();

			EXECUTE rpt.usp_UpdateDeduplicationPatientTransitionStatus
						@CompanyId			= @CompanyId,
						@PatientId			= @SecondaryPatientId,
						@ProcessStatusCode	= 'MGRQC',
						@ProcessMessage		= @ProcessMsg,
						@PatientMergeRequestBatchId	= @MergeRequestId,
						@PatientMergeRequestQueueId	= @MergeQueueId,
						@DoctorId = @DoctorId,
						@RequestDate				= @RequestDate,
						@IsPrimary						= 0,
						@PrimaryPatientId = @PrimaryPatientId

			FETCH NEXT FROM mergecursor into @SecondaryPatientId	
		END
		CLOSE mergecursor
		DEALLOCATE mergecursor
		IF @@ERROR <> 0 --If any error rollback transaction
		BEGIN
			SET @errorMsg =  'Error Procedure:' + ERROR_PROCEDURE() + ',  ' 
			+ 'Error Line:' + CAST(ERROR_LINE() AS VARCHAR(50)) + ',  '
			+ 'Error Message:' + ERROR_MESSAGE()
			SET @errorSeverity = ERROR_SEVERITY();
			SET @errorState = ERROR_STATE();
			RAISERROR (@errorMsg, @errorSeverity, @errorState);
			ROLLBACK TRAN
		END
		ELSE
		BEGIN
			EXECUTE rpt.usp_UpdateDeduplicationPatientTransitionStatus
						@CompanyId			= @CompanyId,
						@PatientId			= @PrimaryPatientId,
						@ProcessStatusCode	= 'MGRQC',
						@ProcessMessage		= @ProcessMsg,
						@PatientMergeRequestBatchId	= NULL,
						@PatientMergeRequestQueueId	= NULL,
						@DoctorId = @DoctorId,
						@RequestDate				= @RequestDate,
						@IsPrimary						= 1,
						@PrimaryPatientId = 0

			COMMIT TRAN
		END
	END TRY
	BEGIN CATCH
		SET @errorMsg =  'Error Procedure:' + ERROR_PROCEDURE() + ',  ' 
		+ 'Error Line:' + CAST(ERROR_LINE() AS VARCHAR(50)) + ',  '
		+ 'Error Message:' + ERROR_MESSAGE()
		SET @errorSeverity = ERROR_SEVERITY();
		SET @errorState = ERROR_STATE();
		RAISERROR (@errorMsg, @errorSeverity, @errorState);
		ROLLBACK TRAN
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
