SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Vitals From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyVitalsFromOnePatientToAnother]
  @FromPatientId			BIGINT,
  @ToPatientId				BIGINT,
  @ToDoctorId				BIGINT
AS
BEGIN
	DECLARE @CopyRef_Id AS BIGINT
	DECLARE @new_dg_id AS BIGINT
	DECLARE @new_dc_id AS BIGINT
	
	SELECT @new_dg_id = dg_id FROM doctors WHERE dr_id=@ToDoctorId				
	SELECT @new_dc_id = dc_id FROM doc_groups WHERE dg_id=@new_dg_id	

	SELECT @CopyRef_Id = CopyRef_Id 
	FROM support.Patients_Copy_Ref coa WITH(NOLOCK) 
	WHERE coa.New_DCID = @new_dc_id  AND coa.Old_PatID = @FromPatientId
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientVitalsCopied = 1)
	BEGIN
		DECLARE @old_pa_vt_id BIGINT  
		DECLARE @new_pa_vt_id as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pv.pa_vt_id, 'Patient_Vitals', GETDATE(),0
		FROM patient_vitals pv WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pv.pa_vt_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Vitals'
		WHERE pv.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pa_vt_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patient_vitals pv WITH(NOLOCK) ON pv.pa_vt_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pv.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Vitals'	
	
		WHILE @old_pa_vt_id>0 
		BEGIN    
			SET @new_pa_vt_id = 0
			INSERT INTO patient_vitals 
						(pa_id,pa_wt,pa_ht,pa_pulse,pa_bp_sys,pa_bp_dys,pa_glucose,pa_resp_rate,pa_temp,pa_bmi,age,date_added,dg_id,added_by,added_for,record_date,
						pa_oxm,record_modified_date,pa_hc,pa_bp_location,pa_bp_sys_statnding,pa_bp_dys_statnding,pa_bp_location_statnding,pa_bp_sys_supine,
						pa_bp_dys_supine,pa_bp_location_supine,pa_temp_method,pa_pulse_rhythm,pa_pulse_standing,pa_pulse_rhythm_standing,pa_pulse_supine,
						pa_pulse_rhythm_supine,pa_heart_rate,pa_fio2,pa_flow,pa_resp_quality,pa_comment,active,last_modified_date,last_modified_by)
			SELECT 	@ToPatientId,pa_wt,pa_ht,pa_pulse,pa_bp_sys,pa_bp_dys,pa_glucose,pa_resp_rate,pa_temp,pa_bmi,age,date_added,@new_dg_id,1,CASE WHEN ISNULL(added_for,0)>0 THEN @ToDoctorId ELSE added_for END,record_date,
					pa_oxm,record_modified_date,pa_hc,pa_bp_location,pa_bp_sys_statnding,pa_bp_dys_statnding,pa_bp_location_statnding,pa_bp_sys_supine,
					pa_bp_dys_supine,pa_bp_location_supine,pa_temp_method,pa_pulse_rhythm,pa_pulse_standing,pa_pulse_rhythm_standing,pa_pulse_supine,
					pa_pulse_rhythm_supine,pa_heart_rate,pa_fio2,pa_flow,pa_resp_quality,pa_comment,active,last_modified_date,1
			FROM patient_vitals pv WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pv.pa_vt_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Vitals'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pv.pa_vt_id=@old_pa_vt_id AND pv.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pa_vt_id = SCOPE_IDENTITY();  
		    IF @new_pa_vt_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pa_vt_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pa_vt_id AND Type like'Patient_Vitals'
			END
			SET @old_pa_vt_id=0
			SELECT TOP 1 @old_pa_vt_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_vitals pv WITH(NOLOCK) ON pv.pa_vt_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pv.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Vitals'		
 
		END		
		
		UPDATE support.Patients_Copy_Ref_Extended 
		SET PatientVitalsCopied = 1, LastUpdatedOn = GETDATE()
		WHERE CopyRef_Id = @CopyRef_Id 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
