SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	16-MAR-2017
-- Description:		Copy All History From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyHistoryFromOnePatientToAnother]
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientHistoryCopied = 1)
	BEGIN
		DECLARE @old_pat_hx_id BIGINT  
		DECLARE @new_pat_hx_id as BIGINT				
		
		--Patient_History insertion begins
		
		SET @old_pat_hx_id=0
		SET @new_pat_hx_id=0
		BEGIN
			INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
			SELECT @CopyRef_Id, phx.pat_hx_id, 'Patient_History', GETDATE(),0
			FROM patient_hx phx WITH(NOLOCK)
			LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND phx.pat_hx_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_History'
			WHERE phx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
			
			SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_hx phx WITH(NOLOCK) ON phx.pat_hx_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND phx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_History'	
		
			WHILE @old_pat_hx_id>0 
			BEGIN    
				SET @new_pat_hx_id = 0
				INSERT INTO patient_hx 
							(pat_id,has_nofhx,has_nomedx,has_nosurghx,fhx_dr_id,fhx_last_updated_on,fhx_last_updated_by,medhx_dr_id,medhx_last_updated_on,
							medhx_last_updated_by,surghx_dr_id,surghx_last_updated_on,surghx_last_updated_by)
				SELECT TOP 1 @ToPatientId,has_nofhx,has_nomedx,has_nosurghx,CASE WHEN ISNULL(fhx_dr_id,0)>0 THEN @ToDoctorId ELSE fhx_dr_id END,fhx_last_updated_on,1,
						CASE WHEN ISNULL(medhx_dr_id,0)>0 THEN @ToDoctorId ELSE medhx_dr_id END,medhx_last_updated_on,
						1,CASE WHEN ISNULL(surghx_dr_id,0)>0 THEN @ToDoctorId ELSE surghx_dr_id END,surghx_last_updated_on,1
				FROM patient_hx phx WITH(NOLOCK)
				INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON phx.pat_hx_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_History'
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND phx.pat_hx_id=@old_pat_hx_id AND phx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
				
				SET @new_pat_hx_id = SCOPE_IDENTITY();  
				IF @new_pat_hx_id>0
				BEGIN
					UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pat_hx_id, Is_Copied=1
					WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pat_hx_id AND Type like'Patient_History'
				END
				SET @old_pat_hx_id=0
				SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
				FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
				INNER JOIN patient_hx phx WITH(NOLOCK) ON phx.pat_hx_id=pcdr.Old_DataRef_Id
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND phx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_History'	
	 
			END
		END
		
		--Patient_History Insertion ends
		
		--Patient_Medical_History insertion begins
		
		SET @old_pat_hx_id=0
		SET @new_pat_hx_id=0		
		BEGIN
			INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
			SELECT @CopyRef_Id, pmhx.medhxid, 'Patient_Medical_History', GETDATE(),0
			FROM patient_medical_hx pmhx WITH(NOLOCK)
			LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pmhx.medhxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Medical_History'
			WHERE pmhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
			
			SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_medical_hx pmhx WITH(NOLOCK) ON pmhx.medhxid=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pmhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Medical_History'	
		
			WHILE @old_pat_hx_id>0 
			BEGIN    
				SET @new_pat_hx_id = 0
				INSERT INTO patient_medical_hx 
							(pat_id,problem,icd9,dr_id,added_by_dr_id,created_on,last_modified_on,last_modified_by,comments,enable,
							active,last_modified_date,icd9_description,icd10,icd10_description,snomed,snomed_description)
				SELECT TOP 1 @ToPatientId,problem,icd9,@ToDoctorId,1,created_on,last_modified_on,1,comments,enable,
					active,last_modified_date,icd9_description,icd10,icd10_description,snomed,snomed_description
				FROM patient_medical_hx pmhx WITH(NOLOCK)
				INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pmhx.medhxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Medical_History'
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pmhx.medhxid=@old_pat_hx_id AND pmhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
				
				SET @new_pat_hx_id = SCOPE_IDENTITY();  
				IF @new_pat_hx_id>0
				BEGIN
					UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pat_hx_id, Is_Copied=1
					WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pat_hx_id AND Type like'Patient_Medical_History'
				END
				SET @old_pat_hx_id=0
				SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
				FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
				INNER JOIN patient_medical_hx pmhx WITH(NOLOCK) ON pmhx.medhxid=pcdr.Old_DataRef_Id
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pmhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Medical_History'	
	 
			END
		END
		
		--Patient_Medical_History insertion ends
		
		--Patient_Family_History insertion begins
		
		SET @old_pat_hx_id=0
		SET @new_pat_hx_id=0
		BEGIN
			INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
			SELECT @CopyRef_Id, pfhx.fhxid, 'Patient_Family_History', GETDATE(),0
			FROM patient_family_hx pfhx WITH(NOLOCK)
			LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pfhx.fhxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Family_History'
			WHERE pfhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
			
			SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_family_hx pfhx WITH(NOLOCK) ON pfhx.fhxid=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pfhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Family_History'	
		
			WHILE @old_pat_hx_id>0 
			BEGIN    
				SET @new_pat_hx_id = 0
				INSERT INTO patient_family_hx 
							(pat_id,member_relation_id,problem,icd9,dr_id,added_by_dr_id,created_on,last_modified_on,last_modified_by,comments,
							enable,active,last_modified_date,icd10,icd9_description,icd10_description,snomed,snomed_description)
				
				SELECT TOP 1 @ToPatientId,member_relation_id,problem,icd9,@ToDoctorId,1,created_on,last_modified_on,1,comments,
						enable,active,last_modified_date,icd10,icd9_description,icd10_description,snomed,snomed_description
				FROM patient_family_hx pfhx WITH(NOLOCK)
				INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pfhx.fhxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Family_History'
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pfhx.fhxid=@old_pat_hx_id AND pfhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
				
				SET @new_pat_hx_id = SCOPE_IDENTITY();  
				IF @new_pat_hx_id>0
				BEGIN
					UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pat_hx_id, Is_Copied=1
					WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pat_hx_id AND Type like'Patient_Family_History'
				END
				SET @old_pat_hx_id=0
				SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
				FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
				INNER JOIN patient_family_hx pfhx WITH(NOLOCK) ON pfhx.fhxid=pcdr.Old_DataRef_Id
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pfhx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Family_History'	
	 
			END
		END
		
		--Patient_Family_History insertion ends
		
		--Patient_Social_History insertion begins
		
		SET @old_pat_hx_id=0
		SET @new_pat_hx_id=0
		BEGIN		
			INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
			SELECT @CopyRef_Id, pshx.sochxid, 'Patient_Social_History', GETDATE(),0
			FROM patient_social_hx pshx WITH(NOLOCK)
			LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pshx.sochxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Social_History'
			WHERE pshx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
			
			SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_social_hx pshx WITH(NOLOCK) ON pshx.sochxid=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pshx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Social_History'	
		
			WHILE @old_pat_hx_id>0 
			BEGIN    
				SET @new_pat_hx_id = 0
				INSERT INTO patient_social_hx 
							(pat_id,emp_info,marital_status,other_marital_status,household_people_no,smoking_status,dr_id,added_by_dr_id,
							created_on,last_modified_on,last_modified_by,comments,enable,familyhx_other,medicalhx_other,surgeryhx_other,active)
			
				SELECT 	@ToPatientId,emp_info,marital_status,other_marital_status,household_people_no,smoking_status,@ToDoctorId,1,
						created_on,last_modified_on,1,comments,enable,familyhx_other,medicalhx_other,surgeryhx_other,active
				FROM patient_social_hx pshx WITH(NOLOCK)
				INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pshx.sochxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Social_History'
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pshx.sochxid=@old_pat_hx_id AND pshx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
				
				SET @new_pat_hx_id = SCOPE_IDENTITY();  
				IF @new_pat_hx_id>0
				BEGIN
					UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pat_hx_id, Is_Copied=1
					WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pat_hx_id AND Type like 'Patient_Social_History'
				END
				SET @old_pat_hx_id=0
				SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
				FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
				INNER JOIN patient_social_hx pshx WITH(NOLOCK) ON pshx.sochxid=pcdr.Old_DataRef_Id
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pshx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Social_History'	
	 
			END
		END
		
		--Patient_Social_History insertion ends
		
		--Patient_Social_History insertion begins
		
		SET @old_pat_hx_id=0
		SET @new_pat_hx_id=0
		BEGIN		
			INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
			SELECT @CopyRef_Id, psghx.surghxid, 'Patient_Surgery_History', GETDATE(),0
			FROM patient_surgery_hx psghx WITH(NOLOCK)
			LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND psghx.surghxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Surgery_History'
			WHERE psghx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
			
			SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_surgery_hx psghx WITH(NOLOCK) ON psghx.surghxid=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND psghx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Surgery_History'	
		
			WHILE @old_pat_hx_id>0 
			BEGIN    
				SET @new_pat_hx_id = 0
				INSERT INTO patient_surgery_hx 
							(pat_id,problem,icd9,dr_id,added_by_dr_id,created_on,last_modified_on,last_modified_by,comments,enable,
							icd9_description,icd10,icd10_description,snomed,snomed_description)
					
				SELECT 	@ToPatientId,problem,icd9,@ToDoctorId,1,created_on,last_modified_on,1,comments,enable,
						icd9_description,icd10,icd10_description,snomed,snomed_description
				FROM patient_surgery_hx psghx WITH(NOLOCK)
				INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON psghx.surghxid=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Surgery_History'
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND psghx.surghxid=@old_pat_hx_id AND psghx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
				
				SET @new_pat_hx_id = SCOPE_IDENTITY();  
				IF @new_pat_hx_id>0
				BEGIN
					UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pat_hx_id, Is_Copied=1
					WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pat_hx_id AND Type like 'Patient_Surgery_History'
				END
				SET @old_pat_hx_id=0
				SELECT TOP 1 @old_pat_hx_id=pcdr.Old_DataRef_Id
				FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
				INNER JOIN patient_surgery_hx psghx WITH(NOLOCK) ON psghx.surghxid=pcdr.Old_DataRef_Id
				WHERE pcdr.CopyRef_Id = @CopyRef_Id AND psghx.pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Surgery_History'
	 
			END
		END
		
		--Patient_Social_History insertion ends
	
		UPDATE support.Patients_Copy_Ref_Extended 
		SET PatientHistoryCopied = 1, LastUpdatedOn = GETDATE()
		WHERE CopyRef_Id = @CopyRef_Id 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
