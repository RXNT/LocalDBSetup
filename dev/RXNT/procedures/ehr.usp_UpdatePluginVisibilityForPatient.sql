SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	JahabarYusuff
Create date			:	15-feb-2023
Description			:	This procedure is used to update the Patient's plugin visibility in PHR
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_UpdatePluginVisibilityForPatient]	
	@PluginVisibility			BIT			= NULL,
	@AutoIncId					BIGINT,
	@PluginName					varchar(50),	
	@PatientId					BIGINT	
AS
BEGIN
	 IF @PluginName = 'ALLERGIES'
		UPDATE patient_new_allergies SET visibility_hidden_to_patient = @PluginVisibility WHERE pa_allergy_id = @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'ACTIVE_MEDICATIONS'
		UPDATE PATIENT_ACTIVE_MEDS SET visibility_hidden_to_patient = @PluginVisibility WHERE PAM_ID =  @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'ACTIVE_DIAGNOSIS'
		UPDATE patient_active_diagnosis SET visibility_hidden_to_patient = @PluginVisibility WHERE pad =  @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'IMMUNIZATION'
		UPDATE tblVaccinationRecord SET visibility_hidden_to_patient = @PluginVisibility WHERE vac_rec_id =  @AutoIncId AND vac_pat_id = @PatientId;
	ELSE IF @PluginName = 'PROCEDURE'
	    UPDATE PATIENT_PROCEDURES SET visibility_hidden_to_patient = @PluginVisibility WHERE procedure_id =  @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'FAMILYHX'
		UPDATE patient_family_hx SET visibility_hidden_to_patient = @PluginVisibility WHERE fhxid =  @AutoIncId AND pat_id = @PatientId;
	ELSE IF @PluginName = 'MEDICALHX'
		UPDATE patient_medical_hx SET visibility_hidden_to_patient = @PluginVisibility WHERE medhxid =  @AutoIncId AND pat_id = @PatientId;
	ELSE IF @PluginName = 'SURGICALHX'
		UPDATE patient_surgery_hx SET visibility_hidden_to_patient = @PluginVisibility WHERE surghxid =  @AutoIncId AND pat_id = @PatientId;
	ELSE IF @PluginName = 'HOSPITALIZATIONHX'
		UPDATE patient_hospitalization_hx SET visibility_hidden_to_patient = @PluginVisibility WHERE hosphxid =  @AutoIncId AND pat_id = @PatientId;
	ELSE IF @PluginName = 'IMPLANTABLEDEVICE'
		UPDATE patientImplantableDevice SET VisibilityHiddenToPatient = @PluginVisibility WHERE PatientImplantableDeviceId =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'ALLERGYHX'
		UPDATE PatientPastHxAllergies SET visibility_hidden_to_patient = @PluginVisibility WHERE PatientPastHxAllergyId =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'MEDICATIONHX'
		UPDATE PatientPastHxMedication SET visibility_hidden_to_patient = @PluginVisibility WHERE PatientPastHxMedicationId =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'SMOKINGSTATUS'
		UPDATE patient_flag_details SET visibility_hidden_to_patient = @PluginVisibility WHERE pa_flag_id =  @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'VITALS'
		UPDATE patient_vitals SET visibility_hidden_to_patient = @PluginVisibility WHERE pa_vt_id =  @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'CARETEAM'
		UPDATE PatientCareTeamMember SET VisibilityHiddenToPatient = @PluginVisibility WHERE Id =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'GOALS'
		UPDATE PatientGoals SET VisibilityHiddenToPatient = @PluginVisibility WHERE Id =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'PLOTR'
		UPDATE PatientCarePlan SET VisibilityHiddenToPatient = @PluginVisibility WHERE Id =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'HELCN'
		UPDATE PatientHealthConcerns SET VisibilityHiddenToPatient = @PluginVisibility WHERE Id =  @AutoIncId AND PatientId = @PatientId;
	ELSE IF @PluginName = 'ENCOUNTER'
		UPDATE enchanced_encounter SET visibility_hidden_to_patient = @PluginVisibility WHERE ENC_ID =  @AutoIncId AND patient_id = @PatientId;
	ELSE IF @PluginName = 'LABORDER'
		UPDATE patient_lab_orders SET VisibilityHiddenToPatient = @PluginVisibility WHERE pa_lab_id =  @AutoIncId AND pa_id = @PatientId;
	ELSE IF @PluginName = 'DOCUMENTS'
		UPDATE patient_documents SET VisibilityHiddenToPatient = @PluginVisibility WHERE document_id =  @AutoIncId AND pat_id = @PatientId;
	ELSE IF @PluginName = 'LABRESULTS'
		UPDATE lab_main SET visibility_hidden_to_patient = @PluginVisibility WHERE lab_id =  @AutoIncId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
