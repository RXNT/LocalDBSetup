SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert Patients Deduplications
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_UpdateDeduplicationPatientTransitionStatus]
(
	@CompanyId					BIGINT,
	@PatientId					BIGINT,
	@ProcessStatusCode			VARCHAR(5),
	@ProcessMessage				VARCHAR(4000),
	@PatientMergeRequestBatchId BIGINT,
	@PatientMergeRequestQueueId BIGINT,
	@DoctorId					BIGINT,
	@RequestDate				DATETIME,
	@IsPrimary					BIT,
	@PrimaryPatientId			BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @ProcessStatusId AS BIGINT	
	DECLARE @ExistingPrimaryPatientId AS BIGINT
	DECLARE @ProcessPendingStatusId AS BIGINT
	DECLARE @DoctorCompanyRequestId AS BIGINT
	DECLARE @DeduplicationPatientGroupId AS BIGINT
	DECLARE @DeduplicationPatientId AS BIGINT
	DECLARE @ProcessCancelStatusId AS BIGINT
	
	SELECT	TOP 1 @DoctorCompanyRequestId = DoctorCompanyDeduplicateRequestId
	FROM	rpt.DoctorCompanyDeduplicateRequests DCDR WITH (NOLOCK)
			INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DCDR.ProcessStatusTypeId
																AND PST.Code = 'SUCES'
	WHERE	CompanyId = @CompanyId
	ORDER BY DoctorCompanyDeduplicateRequestId DESC

	SELECT	@ProcessStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = @ProcessStatusCode

	SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'PENDG'

	SELECT	@ProcessCancelStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'CANCL'
						
	/*Get the Secondary Patient Key */
	SET @DeduplicationPatientId = 0

	SELECT	@DeduplicationPatientId =  DeduplicationPatientId
	FROM	rpt.DeduplicationPatients WITH (NOLOCK)
	WHERE	PatientId = @PatientId
			AND CompanyId = @CompanyId
			AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
			AND Active = 1
			AND ProcessStatusTypeId = @ProcessPendingStatusId
	
	/*Get the Primary Patient Key*/
	SELECT	@DeduplicationPatientGroupId = DeduplicationPatientGroupId 
	FROM	rpt.DeduplicationPatients WITH (NOLOCK)
	WHERE	PatientId = @PatientId
			AND CompanyId = @CompanyId
			AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
			AND Active = 1

	IF (@IsPrimary = 1 AND NOT EXISTS (SELECT NULL
						FROM	rpt.DeduplicationPatients
						WHERE	DeduplicationPatientGroupId = @DeduplicationPatientGroupId
								AND CompanyId = @CompanyId
								AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
								AND ProcessStatusTypeId = @ProcessPendingStatusId
								AND Active = 1
								AND Level != 1)) OR @IsPrimary = 0
	BEGIN
		UPDATE	rpt.DeduplicationPatients
		SET		ProcessStatusTypeId = @ProcessStatusId,
				ProcessStartDate = CASE WHEN @ProcessStatusCode = 'INPRG' THEN GETDATE() ELSE ProcessStartDate END,
				ProcessEndDate = CASE WHEN @ProcessStatusCode != 'INPRG' THEN GETDATE() ELSE ProcessEndDate END,
				ProcessStatusMessage = ISNULL(ProcessStatusMessage, '') + ',' + @ProcessMessage,
				ModifiedBy = @DoctorId,
				ModifiedDate = @RequestDate
		WHERE	PatientId = @PatientId
				AND CompanyId = @CompanyId
				AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
	END

	IF @ProcessStatusCode = 'MGRQC' /*If the status is Merge Request Created*/
	BEGIN
		IF ISNULL(@PatientMergeRequestBatchId,0) > 0 AND ISNULL(@PatientMergeRequestQueueId, 0) > 0 AND ISNULL(@DeduplicationPatientId, 0) > 0
		BEGIN
			INSERT INTO rpt.DeduplicationMergePatients
			(DoctorCompanyDeduplicateRequestId, DeduplicationPatientId, CompanyId, ProcessStatusTypeId, PatientMergeRequestBatchId, PatientMergeRequestQueueId, Active, CreatedDate, CreatedBy)
			VALUES (@DoctorCompanyRequestId, @DeduplicationPatientId, @CompanyId, @ProcessPendingStatusId, @PatientMergeRequestBatchId, @PatientMergeRequestQueueId, 1, GetDate(), @DoctorId)
		END	
	END
	ELSE
	BEGIN
		/*Get the Secondary Patient Key */
		SET @DeduplicationPatientId = 0

		SELECT	@DeduplicationPatientId =  DeduplicationPatientId
		FROM	rpt.DeduplicationPatients WITH (NOLOCK)
		WHERE	PatientId = @PatientId
				AND CompanyId = @CompanyId
				AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
				AND Active = 1
	
		IF ISNULL(@DeduplicationPatientId, 0) > 0
		BEGIN		
			UPDATE	rpt.DeduplicationMergePatients
			SET		ProcessStatusTypeId = CASE WHEN @ProcessStatusCode = 'PENDG' THEN @ProcessCancelStatusId ELSE @ProcessStatusId END,
					ProcessStartDate = CASE WHEN @ProcessStatusCode = 'INPRG' THEN GETDATE() ELSE ProcessStartDate END,
					ProcessEndDate = CASE WHEN @ProcessStatusCode != 'INPRG' THEN GETDATE() ELSE ProcessEndDate END,
					ProcessStatusMessage = @ProcessMessage,
					ModifiedBy = @DoctorId,
					ModifiedDate = @RequestDate
			WHERE	DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId	
					AND DeduplicationPatientId = @DeduplicationPatientId 
					AND CompanyId = @CompanyId
		END
	END

	IF (@ProcessStatusCode = 'MGRQC' AND NOT EXISTS (SELECT NULL
						FROM	rpt.DeduplicationPatients
						WHERE	DeduplicationPatientGroupId = @DeduplicationPatientGroupId
								AND CompanyId = @CompanyId
								AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
								AND ProcessStatusTypeId = @ProcessPendingStatusId
								AND Active = 1
								AND Level != 1)) OR @ProcessStatusCode != 'MGRQC'
	BEGIn	
		UPDATE	rpt.DeduplicationPatientGroups
		SET		ProcessStatusTypeId = @ProcessStatusId,
				ProcessStartDate = CASE WHEN @ProcessStatusCode = 'INPRG' THEN GETDATE() ELSE ProcessStartDate END,
				ProcessEndDate = CASE WHEN @ProcessStatusCode != 'INPRG' THEN GETDATE() ELSE ProcessEndDate END,
				ProcessStatusMessage = ISNULL(ProcessStatusMessage, '') + @ProcessMessage,
				ModifiedBy = @DoctorId,
				ModifiedDate = @RequestDate
		WHERE	DeduplicationPatientGroupId = @DeduplicationPatientGroupId
				AND CompanyId = @CompanyId
				AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
	END

	UPDATE	rpt.DeduplicationPrimaryPatientTransition
	SET		ProcessStatusTypeId = @ProcessStatusId,
			ProcessStartDate = CASE WHEN @ProcessStatusCode = 'INPRG' THEN GETDATE() ELSE ProcessStartDate END,
			ProcessEndDate = CASE WHEN @ProcessStatusCode != 'INPRG' THEN GETDATE() ELSE ProcessEndDate END,
			ProcessStatusMessage = @ProcessMessage,
			ModifiedBy = @DoctorId,
			ModifiedDate = @RequestDate
	WHERE	PatientId = @PatientId
			AND CompanyId = @CompanyId
			AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId

	UPDATE
			DPT
	SET
			DPT.ProcessStatusTypeId = @ProcessStatusId,
			DPT.ProcessStartDate = CASE WHEN @ProcessStatusCode = 'INPRG' THEN GETDATE() ELSE DPT.ProcessStartDate END,
			DPT.ProcessEndDate = CASE WHEN @ProcessStatusCode != 'INPRG' THEN GETDATE() ELSE DPT.ProcessEndDate END,
			DPT.ProcessStatusMessage = @ProcessMessage,
			DPT.ModifiedBy = @DoctorId,
			DPT.ModifiedDate = @RequestDate
	FROM	rpt.DoctorCompanyDeduplicationPatientTransition AS DPT
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition AS DT ON DT.DoctorCompanyDeduplicationTransitionId = DPT.DoctorCompanyDeduplicationTransitionId
	WHERE	DPT.PatientId = @PatientId
			AND DPT.CompanyId = @CompanyId
			AND DT.DoctorCompanyDeduplicateRequestId = @DoctorCompanyRequestId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
