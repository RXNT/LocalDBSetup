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
CREATE PROCEDURE [rpt].[usp_InsertDeduplicationPrimaryPatients]
(
	@CompanyId BIGINT,
	@DoctorCompanyDeduplicateRequestId BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @errorMsg NVARCHAR(4000),
			@errorSeverity INT,
			@errorState INT;
	BEGIN TRY
		BEGIN TRAN
	
		DECLARE @ProcessCancelStatusId AS BIGINT
		DECLARE @ProcessPendingStatusId AS BIGINT
		DECLARE @PrimaryPatientCaseCriteriaId AS BIGINT
		DECLARE @PrimaryPatientCaseWithoutPayerCriteriaId AS BIGINT
		DECLARE @PrimaryPatientPrescriptionCriteriaId AS BIGINT
		DECLARE @CreatedDate AS DATETIME
		DECLARE @CreatedBy AS BIGINT

		SET @CreatedBy = 1
		SET @CreatedDate = GETDATE()

		SELECT	@ProcessCancelStatusId = ProcessStatusTypeId
		FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'CANCL'

		SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
		FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'PENDG'

		SELECT	@PrimaryPatientCaseCriteriaId = PrimaryPatientCriteriaTypeId
		FROM	rpt.PrimaryPatientCriteriaTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'CEWIN'

		SELECT	@PrimaryPatientCaseWithoutPayerCriteriaId = PrimaryPatientCriteriaTypeId
		FROM	rpt.PrimaryPatientCriteriaTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'CEWTI'

		SELECT	@PrimaryPatientPrescriptionCriteriaId = PrimaryPatientCriteriaTypeId
		FROM	rpt.PrimaryPatientCriteriaTypes PST WITH (NOLOCK)
		WHERE	PST.Code = 'PRESC'
	
		Select	PEAM.ExternalPatientId, MC.CaseId
		INTO	#Cases
		FROM	[dbo].[RsynMasterCompanyExternalAppMaps] CEAM WITH (NOLOCK)
				INNER JOIN [dbo].[RsynRxNTMasterApplicationsTable] APP WITH (NOLOCK) on APP.ApplicationId = CEAM.ExternalAppId
																					AND App.Code = 'EHRAP'
				INNER JOIN [dbo].[RsynMasterCases] MC WITH (NOLOCK) ON MC.CompanyId = CEAM.CompanyId
																							AND MC.Active = 1
				INNER JOIN [dbo].[RsynMasterPatientIndexes] MPI WITH (NOLOCK) on MPI.MergeFromPatientId = MC.PatientId
																							AND MPI.Active = 1
				INNER JOIN [dbo].[RsynMasterPatientExternalAppMaps] PEAM WITH (NOLOCK) on PEAM.PatientId = MPI.CurrentPatientId
																							AND PEAM.Active = 1
		WHERE	CEAM.ExternalCompanyId = @CompanyId
		
		Select	Distinct MC.ExternalPatientId, MC.CaseId
		INTO	#CasePayers
		FROM	#Cases MC WITH (NOLOCK)
				INNER JOIN [dbo].[RsynMasterCasePayers] MCP WITH (NOLOCK) ON MCP.CaseId = MC.CaseId 
																							AND MCP.Active = 1 
																							AND MCP.PayerExpired = 0

		Select	MC.ExternalPatientId, Count(*) As CntPayerCnt
		INTO	#TempCasePayers
		FROM	#CasePayers MC WITH (NOLOCK)
		Group By MC.ExternalPatientId
		Having Count(*) > 0

		Select	MC.ExternalPatientId, Count(*) As CaseCnt
		INTO	#TempCases
		FROM	#Cases MC
		WHERE	NOT EXISTS (SELECT	Distinct CaseId
								FROM	#CasePayers MCP WITH (NOLOCK)
								WHERE	MCP.CaseId = MC.CaseId )
		Group By MC.ExternalPatientId
		Having Count(*) > 0

		INSERT rpt.DeduplicationPrimaryPatientTransition
		(DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, PrimaryPatientCriteriaTypeId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
		SELECT DISTINCT @DoctorCompanyDeduplicateRequestId, @CompanyId, DCDPT.PatientId, @PrimaryPatientCaseCriteriaId, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
		FROM	rpt.DoctorCompanyDeduplicationPatientTransition DCDPT WITH (NOLOCK)
				INNER JOIN rpt.DoctorCompanyDeduplicationTransition DDT WITH (NOLOCK) on DDT.DoctorCompanyDeduplicationTransitionId = DCDPT.DoctorCompanyDeduplicationTransitionId			
				INNER JOIN #TempCasePayers MC on MC.ExternalPatientId = DCDPT.PatientId
		WHERE	DDT.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId

		INSERT rpt.DeduplicationPrimaryPatientTransition
		(DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, PrimaryPatientCriteriaTypeId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
		SELECT DISTINCT @DoctorCompanyDeduplicateRequestId, @CompanyId, PatientId, @PrimaryPatientPrescriptionCriteriaId, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
		FROM	rpt.DoctorCompanyDeduplicationPatientTransition DCDPT WITH (NOLOCK)
				INNER JOIN rpt.DoctorCompanyDeduplicationTransition DDT WITH (NOLOCK) on DDT.DoctorCompanyDeduplicationTransitionId = DCDPT.DoctorCompanyDeduplicationTransitionId
				INNER JOIN dbo.prescriptions PRE WITH (NOLOCK) on PRE.pa_id = DCDPT.PatientId
		WHERE	DDT.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId

		INSERT rpt.DeduplicationPrimaryPatientTransition
		(DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, PrimaryPatientCriteriaTypeId, ProcessStatusTypeId, Active, CreatedDate, CreatedBy)
		SELECT DISTINCT @DoctorCompanyDeduplicateRequestId, @CompanyId, DCDPT.PatientId, @PrimaryPatientCaseWithoutPayerCriteriaId, @ProcessPendingStatusId, 1, @CreatedDate, @CreatedBy
		FROM	rpt.DoctorCompanyDeduplicationPatientTransition DCDPT WITH (NOLOCK)
				INNER JOIN rpt.DoctorCompanyDeduplicationTransition DDT WITH (NOLOCK) on DDT.DoctorCompanyDeduplicationTransitionId = DCDPT.DoctorCompanyDeduplicationTransitionId			
				INNER JOIN #TempCases MC on MC.ExternalPatientId = DCDPT.PatientId
		WHERE	DDT.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId

		COMMIT TRAN
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
