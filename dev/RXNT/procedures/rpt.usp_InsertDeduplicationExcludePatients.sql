SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	17-Apr-2017
Description			:	This procedure is used to insert exclude patients combination
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplicationExcludePatients]
(
	@CompanyId			BIGINT,
	@PrimaryPatientId	BIGINT,
	@SecondaryPatientId	BIGINT,
	@DoctorCompanyDeduplicateRequestId BIGINT,
	@LoggedInUserId		BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ProcessPendingStatusId AS BIGINT
	DECLARE @ProcessCancelStatusId AS BIGINT
	DECLARE @CreatedDate AS DATETIME2
	DECLARE @CreatedBy AS BIGINT

	SET @CreatedBy = @LoggedInUserId
	SET @CreatedDate = GETDATE()

	SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'PENDG'
	
	IF NOT EXISTS (	SELECT NULL FROM rpt.DeduplicationExcludePatients WITH (NOLOCK) 
					WHERE	CompanyId = @CompanyId 
							AND PrimaryPatientId = @PrimaryPatientId 
							AND SecondaryPatientId = @SecondaryPatientId 
							AND Active  = 1
							AND ProcessStatusTypeId = @ProcessPendingStatusId)
	BEGIN
		INSERT INTO rpt.DeduplicationExcludePatients
		(DoctorCompanyDeduplicateRequestId, CompanyId, PrimaryPatientId, SecondaryPatientId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
		VALUES (@DoctorCompanyDeduplicateRequestId, @CompanyId, @PrimaryPatientId, @SecondaryPatientId, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy)

		SELECT	@ProcessCancelStatusId = ProcessStatusTypeId
		FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'CANCL'

		UPDATE	rpt.DeduplicationPatients
		SET		ProcessStatusTypeId = @ProcessCancelStatusId,
				ProcessStatusMessage = 'Patient is excluded',
				ModifiedBy = @LoggedInUserId,
				ModifiedDate = @CreatedDate
		WHERE	PatientId = @SecondaryPatientId
				AND CompanyId = @CompanyId
				AND DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND ProcessStatusTypeId = @ProcessPendingStatusId
	END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
