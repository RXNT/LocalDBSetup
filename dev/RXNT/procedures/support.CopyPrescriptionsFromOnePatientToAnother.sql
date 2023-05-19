SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	28-MAY-2018
-- Description:		Copy Prescriptions From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyPrescriptionsFromOnePatientToAnother]
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientPrescriptionsCopied = 1)
	BEGIN

		DECLARE @old_pres_id BIGINT  
		DECLARE @new_pres_id as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pr.pres_id, 'Prescriptions', GETDATE(),0
		FROM prescriptions pr WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pr.pres_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Prescriptions'
		WHERE pr.pa_id=@FromPatientId AND pr.pres_approved_date IS NOT NULL AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pres_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN prescriptions pr WITH(NOLOCK) ON pr.pres_id=pcdr.Old_DataRef_Id
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pr.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Prescriptions'	
	
		WHILE @old_pres_id>0 
		BEGIN    
			SET @new_pres_id = 0
			INSERT INTO prescriptions 
				(dr_id,dg_id,pharm_id,pa_id,pres_entry_date,pres_read_date,only_faxed,pharm_viewed,off_dr_list,opener_user_id,
				pres_is_refill,rx_number,last_pharm_name,last_pharm_address,last_pharm_city,last_pharm_state,last_pharm_phone,
				pharm_state_holder,pharm_city_holder,pharm_id_holder,fax_conf_send_date,fax_conf_numb_pages,fax_conf_remote_fax_id,
				fax_conf_error_string,pres_delivery_method,prim_dr_id,print_count,pda_written,authorizing_dr_id,sfi_is_sfi,sfi_pres_id,
				field_not_used1,admin_notes,pres_approved_date,pres_void,last_edit_date,last_edit_dr_id,pres_prescription_type,
				pres_void_comments,eligibility_checked,eligibility_trans_id,off_pharm_list,DoPrintAfterPatHistory,DoPrintAfterPatOrig,
				DoPrintAfterPatCopy,DoPrintAfterPatMonograph,PatOrigPrintType,PrintHistoryBackMonths,DoPrintAfterScriptGuide,approve_source,
				pres_void_code,send_count,print_options,writing_dr_id,presc_src,pres_start_date,pres_end_date,is_signed)
				
			SELECT 	TOP 1 @ToDoctorId,@new_dg_id,pharm_id,@ToPatientId,pres_entry_date,pres_read_date,only_faxed,pharm_viewed,off_dr_list,opener_user_id,
				pres_is_refill,rx_number,last_pharm_name,last_pharm_address,last_pharm_city,last_pharm_state,last_pharm_phone,
				pharm_state_holder,pharm_city_holder,pharm_id_holder,fax_conf_send_date,fax_conf_numb_pages,fax_conf_remote_fax_id,
				fax_conf_error_string,pres_delivery_method,@ToDoctorId,print_count,pda_written,@ToDoctorId,sfi_is_sfi,sfi_pres_id,
				field_not_used1,admin_notes,pres_approved_date,pres_void,last_edit_date,@ToDoctorId,pres_prescription_type,
				pres_void_comments,eligibility_checked,eligibility_trans_id,off_pharm_list,DoPrintAfterPatHistory,DoPrintAfterPatOrig,
				DoPrintAfterPatCopy,DoPrintAfterPatMonograph,PatOrigPrintType,PrintHistoryBackMonths,DoPrintAfterScriptGuide,approve_source,
				pres_void_code,send_count,print_options,@ToDoctorId,presc_src,pres_start_date,pres_end_date,is_signed
			FROM prescriptions pr WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pr.pres_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Prescriptions'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pr.pres_id=@old_pres_id AND pr.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pres_id = SCOPE_IDENTITY();  
		    IF @new_pres_id>0
		    BEGIN
		    
				DECLARE @new_pres_detail_id AS BIGINT
				
				INSERT INTO prescription_details
				(pres_id,ddid,drug_name,ndc,actual,dosage,use_generic,numb_refills,duration_amount,duration_unit,comments,prn,as_directed,
				drug_version,form_status,actual_form_status,history_enabled,patient_delivery_method,vps_pres_id,fax_conf_send_date,fax_conf_numb_pages,
				fax_conf_remote_fax_id,fax_conf_error_string,include_in_print,include_in_pharm_deliver,pres_read_date,fill_date,prn_description,
				script_guide_status,script_guide_id,script_guide_file,compound,icd9,sample_id,voucher_id,days_supply,discharge_date,discharge_desc,
				discharge_dr_id,cancel_status_text,cancel_status,refills_prn,supervisor_info,agent_info,max_daily_dosage,hospice_drug_relatedness_id,
				drug_indication,order_reason,FillReqId,is_dispensed,icd9_desc,pain)
				
				SELECT TOP 1 @new_pres_id,ddid,drug_name,ndc,actual,dosage,use_generic,numb_refills,duration_amount,duration_unit,comments,prn,as_directed,
				drug_version,form_status,actual_form_status,history_enabled,patient_delivery_method,vps_pres_id,pd.fax_conf_send_date,pd.fax_conf_numb_pages,
				pd.fax_conf_remote_fax_id,pd.fax_conf_error_string,include_in_print,include_in_pharm_deliver,pd.pres_read_date,fill_date,prn_description,
				script_guide_status,script_guide_id,script_guide_file,compound,icd9,sample_id,voucher_id,days_supply,discharge_date,discharge_desc,
				discharge_dr_id,cancel_status_text,cancel_status,refills_prn,supervisor_info,agent_info,max_daily_dosage,hospice_drug_relatedness_id,
				drug_indication,order_reason,NULL,is_dispensed,icd9_desc,pain
				FROM prescription_details pd WITH(NOLOCK)
				INNER JOIN prescriptions pr WITH(NOLOCK) ON pd.pres_id=pr.pres_id
				WHERE pr.pres_id=@old_pres_id
				
				SET @new_pres_detail_id = SCOPE_IDENTITY(); 
				 
				INSERT INTO prescription_status 
				(pd_id,delivery_method,response_type,response_text,response_date,confirmation_id,queued_date,cancel_req_response_date,cancel_req_response_type,cancel_req_response_text) 
				SELECT @new_pres_detail_id,ps.delivery_method,ps.response_type,ps.response_text,ps.response_date,ps.confirmation_id,ps.queued_date,ps.cancel_req_response_date,ps.cancel_req_response_type,ps.cancel_req_response_text
				FROM  prescription_status ps WITH(NOLOCK)
				INNER JOIN prescription_details pd WITH(NOLOCK) ON ps.pd_id=pd.pd_id
				INNER JOIN prescriptions p WITH(NOLOCK) ON pd.pres_id=p.pres_id
				WHERE p.pres_id=@old_pres_id
				
			
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pres_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pres_id AND Type like'Prescriptions'
			END
			SET @old_pres_id=0
			
			SELECT TOP 1 @old_pres_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN prescriptions pr WITH(NOLOCK) ON pr.pres_id=pcdr.Old_DataRef_Id
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pr.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Prescriptions'	
 
		END   
		
		UPDATE	support.Patients_Copy_Ref_Extended 
				SET PatientPrescriptionsCopied = 1, LastUpdatedOn = GETDATE()
				WHERE CopyRef_Id = @CopyRef_Id  
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
