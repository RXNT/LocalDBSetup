SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  PROCEDURE [dbo].[InsertPrescription_And_Prescription_Details] 
	@old_dg_id int, 
	@new_dg_id int	

AS
BEGIN

	BEGIN TRAN T1;
	
	SET NOCOUNT ON;
	DECLARE @new_pa_id INTEGER
	DECLARE @old_pa_id INTEGER
	DECLARE @new_dr_id INTEGER
	DECLARE @old_dr_id INTEGER
	DECLARE @old_pres_id INTEGER
	DECLARE @new_pres_id INTEGER	
  
    /* Create a temp table to insert old prescriptions respective to old patient id */
    DECLARE @tempPres TABLE (	pa_id int not null,
								pa_first varchar(150) not null,
								pa_last varchar(150) not null,
								pa_dob smalldatetime null,
								dg_id int not null,
								pres_id int not null	)							

	INSERT INTO @tempPres 
			(	pa_id,
				pa_first,
				pa_last,
				pa_dob,
				dg_id,
				pres_id	)     
	SELECT p.pa_id, pa_first, pa_last, pa_dob,p.dg_id, ps.pres_id FROM patients p 
	INNER JOIN prescriptions ps ON p.pa_id = ps.pa_id
	WHERE p.dg_id =@old_dg_id
    
    /* Declare a cursor to fetch the old patient id resepective to new patient id*/
    DECLARE Patient_records CURSOR
	READ_ONLY
		FOR	
			SELECT	distinct p1.pa_id AS new_pa_id, temp.pa_id as old_pa_id 
			from	patients p1 with(nolock)
			INNER JOIN @tempPres temp	on p1.pa_first = temp.pa_first 
										and p1.pa_last = temp.pa_last 
										and p1.pa_dob = temp.pa_dob
			WHERE p1.dg_id = @new_dg_id 
							
	OPEN Patient_records
	FETCH NEXT FROM Patient_records INTO @new_pa_id, @old_pa_id
	WHILE (@@FETCH_STATUS <> -1)
    BEGIN 
		
		--PRINT  'Starting @new_pa_id ' + convert(varchar(50),@new_pa_id)
		--PRINT  '@old_pa_id ' + convert(varchar(50),@old_pa_id)	
		
		/* Declare a cursor to fetch old prescription id and old doctor id */
		DECLARE Pres_records CURSOR
		READ_ONLY
			FOR	
				SELECT [pres_id] AS old_pres_id, dr_id as old_dr_id FROM [dbo].[prescriptions] WITH(nolock) WHERE 1=1 and pa_id = @old_pa_id
				  
		OPEN Pres_records
		FETCH NEXT FROM Pres_records INTO @old_pres_id, @old_dr_id
		WHILE (@@FETCH_STATUS <> -1)
		BEGIN 
			
			--PRINT  'Starting @old_pres_id print1' + convert(varchar(50),@old_pres_id)	
			--PRINT  '@new_dg_id ' + convert(varchar(50),@new_dg_id)	
			
		   SET @new_dr_id = (SELECT TOP 1 d1.DR_ID 
								FROM DOCTORS d1 
								inner join doctors d2	on d1.dr_first_name = d2.dr_first_name 
														and d1.dr_last_name = d2.dr_last_name 
														WHERE	1=1
														and		d2.DG_ID = @new_dg_id 
														AND		d2.DR_ENABLED = 1 
														AND		d2.PRESCRIBING_AUTHORITY = 4
														and		d1.dr_id = @old_dr_id)
			IF @new_dr_id IS NULL
				SET @new_dr_id = (SELECT TOP 1 d1.DR_ID FROM DOCTORS d1 --inner join doctors d2 on d1.dr_first_name = d2.dr_first_name and d1.dr_last_name = d2.dr_last_name 
											WHERE d1.DG_ID = @new_dg_id AND d1.DR_ENABLED = 1 AND d1.PRESCRIBING_AUTHORITY = 4)
			
			/* Insert into prescriptions table according to old prescription id */
			INSERT INTO [dbo].[prescriptions]
			(dr_id
			 ,dg_id
				  ,[pharm_id]
				  ,pa_id
				  ,[pres_entry_date]
				  ,[pres_read_date]
				  ,[only_faxed]
				  ,[pharm_viewed]
				  ,[off_dr_list]
				  ,[opener_user_id]
				  ,[pres_is_refill]
				  ,[rx_number]
				  ,[last_pharm_name]
				  ,[last_pharm_address]
				  ,[last_pharm_city]
				  ,[last_pharm_state]
				  ,[last_pharm_phone]
				  ,[pharm_state_holder]
				  ,[pharm_city_holder]
				  ,[pharm_id_holder]
				  ,[fax_conf_send_date]
				  ,[fax_conf_numb_pages]
				  ,[fax_conf_remote_fax_id]
				  ,[fax_conf_error_string]
				  ,[pres_delivery_method]
				  ,[prim_dr_id]
				  ,[print_count]
				  ,[pda_written]
				  ,[authorizing_dr_id]
				  ,[sfi_is_sfi]
				  ,[sfi_pres_id]
				  ,[field_not_used1]
				  ,[admin_notes]
				  ,[pres_approved_date]
				  ,[pres_void]
				  ,[last_edit_date]
				  ,[last_edit_dr_id]
				  ,[pres_prescription_type]
				  ,[pres_void_comments]
				  ,[eligibility_checked]
				  ,[eligibility_trans_id]
				  ,[off_pharm_list]
				  ,[DoPrintAfterPatHistory]
				  ,[DoPrintAfterPatOrig]
				  ,[DoPrintAfterPatCopy]
				  ,[DoPrintAfterPatMonograph]
				  ,[PatOrigPrintType]
				  ,[PrintHistoryBackMonths]
				  ,[DoPrintAfterScriptGuide]
				  ,[approve_source]
				  ,[pres_void_code]
				  ,[send_count]
				  ,[print_options]
				  ,[writing_dr_id]
				  ,[presc_src]
				  ,[pres_start_date]
				  ,[pres_end_date]
				  ,[is_signed]
		)
			SELECT @new_dr_id
				  ,@new_dg_id
				  ,[pharm_id]
				  ,@new_pa_id
				  ,[pres_entry_date]
				  ,[pres_read_date]
				  ,[only_faxed]
				  ,[pharm_viewed]
				  ,[off_dr_list]
				  ,[opener_user_id]
				  ,[pres_is_refill]
				  ,[rx_number]
				  ,[last_pharm_name]
				  ,[last_pharm_address]
				  ,[last_pharm_city]
				  ,[last_pharm_state]
				  ,[last_pharm_phone]
				  ,[pharm_state_holder]
				  ,[pharm_city_holder]
				  ,[pharm_id_holder]
				  ,[fax_conf_send_date]
				  ,[fax_conf_numb_pages]
				  ,[fax_conf_remote_fax_id]
				  ,[fax_conf_error_string]
				  ,[pres_delivery_method]
				  ,[prim_dr_id]
				  ,[print_count]
				  ,[pda_written]
				  ,[authorizing_dr_id]
				  ,[sfi_is_sfi]
				  ,[sfi_pres_id]
				  ,[field_not_used1]
				  ,[admin_notes]
				  ,[pres_approved_date]
				  ,[pres_void]
				  ,[last_edit_date]
				  ,[last_edit_dr_id]
				  ,[pres_prescription_type]
				  ,[pres_void_comments]
				  ,[eligibility_checked]
				  ,[eligibility_trans_id]
				  ,[off_pharm_list]
				  ,[DoPrintAfterPatHistory]
				  ,[DoPrintAfterPatOrig]
				  ,[DoPrintAfterPatCopy]
				  ,[DoPrintAfterPatMonograph]
				  ,[PatOrigPrintType]
				  ,[PrintHistoryBackMonths]
				  ,[DoPrintAfterScriptGuide]
				  ,[approve_source]
				  ,[pres_void_code]
				  ,[send_count]
				  ,[print_options]
				  ,[writing_dr_id]
				  ,[presc_src]
				  ,[pres_start_date]
				  ,[pres_end_date]
				  ,[is_signed]
				  FROM [dbo].[prescriptions]
				  WITH(nolock)
				  WHERE 1=1			  
				  and	pres_id = @old_pres_id			
			
			/* get new prescription id for inserted record */ 			
			SET @new_pres_id = SCOPE_IDENTITY() 
			
			--PRINT  '@new_pres_id ' + convert(varchar(50),@new_pres_id)	
    		--PRINT  '@old_pres_id ' + convert(varchar(50),@old_pres_id)	
			
			/* Insert into prescription_details table respective to old prescription id */
			INSERT INTO [dbo].[prescription_details]
			(pres_id
					  ,[ddid]
					  ,[drug_name]
					  ,[ndc]
					  ,[actual]
					  ,[dosage]
					  ,[use_generic]
					  ,[numb_refills]
					  ,[duration_amount]
					  ,[duration_unit]
					  ,[comments]
					  ,[prn]
					  ,[as_directed]
					  ,[drug_version]
					  ,[form_status]
					  ,[actual_form_status]
					  ,[history_enabled]
					  ,[patient_delivery_method]
					  ,[vps_pres_id]
					  ,[fax_conf_send_date]
					  ,[fax_conf_numb_pages]
					  ,[fax_conf_remote_fax_id]
					  ,[fax_conf_error_string]
					  ,[include_in_print]
					  ,[include_in_pharm_deliver]
					  ,[pres_read_date]
					  ,[fill_date]
					  ,[prn_description]
					  ,[script_guide_status]
					  ,[script_guide_id]
					  ,[script_guide_file]
					  ,[compound]
					  ,[icd9]
					  ,[sample_id]
					  ,[voucher_id]
					  ,[days_supply]
					  ,[discharge_date]
					  ,[discharge_desc]
					  ,[discharge_dr_id]
					  ,[cancel_status_text]
					  ,[cancel_status]
					  ,[refills_prn]
					  ,[supervisor_info]
					  ,[agent_info])
				SELECT @new_pres_id
					  ,[ddid]
					  ,[drug_name]
					  ,[ndc]
					  ,[actual]
					  ,[dosage]
					  ,[use_generic]
					  ,[numb_refills]
					  ,[duration_amount]
					  ,[duration_unit]
					  ,[comments]
					  ,[prn]
					  ,[as_directed]
					  ,[drug_version]
					  ,[form_status]
					  ,[actual_form_status]
					  ,[history_enabled]
					  ,[patient_delivery_method]
					  ,[vps_pres_id]
					  ,[fax_conf_send_date]
					  ,[fax_conf_numb_pages]
					  ,[fax_conf_remote_fax_id]
					  ,[fax_conf_error_string]
					  ,[include_in_print]
					  ,[include_in_pharm_deliver]
					  ,[pres_read_date]
					  ,[fill_date]
					  ,[prn_description]
					  ,[script_guide_status]
					  ,[script_guide_id]
					  ,[script_guide_file]
					  ,[compound]
					  ,[icd9]
					  ,[sample_id]
					  ,[voucher_id]
					  ,[days_supply]
					  ,[discharge_date]
					  ,[discharge_desc]
					  ,[discharge_dr_id]
					  ,[cancel_status_text]
					  ,[cancel_status]
					  ,[refills_prn]
					  ,[supervisor_info]
					  ,[agent_info]
				  FROM [dbo].[prescription_details]
				WHERE [pres_id] = @old_pres_id
				
			/*DECLARE @new_pres_detl_id INTEGER			
			SET @new_pres_detl_id = SCOPE_IDENTITY() 			
			PRINT  '@new_pres_detl_id ' + convert(varchar(50),@new_pres_detl_id)*/
			
			FETCH NEXT FROM Pres_records INTO @old_pres_id, @old_dr_id			
		END
		
		CLOSE Pres_records
		DEALLOCATE Pres_records
			  		  
		FETCH NEXT FROM Patient_records INTO @new_pa_id, @old_pa_id
    END  
    
	CLOSE Patient_records
	DEALLOCATE Patient_records
	COMMIT TRAN T1;  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
