SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Active Meds From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyActiveMedsFromOnePatientToAnother]  
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
 IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientActiveMedsCopied = 1)  
 BEGIN
		DECLARE @old_pam_id BIGINT  
		DECLARE @new_pam_id as BIGINT
		DECLARE @OldDrugId AS BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pam.pam_id, 'Active_Meds', GETDATE(),0
		FROM patient_active_meds pam WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pam.pam_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Active_Meds'
		WHERE pam.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pam_id=pcdr.Old_DataRef_Id, @OldDrugId = ISNULL(pam.drug_id,0)
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patient_active_meds pam WITH(NOLOCK) ON pam.pam_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pam.pam_id=pcdr.Old_DataRef_Id AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Active_Meds'	
	
		WHILE @old_pam_id>0 
		BEGIN    
			SET @new_pam_id = 0
			SELECT TOP 1 @new_pam_id = ISNULL(pam_id,0) FROM patient_active_meds WHERE drug_id=@OldDrugId AND pa_id=@ToPatientId
			IF @new_pam_id > 0 AND @new_pam_id < @old_pam_id
			BEGIN
				DELETE FROM patient_active_meds WHERE pa_id=@ToPatientId AND pam_id=@new_pam_id
				SET @new_pam_id=0
			END
			INSERT INTO patient_active_meds   
				  (pa_id,drug_id,date_added,added_by_dr_id,from_pd_id,compound,comments,status,dt_status_change,change_dr_id,reason,
				  drug_name,dosage,duration_amount,duration_unit,drug_comments,numb_refills,use_generic,days_supply,prn,prn_description,
				  date_start,date_end,for_dr_id,source_type,record_source,active,last_modified_date,last_modified_by )
			SELECT TOP 1 @ToPatientId,pam.drug_id,pam.date_added,1,pam.from_pd_id,pam.compound,pam.comments,pam.status,pam.dt_status_change,CASE WHEN ISNULL(pam.change_dr_id,0)>0 THEN @ToDoctorId ELSE pam.change_dr_id END,pam.reason,
					  pam.drug_name,pam.dosage,pam.duration_amount,pam.duration_unit,pam.drug_comments,pam.numb_refills,pam.use_generic,pam.days_supply,pam.prn,pam.prn_description,
					  pam.date_start,pam.date_end,CASE WHEN ISNULL(pam.for_dr_id,0)>0 THEN @ToDoctorId ELSE pam.for_dr_id END,pam.source_type,pam.record_source,pam.active,pam.last_modified_date,1   
			FROM patient_active_meds pam
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pam.pam_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Active_Meds'
			LEFT OUTER JOIN patient_active_meds pamnew WITH(NOLOCK) ON pam.drug_id=pamnew.drug_id AND pamnew.pa_id=@ToPatientId 
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pam.pam_id=@old_pam_id AND pam.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pam_id = SCOPE_IDENTITY();  
		    IF @new_pam_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pam_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pam_id AND Type like 'Active_Meds'
			END
			SET @old_pam_id=0
			SELECT TOP 1 @old_pam_id=pcdr.Old_DataRef_Id, @OldDrugId = ISNULL(pam.drug_id,0)
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patient_active_meds pam WITH(NOLOCK) ON pam.pam_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pam.pam_id=pcdr.Old_DataRef_Id AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Active_Meds'	
 
		END
    
		UPDATE	support.Patients_Copy_Ref_Extended   
				SET PatientActiveMedsCopied = 1, LastUpdatedOn = GETDATE()  
				WHERE CopyRef_Id = @CopyRef_Id   
 END  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
