SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyPatientNotesFromOnePatientToAnother]
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientNotesCopied = 1)
	BEGIN

		DECLARE @old_pan BIGINT  
		DECLARE @new_pan as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pn.note_id, 'Patient_Notes', GETDATE(),0
		FROM patient_notes pn WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pn.note_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Notes'
		WHERE pn.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pan=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patient_notes pn WITH(NOLOCK) ON pn.note_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pn.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Notes'	
	
		WHILE @old_pan>0 
		BEGIN    
			SET @new_pan = 0		
			INSERT INTO patient_notes
				(pa_id,note_date, dr_id, void, note_text, partner_id, note_html)
			SELECT 	TOP 1 @ToPatientId, note_date,@ToDoctorId, void, note_text, partner_id, note_html
			FROM patient_notes pn WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pn.note_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Notes'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pn.note_id=@old_pan AND pn.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pan = SCOPE_IDENTITY();  
		    IF @new_pan>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pan, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pan AND Type like'Patient_Notes'
			END
			SET @old_pan=0
			SELECT TOP 1 @old_pan=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_notes pn WITH(NOLOCK) ON pn.note_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pn.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Notes'		
 
		END   
		
		UPDATE	support.Patients_Copy_Ref_Extended 
				SET PatientNotesCopied = 1, LastUpdatedOn = GETDATE()
				WHERE CopyRef_Id = @CopyRef_Id  
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
