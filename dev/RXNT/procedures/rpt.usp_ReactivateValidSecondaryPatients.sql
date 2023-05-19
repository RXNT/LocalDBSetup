SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to reactivate valid secondary patients
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_ReactivateValidSecondaryPatients]
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
	
		DECLARE @CreatedDate AS DATETIME
		DECLARE @CreatedBy AS BIGINT

		SET @CreatedBy = 1
		SET @CreatedDate = GETDATE()
		
		Select	dg.dc_id, pat.pa_id
		INTO	#TempSecondaryPatients
		From	dbo.Patient_merge_request_queue PMRQ WITH (NOLOCK)
				INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = PMRQ.secondary_pa_id
				INNER JOIN dbo.doc_groups dg WITH (NOLOCK) ON dg.dg_id = -1 * pat.dg_id
		Where	pat.dg_id < 0 and dg.dc_id = @CompanyId

		DECLARE @TempPatientsToUpdate AS TABLE (dc_id BIGINT, pa_id BIGINT)
		--Active Meds
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As ActiveMedCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_active_meds PAM WITH (NOLOCK) ON PAM.pa_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Allergy
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As AllergyCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_new_allergies PMA WITH (NOLOCK) ON PMA.pa_id = SP.pa_id		
		Group By SP.dc_id, SP.pa_id
		having COUNT(*) > 0

		--Prescriptions [Contains -ve pa_id]

		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As PrescriptionsCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.prescriptions PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id	
				INNER JOIN dbo.doc_groups dg WITH (NOLOCK) ON dg.dg_id = -1 * PRE.dg_id
		Group By SP.dc_id, SP.pa_id
		having COUNT(*) > 0

		--Prescriptions [Contains -ve pa_id]

		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*)  As PrescriptionsCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.prescriptions_archive PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id	
				INNER JOIN dbo.doc_groups dg WITH (NOLOCK) ON dg.dg_id = -1 * PRE.dg_id
		Group By SP.dc_id, SP.pa_id
		having COUNT(*) > 0
		--prescription_details
		--prescription_details_archive	

		--Enchanced Encounter [Contains -ve pa_id]
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As EncountersCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.enchanced_encounter PRE WITH (NOLOCK) on PRE.patient_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Enchanced Encounter [Contains -ve pa_id]

		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As EncountersCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.enchanced_encounter_additional_info PRE WITH (NOLOCK) on PRE.patient_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Diagnosis
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As DiagnosisCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_active_diagnosis PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Procedure	
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As ProcedureCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_procedures PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Lab Orders	 [Contains -ve pa_id]
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As LabOrdersCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_lab_orders PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Lab Orders	 [Contains -ve pa_id]
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As LabOrdersCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_lab_orders_master PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Lab Results
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As LabResults
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.lab_pat_details PRE WITH (NOLOCK) on PRE.pat_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Lab Results [Contains -ve pa_id]

		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*)
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.lab_main PRE WITH (NOLOCK) on PRE.pat_id = SP.pa_id
				INNER JOIN dbo.doc_groups dg WITH (NOLOCK) ON dg.dg_id = -1 * PRE.dg_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Vitals [Contains -ve pa_id]
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As VitalsCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.patient_vitals PRE WITH (NOLOCK) on PRE.pa_id = SP.pa_id
				INNER JOIN dbo.doc_groups dg WITH (NOLOCK) ON dg.dg_id = -1 * PRE.dg_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--Immunization
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As ImmunizationCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.tblVaccinationRecord PRE WITH (NOLOCK) on PRE.vac_pat_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id	
		having COUNT(*) > 0

		--patient profile
		Insert into @TempPatientsToUpdate
		(dc_id, pa_id)
		Select	SP.dc_id, SP.pa_id--, COUNT(*) As PatientProfileCount
		From	#TempSecondaryPatients SP WITH (NOLOCK)
				INNER JOIN dbo.PATIENT_PROFILE PRE WITH (NOLOCK) on PRE.patient_id = SP.pa_id
		Group By SP.dc_id, SP.pa_id
		having COUNT(*) > 0
		
		SELECT Distinct dc_id, pa_id Into #PatientsToUpdate FROM @TempPatientsToUpdate

		Update	pat
		SET		pat.dg_id = CASE WHEN pat.dg_id < 0 THEN -1 * pat.dg_id ELSE pat.dg_id END,
				pat.dr_id = CASE WHEN pat.dr_id < 0 THEN -1 * pat.dr_id ELSE pat.dr_id END
		FROM	#PatientsToUpdate PTU 
				INNER JOIN dbo.patients pat WITH (NOLOCK) ON pat.pa_id = PTU.pa_id 
				INNER JOIN dbo.doc_groups DG WITH (NOLOCK) ON DG.dg_id = -1 * pat.dg_id
		WHERE	pat.dg_id < 0	

		UPDATE	PMQ
		SET		PMQ.Comments = ISNULL(PMQ.Comments, '') + ' ' + 'Reactivating the secondary patients since valid data exists',
				PMQ.Modified_By = @CreatedBy,
				PMQ.Modified_Date = @CreatedDate
		FROM	#PatientsToUpdate PTU 
				INNER JOIN dbo.Patient_merge_request_queue PMQ WITH (NOLOCK) ON PMQ.secondary_pa_id = PTU.pa_id
		WHERE	PMQ.status = 2

		SELECT * From #PatientsToUpdate WITH (NOLOCK)
		/*
		DECLARE @TempV2PatientsToUpdate AS TABLE (CompanyId BIGINT, PatientId BIGINT)

		INSERT INTO @TempV2PatientsToUpdate
		SELECT	MPI.CompanyId, MPI.MergeFromPatientId
		FROM	#PatientsToUpdate PTU 
				INNER JOIN [dbo].[RsynMasterPatientExternalAppMaps] PEAM WITH (NOLOCK) ON PEAM.ExternalPatientId = PTU.pa_id AND PEAM.ExternalDoctorCompanyId = PTU.dc_id
				INNER JOIN [dbo].[RsynMasterApplications] APP WITH (NOLOCK) on APP.ApplicationId = PEAM.ExternalAppId AND APP.Code = 'EHRAP'
				INNER JOIN [dbo].[RsynMasterPatientIndexes] MPI WITH (NOLOCK) ON MPI.MergeFromPatientId = PEAM.PatientId
		WHERE	MPI.MergeFromPatientId != MPI.CurrentPatientId

		UPDATE	MPI
		SET		MPI.MergedToPatientId = MPI.MergeFromPatientId, 
				MPI.CurrentPatientId = MPI.MergeFromPatientId,
				MPI.MergedToPersonId = MPI.MergeFromPersonId,
				MPI.CurrentPersonId = MPI.MergeFromPersonId,
				MPI.Comments = ISNULL(MPI.Comments, 0) + ' ' + 'Reactivating the secondary patients in EHR since valid data exists'
		FROM	@TempV2PatientsToUpdate PTU 
				INNER JOIN [dbo].[RsynMasterPatientIndexes] MPI WITH (NOLOCK) ON MPI.MergeFromPatientId = PTU.PatientId AND MPI.CompanyId = PTU.CompanyId
		
		UPDATE	MCA
		SET		MCA.IsMerged = 0
		FROM 	@TempV2PatientsToUpdate PTU 
				INNER JOIN [dbo].[RsynMasterCases] MCA WITH (NOLOCK) ON MCA.PatientId = PTU.PatientId AND MCA.CompanyId = PTU.CompanyId
		WHERE	MCA.IsMerged = 1		
		*/

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
