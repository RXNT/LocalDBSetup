SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to cancel merge request
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_UpdatePatientMergeRequestBatchStatus]
(
	@CompanyId							BIGINT,
	@LoggedInUserId						BIGINT,
	@PatientMergeRequestBatchId			BIGINT,
	@Status								VARCHAR(100),
	@RequestDate						DATETIME2
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @StatusId AS BIGINT
	DECLARE @PrimaryPatientId AS BIGINT
	DECLARE @SecondaryPatientId AS BIGINT
	DECLARE @MergeQueueId AS BIGINT

	SELECT	@StatusId = StatusId
	FROM	dbo.Patient_merge_status WITH (NOLOCK)
	WHERE	Status = @Status

	Update	dbo.Patient_merge_request_batch 
	Set		status = @StatusId, 
			modified_by = @LoggedInUserId, 
			modified_date = GETDATE() 
	Where	pa_merge_batchid  = @PatientMergeRequestBatchId;

	Update	dbo.Patient_merge_request_queue 
	Set		status = @StatusId, 
			modified_by = @LoggedInUserId, 
			modified_date = GETDATE() 
	Where	pa_merge_batchid = @PatientMergeRequestBatchId;

	IF LOWER(@Status) = 'cancelled'
	BEGIN	
		SELECT  Distinct @PrimaryPatientId = primary_pa_id
		FROM	dbo.Patient_merge_request_queue
		Where	pa_merge_batchid = @PatientMergeRequestBatchId

		DECLARE @ProcessMsg AS VARCHAR(4000)
		
		SET @ProcessMsg = 'Merge Request is cancelled to the Primary Patient ' + CONVERT(VARCHAR(50), @PrimaryPatientId);

		DECLARE mergecursor CURSOR LOCAL FAST_FORWARD FOR
			SELECT  secondary_pa_id, pa_merge_reqid
			FROM	dbo.Patient_merge_request_queue
			Where	pa_merge_batchid = @PatientMergeRequestBatchId;

		OPEN mergecursor
		FETCH NEXT FROM mergecursor into @SecondaryPatientId, @MergeQueueId
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE rpt.usp_UpdateDeduplicationPatientTransitionStatus
						@CompanyId						= @CompanyId,
						@PatientId						= @SecondaryPatientId,
						@ProcessStatusCode				= 'PENDG',
						@ProcessMessage					= @ProcessMsg,
						@DoctorId						= @LoggedInUserId,
						@RequestDate					= @RequestDate,
						@IsPrimary						= 0,
						@PrimaryPatientId				= @PrimaryPatientId,
						@PatientMergeRequestBatchId		= @PatientMergeRequestBatchId,
						@PatientMergeRequestQueueId		= @MergeQueueId

			FETCH NEXT FROM mergecursor into @SecondaryPatientId, @MergeQueueId	
		END
		CLOSE mergecursor
		DEALLOCATE mergecursor

		EXECUTE rpt.usp_UpdateDeduplicationPatientTransitionStatus
					@CompanyId						= @CompanyId,
					@PatientId						= @PrimaryPatientId,
					@ProcessStatusCode				= 'PENDG',
					@ProcessMessage					= @ProcessMsg,
					@DoctorId						= @LoggedInUserId,
					@RequestDate					= @RequestDate,
					@IsPrimary						= 1,
					@PrimaryPatientId				= 0,
					@PatientMergeRequestBatchId		= NULL,
					@PatientMergeRequestQueueId		= NULL
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
