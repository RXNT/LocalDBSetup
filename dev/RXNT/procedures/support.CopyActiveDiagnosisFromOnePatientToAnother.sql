SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Active Diagnosis From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyActiveDiagnosisFromOnePatientToAnother]
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientActiveDiagnosisCopied = 1)
	BEGIN

		DECLARE @old_pad BIGINT  
		DECLARE @new_pad as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pd.pad, 'Diagnosis', GETDATE(),0
		FROM patient_active_diagnosis pd WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pd.pad=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Diagnosis'
		WHERE pd.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pad=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patient_active_diagnosis pd WITH(NOLOCK) ON pd.pad=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pd.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Diagnosis'	
	
		WHILE @old_pad>0 
		BEGIN    
			SET @new_pad = 0
			INSERT INTO patient_active_diagnosis 
				(pa_id,icd9,added_by_dr_id,date_added,icd9_description,enabled,onset,severity,status,type,record_modified_date,source_type,record_source,status_date,code_type,active,last_modified_date,last_modified_by,icd10,icd10_desc,icd9_desc,snomed_code,snomed_desc,diagnosis_sequence)
			SELECT 	TOP 1 @ToPatientId,icd9,1,date_added,icd9_description,enabled,onset,severity,status,pd.type,record_modified_date,source_type,record_source, status_date,code_type,active,last_modified_date,1,icd10,icd10_desc,icd9_desc,snomed_code,snomed_desc,diagnosis_sequence
			FROM patient_active_diagnosis pd WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pd.pad=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Diagnosis'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pd.pad=@old_pad AND pd.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pad = SCOPE_IDENTITY();  
		    IF @new_pad>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pad, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pad AND Type like'Diagnosis'
			END
			SET @old_pad=0
			SELECT TOP 1 @old_pad=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_active_diagnosis pd WITH(NOLOCK) ON pd.pad=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pd.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Diagnosis'		
 
		END   
		
		UPDATE	support.Patients_Copy_Ref_Extended 
				SET PatientActiveDiagnosisCopied = 1, LastUpdatedOn = GETDATE()
				WHERE CopyRef_Id = @CopyRef_Id  
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
