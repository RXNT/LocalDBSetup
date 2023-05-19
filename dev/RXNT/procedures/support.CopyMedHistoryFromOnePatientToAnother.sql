SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Niyaz
-- Create date: 	15-OCT-2018
-- Description:		Copy Med History From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyMedHistoryFromOnePatientToAnother]  
  @FromPatientId   BIGINT,  
  @ToPatientId    BIGINT,  
  @ToDoctorId    BIGINT  
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
 IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientMedHxCopied = 1)  
 BEGIN
		DECLARE @old_pam_id BIGINT  
		DECLARE @new_pam_id as BIGINT 
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, medhx.id, 'Patient_MedHistory', GETDATE(),0
		FROM surescript_medHx_messages medhx WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND medhx.id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_MedHistory'
		WHERE medhx.patientid=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
		
		
		SELECT TOP 1 @old_pam_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN surescript_medHx_messages medhx WITH(NOLOCK) ON medhx.id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND medhx.patientid=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_MedHistory'	
		
		WHILE @old_pam_id>0 
		BEGIN   
			SET @new_pam_id = 0		
			INSERT INTO surescript_medHx_messages
				(drid,patientid, requestid, responseid, startdate, enddate, request, response,createddate,request_type)
			SELECT 	TOP 1 @ToDoctorId,@ToPatientId, requestid,responseid, startdate, enddate, request, response,createddate,request_type
			FROM surescript_medHx_messages medhx WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON medhx.id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_MedHistory'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND medhx.id=@old_pam_id AND medhx.patientid=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pam_id = SCOPE_IDENTITY();  
		    IF @new_pam_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pam_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pam_id AND Type like'Patient_MedHistory'
			END
			SET @old_pam_id=0
			SELECT TOP 1 @old_pam_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN surescript_medHx_messages medhx WITH(NOLOCK) ON medhx.id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND medhx.patientid=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_MedHistory'		
 
		END
    
		UPDATE	support.Patients_Copy_Ref_Extended   
				SET PatientMedHxCopied = 1, LastUpdatedOn = GETDATE()  
				WHERE CopyRef_Id = @CopyRef_Id   
 END  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
