SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Niyaz
-- Create date: 	15-OCT-2018
-- Description:		Copy Med History From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyFormularyFromOnePatientToAnother]  
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
 IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientFormularyCopied = 1)  
 BEGIN
		DECLARE @old_pci_id BIGINT  
		DECLARE @new_pci_id as BIGINT 
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pci.pci_id, 'Patient_Formulary', GETDATE(),0
		FROM patients_coverage_info pci WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pci.pci_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Formulary'
		WHERE pci.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
		
		
		SELECT TOP 1 @old_pci_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN patients_coverage_info pci WITH(NOLOCK) ON pci.pci_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pci.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Formulary'	
		
		WHILE @old_pci_id>0 
		BEGIN   
			SET @new_pci_id = 0		
			INSERT INTO patients_coverage_info
				(pa_id,ic_group_numb,card_holder_id,card_holder_first,card_holder_mi,card_holder_last,ic_plan_numb,ins_relate_code,ins_person_code,formulary_id,alternative_id,pa_bin,pa_notes,rxhub_pbm_id,pbm_member_id,def_ins_id,mail_order_coverage,retail_pharmacy_coverage,formulary_type,add_date,copay_id,coverage_id,ic_plan_name,PA_ADDRESS1,PA_ADDRESS2,PA_CITY,PA_STATE,PA_ZIP,PA_DOB,PA_SEX,card_suffix,pa_diff_info,longterm_pharmacy_coverage,specialty_pharmacy_coverage,prim_payer,sec_payer,ter_payer,ss_pbm_name,transaction_message_id,PCN)
			SELECT 	TOP 1 @ToPatientId,ic_group_numb,card_holder_id,card_holder_first,card_holder_mi,card_holder_last,ic_plan_numb,ins_relate_code,ins_person_code,formulary_id,alternative_id,pa_bin,pa_notes,rxhub_pbm_id,pbm_member_id,def_ins_id,mail_order_coverage,retail_pharmacy_coverage,formulary_type,add_date,copay_id,coverage_id,ic_plan_name,PA_ADDRESS1,PA_ADDRESS2,PA_CITY,PA_STATE,PA_ZIP,PA_DOB,PA_SEX,card_suffix,pa_diff_info,longterm_pharmacy_coverage,specialty_pharmacy_coverage,prim_payer,sec_payer,ter_payer,ss_pbm_name,transaction_message_id,PCN
			FROM patients_coverage_info pci WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pci.pci_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Patient_Formulary'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pci.pci_id=@old_pci_id AND pci.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pci_id = SCOPE_IDENTITY();  
		    IF @new_pci_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pci_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pci_id AND Type like'Patient_Formulary'
			END
			SET @old_pci_id=0
			SELECT TOP 1 @old_pci_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN patients_coverage_info pci WITH(NOLOCK) ON pci.pci_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pci.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Patient_Formulary'		
 
		END
    
		UPDATE	support.Patients_Copy_Ref_Extended   
			SET PatientFormularyCopied = 1, LastUpdatedOn = GETDATE()  
			WHERE CopyRef_Id = @CopyRef_Id   
 END  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
