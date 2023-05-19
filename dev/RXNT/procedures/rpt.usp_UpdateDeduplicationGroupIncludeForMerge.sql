SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to update Deduplication Warning Patient
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_UpdateDeduplicationGroupIncludeForMerge]
(
	@CompanyId							BIGINT,
	@DoctorCompanyDeduplicateRequestId	BIGINT,
	@DeduplicationPatientGroupId				BIGINT,
	@IncludeForMerge				BIT,
	@LoggedInUserId						BIGINT,
	@IncludeAll							BIT
)
AS
BEGIN
	SET NOCOUNT ON;	
	DECLARE @CreatedDate AS DATETIME
	DECLARE @CreatedBy AS BIGINT
	
	SET @CreatedDate = GETDATE()

	IF ISNULL(@LoggedInUserId,0)<=0
	BEGIN
		SET @CreatedBy = 1
	END
	ELSE
	BEGIN
		SET @CreatedBy = @LoggedInUserId
	END
	
	IF ISNULL(@IncludeAll, 0) = 0 AND ISNULL(@DeduplicationPatientGroupId, 0) > 0
	BEGIN
		UPDATE	DSP
		SET		DSP.IncludeForMerge = @IncludeForMerge,
				DSP.ModifiedBy = @CreatedBy,
				DSP.ModifiedDate = @CreatedDate
		FROM	rpt.DeduplicationPatientGroups DSP
				INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DSP.ProcessStatusTypeId
																		AND PST.Code = 'PENDG'
		WHERE	DSP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND DSP.DeduplicationPatientGroupId = @DeduplicationPatientGroupId
				AND DSP.CompanyId = @CompanyId
				AND DSP.Active = 1
	END
	ELSE IF ISNULL(@IncludeAll, 0) = 1
	BEGIN
		--ToDo
		UPDATE	DPG
		SET		DPG.IncludeForMerge = @IncludeForMerge,
				DPG.ModifiedBy = @CreatedBy,
				DPG.ModifiedDate = @CreatedDate
		FROM	rpt.DeduplicationPatientGroups DPG
				INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DPG.ProcessStatusTypeId
																		AND PST.Code = 'PENDG'
				LEFT JOIN (Select	DP.DeduplicationPatientGroupId, Count(*) As PatientCount
							FROM	rpt.DeduplicationPatients DP WITH (NOLOCK)
									INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) on DT.DuplicationTypeId = DP.DuplicationTypeId
									INNER JOIN rpt.ProcessStatusTypes PST WITH (NOLOCK) on PST.ProcessStatusTypeId = DP.ProcessStatusTypeId
																							AND PST.Code = 'PENDG'
							WHERE	DP.IncludePatientForMerge = 1 --DT.IsWarning = 1 AND ISNULL(DP.IncludeWarningPatient, 0) = 0
									AND DP.CompanyId = @CompanyId
									AND DP.Active = 1
									AND DP.Level != 1
									AND DP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
							Group By DP.DeduplicationPatientGroupId) DSP ON DSP.DeduplicationPatientGroupId = DPG.DeduplicationPatientGroupId
		WHERE	DPG.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND DPG.CompanyId = @CompanyId
				AND DPG.Active = 1
				AND ((@IncludeForMerge = 1 AND ISNULL(DSP.PatientCount, 0) > 0) OR @IncludeForMerge = 0)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
