SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Procedures From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyProceduresFromOnePatientToAnother]
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientProceduresCopied = 1)
	BEGIN
		DECLARE @old_procedure_id BIGINT  
		DECLARE @new_procedure_id as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pa_proc.procedure_id, 'Procedures', GETDATE(),0
		FROM patient_procedures pa_proc WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pa_proc.procedure_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Procedures'
		WHERE pa_proc.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_procedure_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patient_procedures pa_proc WITH(NOLOCK) ON pa_proc.procedure_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pa_proc.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Procedures'	
	
		WHILE @old_procedure_id>0 
		BEGIN    
			SET @new_procedure_id = 0
			INSERT INTO patient_procedures 
						(pa_id,dr_id,date_performed,type,status,code,description,notes,record_modified_date,date_performed_to,active,last_modified_date,last_modified_by)
			SELECT TOP 1 @ToPatientId,@ToDoctorId,date_performed,pa_proc.type,status,code,description,notes,record_modified_date,date_performed_to,active,last_modified_date,1
			FROM patient_procedures pa_proc WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pa_proc.procedure_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Procedures'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pa_proc.procedure_id=@old_procedure_id AND pa_proc.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_procedure_id = SCOPE_IDENTITY();  
		    IF @new_procedure_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_procedure_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_procedure_id AND Type like'Procedures'
			END
			SET @old_procedure_id=0
			SELECT TOP 1 @old_procedure_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_procedures pa_proc WITH(NOLOCK) ON pa_proc.procedure_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pa_proc.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Procedures'		
 
		END
		
		UPDATE support.Patients_Copy_Ref_Extended 
		SET PatientProceduresCopied = 1, LastUpdatedOn = GETDATE()
		WHERE CopyRef_Id = @CopyRef_Id 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
