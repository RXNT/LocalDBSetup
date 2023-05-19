SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Allergies From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyAllergiesFromOnePatientToAnother]
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientAllergiesCopied = 1)
	BEGIN
		DECLARE @old_pa_allergy_id BIGINT  
		DECLARE @new_pa_allergy_id as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pna.pa_allergy_id, 'Allergies', GETDATE(),0
		FROM patient_new_allergies pna WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pna.pa_allergy_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Allergies'
		WHERE pna.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pa_allergy_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patient_new_allergies pna WITH(NOLOCK) ON pna.pa_allergy_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pna.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Allergies'	
	
		WHILE @old_pa_allergy_id>0 
		BEGIN    
			SET @new_pa_allergy_id = 0
			INSERT INTO patient_new_allergies 
						(pa_id,allergy_id,allergy_type,add_date,comments,reaction_string,status,dr_modified_user,disable_date,source_type,
						allergy_description,record_source,active,last_modified_date,last_modified_by)
			SELECT 	@ToPatientId,allergy_id,allergy_type,add_date,comments,reaction_string,status,CASE WHEN ISNULL(dr_modified_user,0)>0 THEN 1 ELSE dr_modified_user END,
					disable_date,source_type,allergy_description,record_source,active,last_modified_date,1
			FROM patient_new_allergies pna WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pna.pa_allergy_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Allergies'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pna.pa_allergy_id=@old_pa_allergy_id AND pna.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pa_allergy_id = SCOPE_IDENTITY();  
		    IF @new_pa_allergy_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pa_allergy_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pa_allergy_id AND Type LIKE 'Allergies'
			END
			SET @old_pa_allergy_id=0
			SELECT TOP 1 @old_pa_allergy_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_new_allergies pna WITH(NOLOCK) ON pna.pa_allergy_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pna.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Allergies'		
 
		END   
		
		UPDATE support.Patients_Copy_Ref_Extended 
		SET PatientAllergiesCopied = 1, LastUpdatedOn = GETDATE()
		WHERE CopyRef_Id = @CopyRef_Id 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
