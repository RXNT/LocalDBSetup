SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[mergePatients]
	(@new_id INTEGER,
  @deleted_id INTEGER)
AS
BEGIN
	
	  IF EXISTS(SELECT pa_id FROM patients WITH(NOLOCK) WHERE pa_id=@new_id) 
	  AND EXISTS(SELECT pa_id FROM patients WITH(NOLOCK) WHERE pa_id=@deleted_id)
	  BEGIN
	  -- Backup Tables start
	  BEGIN TRY
	   INSERT INTO [bk].[patients]
			   ([pa_id],[pa_field_not_used1],[dg_id],[dr_id],[pa_first],[pa_middle],[pa_last],[pa_ssn],[pa_dob],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip]
			   ,[pa_phone],[pa_wgt],[pa_sex],[ic_id],[ic_group_numb],[card_holder_id],[card_holder_first],[card_holder_mi],[card_holder_last],[ic_plan_numb],[ins_relate_code]
			   ,[ins_person_code],[formulary_id],[alternative_id],[pa_bin],[primary_pharm_id],[pa_notes],[ph_drugs],[pa_email],[pa_ext],[rxhub_pbm_id],[pbm_member_id],[def_ins_id]
			   ,[last_check_date],[check_eligibility],[sfi_is_sfi],[sfi_patid],[pa_ht],[pa_upd_stat],[pa_flag],[pa_ext_id],[access_date],[access_user],[pa_ins_type],[pa_race_type]
			   ,[pa_ethn_type],[pref_lang],[add_date],[add_by_user],[record_modified_date],[pa_ext_ssn_no],[pa_prefix],[pa_suffix],[active],[last_modified_date],[last_modified_by]
			   ,[created_date])
           (SELECT [pa_id],[pa_field_not_used1],[dg_id],[dr_id],[pa_first],[pa_middle],[pa_last],[pa_ssn],[pa_dob],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip]
			   ,[pa_phone],[pa_wgt],[pa_sex],[ic_id],[ic_group_numb],[card_holder_id],[card_holder_first],[card_holder_mi],[card_holder_last],[ic_plan_numb],[ins_relate_code]
			   ,[ins_person_code],[formulary_id],[alternative_id],[pa_bin],[primary_pharm_id],[pa_notes],[ph_drugs],[pa_email],[pa_ext],[rxhub_pbm_id],[pbm_member_id],[def_ins_id]
			   ,[last_check_date],[check_eligibility],[sfi_is_sfi],[sfi_patid],[pa_ht],[pa_upd_stat],[pa_flag],[pa_ext_id],[access_date],[access_user],[pa_ins_type],[pa_race_type]
			   ,[pa_ethn_type],[pref_lang],[add_date],[add_by_user],[record_modified_date],[pa_ext_ssn_no],[pa_prefix],[pa_suffix],[active],[last_modified_date],[last_modified_by]
			   ,GETDATE() FROM [dbo].[patients] WITH(NOLOCK) WHERE pa_id= @deleted_id)
           
			--INSERT INTO [bk].[patients] SELECT *,GETDATE() FROM patients WHERE pa_id= @new_id
			INSERT INTO [bk].[patients]
			   ([pa_id],[pa_field_not_used1],[dg_id],[dr_id],[pa_first],[pa_middle],[pa_last],[pa_ssn],[pa_dob],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip]
			   ,[pa_phone],[pa_wgt],[pa_sex],[ic_id],[ic_group_numb],[card_holder_id],[card_holder_first],[card_holder_mi],[card_holder_last],[ic_plan_numb],[ins_relate_code]
			   ,[ins_person_code],[formulary_id],[alternative_id],[pa_bin],[primary_pharm_id],[pa_notes],[ph_drugs],[pa_email],[pa_ext],[rxhub_pbm_id],[pbm_member_id],[def_ins_id]
			   ,[last_check_date],[check_eligibility],[sfi_is_sfi],[sfi_patid],[pa_ht],[pa_upd_stat],[pa_flag],[pa_ext_id],[access_date],[access_user],[pa_ins_type],[pa_race_type]
			   ,[pa_ethn_type],[pref_lang],[add_date],[add_by_user],[record_modified_date],[pa_ext_ssn_no],[pa_prefix],[pa_suffix],[active],[last_modified_date],[last_modified_by]
			   ,[created_date])
           (SELECT [pa_id],[pa_field_not_used1],[dg_id],[dr_id],[pa_first],[pa_middle],[pa_last],[pa_ssn],[pa_dob],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip]
			   ,[pa_phone],[pa_wgt],[pa_sex],[ic_id],[ic_group_numb],[card_holder_id],[card_holder_first],[card_holder_mi],[card_holder_last],[ic_plan_numb],[ins_relate_code]
			   ,[ins_person_code],[formulary_id],[alternative_id],[pa_bin],[primary_pharm_id],[pa_notes],[ph_drugs],[pa_email],[pa_ext],[rxhub_pbm_id],[pbm_member_id],[def_ins_id]
			   ,[last_check_date],[check_eligibility],[sfi_is_sfi],[sfi_patid],[pa_ht],[pa_upd_stat],[pa_flag],[pa_ext_id],[access_date],[access_user],[pa_ins_type],[pa_race_type]
			   ,[pa_ethn_type],[pref_lang],[add_date],[add_by_user],[record_modified_date],[pa_ext_ssn_no],[pa_prefix],[pa_suffix],[active],[last_modified_date],[last_modified_by]
			   ,GETDATE() FROM [dbo].[patients] WITH(NOLOCK) WHERE pa_id= @new_id)
			   
			   INSERT INTO [bk].[patient_vitals]
				([pa_vt_id],[pa_id],[pa_wt],[pa_ht],[pa_pulse],[pa_bp_sys],[pa_bp_dys],[pa_glucose],[pa_resp_rate],[pa_temp]
			   ,[pa_bmi],[age],[date_added],[dg_id],[added_by],[added_for],[record_date],[pa_oxm],[record_modified_date],[pa_hc],[pa_bp_location],[pa_bp_sys_statnding]
			   ,[pa_bp_dys_statnding],[pa_bp_location_statnding],[pa_bp_sys_supine],[pa_bp_dys_supine],[pa_bp_location_supine],[pa_temp_method],[pa_pulse_rhythm]
			   ,[pa_pulse_standing],[pa_pulse_rhythm_standing],[pa_pulse_supine],[pa_pulse_rhythm_supine],[pa_heart_rate],[pa_fio2],[pa_flow],[pa_resp_quality]
			   ,[pa_comment],[active],[last_modified_date],[last_modified_by],[created_date])
           (SELECT [pa_vt_id],[pa_id],[pa_wt],[pa_ht],[pa_pulse],[pa_bp_sys],[pa_bp_dys],[pa_glucose],[pa_resp_rate],[pa_temp]
			   ,[pa_bmi],[age],[date_added],[dg_id],[added_by],[added_for],[record_date],[pa_oxm],[record_modified_date],[pa_hc],[pa_bp_location],[pa_bp_sys_statnding]
			   ,[pa_bp_dys_statnding],[pa_bp_location_statnding],[pa_bp_sys_supine],[pa_bp_dys_supine],[pa_bp_location_supine],[pa_temp_method],[pa_pulse_rhythm]
			   ,[pa_pulse_standing],[pa_pulse_rhythm_standing],[pa_pulse_supine],[pa_pulse_rhythm_supine],[pa_heart_rate],[pa_fio2],[pa_flow],[pa_resp_quality]
			   ,[pa_comment],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_vitals] WITH(NOLOCK) WHERE pa_id=@deleted_id)
           
			--INSERT INTO [bk].[patient_vitals] SELECT *,GETDATE() FROM patient_vitals WHERE pa_id=@deleted_id 
			
			--INSERT INTO [bk].[patient_social_hx] SELECT *,GETDATE() FROM patient_social_hx WHERE pat_id=@deleted_id
			INSERT INTO [bk].[patient_social_hx]
			   ([sochxid],[pat_id],[emp_info],[marital_status],[other_marital_status],[household_people_no],[smoking_status],[dr_id],[added_by_dr_id]
			   ,[created_on],[last_modified_on],[last_modified_by],[comments],[enable],[familyhx_other],[medicalhx_other],[surgeryhx_other],[active]
			   ,[created_date])
           (SELECT [sochxid],[pat_id],[emp_info],[marital_status],[other_marital_status],[household_people_no],[smoking_status],[dr_id],[added_by_dr_id]
			   ,[created_on],[last_modified_on],[last_modified_by],[comments],[enable],[familyhx_other],[medicalhx_other],[surgeryhx_other],[active]
			   ,GETDATE() FROM [dbo].[patient_social_hx] WITH(NOLOCK) WHERE pat_id=@deleted_id)
			   
			   --INSERT INTO [bk].[patient_registration] SELECT *,GETDATE() FROM patient_registration WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_registration]
				([pa_reg_id],[pa_id],[src_id],[pincode],[dr_id],[token],[reg_date],[exp_date],[last_update_date],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pa_reg_id],[pa_id],[src_id],[pincode],[dr_id],[token],[reg_date],[exp_date],[last_update_date],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_registration] WITH(NOLOCK) WHERE pa_id=@deleted_id)
				
				--INSERT INTO [bk].[patient_reg_db] SELECT *,GETDATE() FROM patient_reg_db WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_reg_db]
				([pat_reg_id],[dr_id],[pa_id],[pincode],[date_created],[src_type],[opt_out],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pat_reg_id],[dr_id],[pa_id],[pincode],[date_created],[src_type],[opt_out],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_reg_db] WITH(NOLOCK) WHERE pa_id=@deleted_id)
				
				--INSERT INTO [bk].[patient_profile] SELECT *,GETDATE() FROM patient_profile WHERE patient_id=@deleted_id
			INSERT INTO [bk].[patient_profile]
				([profile_id],[patient_id],[added_by_dr_id],[entry_date],[last_update_date],[last_update_dr_id],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [profile_id],[patient_id],[added_by_dr_id],[entry_date],[last_update_date],[last_update_dr_id],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_profile] WITH(NOLOCK) WHERE patient_id=@deleted_id)
				
				--INSERT INTO [bk].[patient_procedures] SELECT *,GETDATE() FROM patient_procedures WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_procedures]
			   ([procedure_id],[pa_id],[dr_id],[date_performed],[type],[status],[code],[description],[notes],[record_modified_date],[date_performed_to],[active],[last_modified_date]
			   ,[last_modified_by],[created_date])
           (SELECT [procedure_id],[pa_id],[dr_id],[date_performed],[type],[status],[code],[description],[notes],[record_modified_date],[date_performed_to],[active],[last_modified_date]
				,[last_modified_by],GETDATE() FROM [dbo].[patient_procedures] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[patient_phr_access_log] SELECT *,GETDATE() FROM patient_phr_access_log WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_phr_access_log]
			   ([phr_access_log_id],[pa_id],[phr_access_type],[phr_access_description],[phr_access_datetime],[phr_access_from_ip],[active],[last_modified_date],[last_modified_by]
			   ,[created_date])
			(SELECT [phr_access_log_id],[pa_id],[phr_access_type],[phr_access_description],[phr_access_datetime],[phr_access_from_ip],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_phr_access_log] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[patient_next_of_kin] SELECT *,GETDATE() FROM patient_next_of_kin WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_next_of_kin]
			   ([pa_id],[kin_relation_code],[kin_first],[kin_middle],[kin_last],[kin_address1],[kin_city],[kin_state],[kin_zip],[kin_country],[kin_phone],[kin_email]
			   ,[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pa_id],[kin_relation_code],[kin_first],[kin_middle],[kin_last],[kin_address1],[kin_city],[kin_state],[kin_zip],[kin_country],[kin_phone],[kin_email]
				,[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_next_of_kin] WITH(NOLOCK) WHERE pa_id=@deleted_id)
	
			--INSERT INTO [bk].[patient_next_of_kin] SELECT *,GETDATE() FROM patient_next_of_kin WHERE pa_id=@new_id
			INSERT INTO [bk].[patient_next_of_kin]
			   ([pa_id],[kin_relation_code],[kin_first],[kin_middle],[kin_last],[kin_address1],[kin_city],[kin_state],[kin_zip],[kin_country],[kin_phone],[kin_email]
			   ,[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pa_id],[kin_relation_code],[kin_first],[kin_middle],[kin_last],[kin_address1],[kin_city],[kin_state],[kin_zip],[kin_country],[kin_phone],[kin_email]
				,[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_next_of_kin] WITH(NOLOCK) WHERE pa_id=@new_id)

--INSERT INTO [bk].[patient_new_allergies_external] SELECT *,GETDATE() FROM patient_new_allergies_external WHERE pae_pa_id=@deleted_id
			INSERT INTO [bk].[patient_new_allergies_external]
				([pae_pa_allergy_id],[pae_pa_id],[pae_source_name],[pae_allergy_id],[pae_allergy_description],[pae_allergy_type],[pae_add_date],[pae_comments],[pae_reaction_string]
				,[pae_status],[pae_dr_modified_user],[pae_disable_date],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT  [pae_pa_allergy_id],[pae_pa_id],[pae_source_name],[pae_allergy_id],[pae_allergy_description],[pae_allergy_type],[pae_add_date],[pae_comments],[pae_reaction_string]
				,[pae_status],[pae_dr_modified_user],[pae_disable_date],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_new_allergies_external] 
				WITH(NOLOCK) WHERE pae_pa_id=@deleted_id)

--INSERT INTO [bk].[patient_new_allergies] SELECT *,GETDATE() FROM patient_new_allergies A WHERE pa_id = @deleted_id
			--	 AND NOT EXISTS(SELECT pa_allergy_id FROM patient_new_allergies WHERE pa_id = @new_id AND allergy_id = A.allergy_id AND allergy_type = A.allergy_type)
			INSERT INTO [bk].[patient_new_allergies]
				([pa_allergy_id],[pa_id],[allergy_id],[allergy_type],[add_date],[comments],[reaction_string],[status],[dr_modified_user],[disable_date],[source_type]
				,[allergy_description],[record_source],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pa_allergy_id],[pa_id],[allergy_id],[allergy_type],[add_date],[comments],[reaction_string],[status],[dr_modified_user],[disable_date],[source_type]
				,[allergy_description],[record_source],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_new_allergies] A WITH(NOLOCK) 
				WHERE pa_id = @deleted_id AND NOT EXISTS(SELECT pa_allergy_id FROM patient_new_allergies WITH(NOLOCK)
				WHERE pa_id = @new_id AND allergy_id = A.allergy_id AND allergy_type = A.allergy_type))

--INSERT INTO [bk].[scheduler_main] SELECT *,GETDATE() FROM scheduler_main WHERE ext_link_id = @deleted_id
			INSERT INTO [bk].[scheduler_main]
				([event_id],[event_start_date],[dr_id],[type],[ext_link_id],[note],[detail_header],[event_end_date],[is_new_pat],[recurrence],[recurrence_parent]
				,[status],[dtCheckIn],[dtCalled],[dtCheckedOut],[dtintake],[case_id],[room_id],[reason],[is_confirmed],[discharge_disposition_code],[is_delete_attempt]
				,[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [event_id],[event_start_date],[dr_id],[type],[ext_link_id],[note],[detail_header],[event_end_date],[is_new_pat],[recurrence],[recurrence_parent]
				,[status],[dtCheckIn],[dtCalled],[dtCheckedOut],[dtintake],[case_id],[room_id],[reason],[is_confirmed],[discharge_disposition_code],[is_delete_attempt]
				,[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[scheduler_main] WITH(NOLOCK) WHERE ext_link_id = @deleted_id)


--INSERT INTO [bk].[tblVaccinationRecord] SELECT *,GETDATE() FROM tblVaccinationRecord WHERE vac_pat_id=@deleted_id
			INSERT INTO [bk].[tblVaccinationRecord]
				([vac_rec_id],[vac_id],[vac_pat_id],[vac_dt_admin],[vac_lot_no],[vac_site],[vac_dose],[vac_exp_date],[vac_dr_id],[vac_reaction],[vac_remarks],[vac_name]
				,[vis_date],[vis_given_date],[record_modified_date],[vac_site_code],[vac_dose_unit_code],[vac_administered_code],[vac_administered_by],[vac_entered_by]
				,[substance_refusal_reason_code],[disease_code],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [vac_rec_id],[vac_id],[vac_pat_id],[vac_dt_admin],[vac_lot_no],[vac_site],[vac_dose],[vac_exp_date],[vac_dr_id],[vac_reaction],[vac_remarks],[vac_name]
				,[vis_date],[vis_given_date],[record_modified_date],[vac_site_code],[vac_dose_unit_code],[vac_administered_code],[vac_administered_by],[vac_entered_by]
				,[substance_refusal_reason_code],[disease_code],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[tblVaccinationRecord] WITH(NOLOCK) 
				WHERE vac_pat_id=@deleted_id)

--INSERT INTO [bk].[interaction_warning_log] SELECT *,GETDATE() FROM interaction_warning_log WHERE pa_id = @deleted_id
			INSERT INTO [bk].[interaction_warning_log]
				([int_warn_id],[dr_id],[pa_id],[drug_id],[response],[date],[warning_source],[reason],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [int_warn_id],[dr_id],[pa_id],[drug_id],[response],[date],[warning_source],[reason],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[interaction_warning_log] WITH(NOLOCK) WHERE pa_id = @deleted_id)

--INSERT INTO [bk].[patient_immunization_registry_settings] SELECT *,GETDATE() FROM patient_immunization_registry_settings 
			--	WHERE pa_id = @deleted_id AND NOT EXISTS(SELECT * FROM [bk].[patient_immunization_registry_settings] WHERE pa_id = @new_id)
			INSERT INTO [bk].[patient_immunization_registry_settings]
				([pa_id],[publicity_code],[publicity_code_effective_date],[registry_status],[registry_status_effective_date],[entered_by],[dr_id],[entered_on],[modified_on]
				,[protection_indicator],[protection_indicator_effective_date],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pa_id],[publicity_code],[publicity_code_effective_date],[registry_status],[registry_status_effective_date],[entered_by],[dr_id],[entered_on],[modified_on]
				,[protection_indicator],[protection_indicator_effective_date],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_immunization_registry_settings] WITH(NOLOCK) WHERE pa_id = @deleted_id 
				AND NOT EXISTS(SELECT * FROM [bk].[patient_immunization_registry_settings]  WITH(NOLOCK) WHERE pa_id = @new_id))
									
			--INSERT INTO [bk].[patient_hm_alerts] SELECT *,GETDATE() FROM patient_hm_alerts WHERE pa_id = @deleted_id
			INSERT INTO [bk].[patient_hm_alerts]
				([rule_prf_id],[pa_id],[rule_id],[dt_performed],[dr_performed_by],[notes],[due_date],[rxnt_status_id],[date_added],[last_edited_on],[last_edited_by]
				,[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [rule_prf_id],[pa_id],[rule_id],[dt_performed],[dr_performed_by],[notes],[due_date],[rxnt_status_id],[date_added],[last_edited_on],[last_edited_by]
				,[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_hm_alerts] WITH(NOLOCK) WHERE pa_id = @deleted_id)
			
			--INSERT INTO [bk].[patient_flag_details] SELECT *,GETDATE() FROM patient_flag_details WHERE pa_id = @deleted_id
			INSERT INTO [bk].[patient_flag_details]
				([pa_flag_id],[pa_id],[flag_id],[flag_text],[dr_id],[date_added],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pa_flag_id],[pa_id],[flag_id],[flag_text],[dr_id],[date_added],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_flag_details] WITH(NOLOCK) WHERE pa_id = @deleted_id)

--INSERT INTO [bk].[patient_family_hx] SELECT *,GETDATE() FROM patient_family_hx WHERE pat_id = @deleted_id
			INSERT INTO [bk].[patient_family_hx]
				([fhxid],[pat_id],[member_relation_id],[problem],[icd9],[dr_id],[added_by_dr_id],[created_on],[last_modified_on],[last_modified_by],[comments]
				,[enable],[active],[last_modified_date],[created_date])
			(SELECT [fhxid],[pat_id],[member_relation_id],[problem],[icd9],[dr_id],[added_by_dr_id],[created_on],[last_modified_on],[last_modified_by],[comments]
				,[enable],[active],[last_modified_date],GETDATE() FROM [dbo].[patient_family_hx] WITH(NOLOCK) WHERE pat_id = @deleted_id)

--INSERT INTO [bk].[patient_extended_details] SELECT *,GETDATE() FROM patient_extended_details WHERE pa_id = @deleted_id
			INSERT INTO [bk].[patient_extended_details]
				([pa_id],[pa_ext_ref],[pa_ref_name_details],[pa_ref_date],[prim_dr_id],[dr_id],[cell_phone],[marital_status],[empl_status],[work_phone],[other_phone],[comm_pref]
				,[pref_phone],[time_zone],[pref_start_time],[pref_end_time],[mother_first],[mother_middle],[mother_last],[pa_death_date],[emergency_contact_first]
				,[emergency_contact_last],[emergency_contact_address1],[emergency_contact_address2],[emergency_contact_city],[emergency_contact_state],[emergency_contact_zip]
				,[emergency_contact_phone],[emergency_contact_release_documents],[emergency_contact_relationship],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pa_id],[pa_ext_ref],[pa_ref_name_details],[pa_ref_date],[prim_dr_id],[dr_id],[cell_phone],[marital_status],[empl_status],[work_phone],[other_phone],[comm_pref]
				,[pref_phone],[time_zone],[pref_start_time],[pref_end_time],[mother_first],[mother_middle],[mother_last],[pa_death_date],[emergency_contact_first]
				,[emergency_contact_last],[emergency_contact_address1],[emergency_contact_address2],[emergency_contact_city],[emergency_contact_state],[emergency_contact_zip]
				,[emergency_contact_phone],[emergency_contact_release_documents],[emergency_contact_relationship],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_extended_details] WITH(NOLOCK) WHERE pa_id = @deleted_id)
							
			--INSERT INTO [bk].[patient_extended_details] SELECT *,GETDATE() FROM patient_extended_details WHERE pa_id = @new_id
			INSERT INTO [bk].[patient_extended_details]
				([pa_id],[pa_ext_ref],[pa_ref_name_details],[pa_ref_date],[prim_dr_id],[dr_id],[cell_phone],[marital_status],[empl_status],[work_phone],[other_phone],[comm_pref]
				,[pref_phone],[time_zone],[pref_start_time],[pref_end_time],[mother_first],[mother_middle],[mother_last],[pa_death_date],[emergency_contact_first]
				,[emergency_contact_last],[emergency_contact_address1],[emergency_contact_address2],[emergency_contact_city],[emergency_contact_state],[emergency_contact_zip]
				,[emergency_contact_phone],[emergency_contact_release_documents],[emergency_contact_relationship],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pa_id],[pa_ext_ref],[pa_ref_name_details],[pa_ref_date],[prim_dr_id],[dr_id],[cell_phone],[marital_status],[empl_status],[work_phone],[other_phone],[comm_pref]
				,[pref_phone],[time_zone],[pref_start_time],[pref_end_time],[mother_first],[mother_middle],[mother_last],[pa_death_date],[emergency_contact_first]
				,[emergency_contact_last],[emergency_contact_address1],[emergency_contact_address2],[emergency_contact_city],[emergency_contact_state],[emergency_contact_zip]
				,[emergency_contact_phone],[emergency_contact_release_documents],[emergency_contact_relationship],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_extended_details] WITH(NOLOCK) WHERE pa_id = @new_id)

--INSERT INTO [bk].[patient_documents] SELECT *,GETDATE() FROM patient_documents WHERE pat_id=@deleted_id
			INSERT INTO [bk].[patient_documents]
				([document_id],[pat_id],[src_dr_id],[upload_date],[title],[description],[filename],[cat_id],[owner_id],[owner_type],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [document_id],[pat_id],[src_dr_id],[upload_date],[title],[description],[filename],[cat_id],[owner_id],[owner_type],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_documents] WITH(NOLOCK) WHERE pat_id=@deleted_id)

--INSERT INTO [bk].[patient_consent] SELECT *,GETDATE() FROM patient_consent WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_consent]
				([consent_id],[pa_id],[dr_id],[date],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [consent_id],[pa_id],[dr_id],[date],[active],[last_modified_date],[last_modified_by],GETDATE() 
				FROM [dbo].[patient_consent] WITH(NOLOCK) WHERE pa_id=@deleted_id)
				
				--UPDATE patient_consent SET pa_id =  @new_id WHERE pa_id=@deleted_id
				--Commented due to the key constraints 
				
			--INSERT INTO [bk].[patient_care_providers] SELECT *,GETDATE() FROM patient_care_providers 
			--	WHERE pa_id=@deleted_id AND NOT EXISTS(SELECT prv_fav_id FROM [bk].[patient_care_providers] WHERE pa_id=@new_id)
			INSERT INTO [bk].[patient_care_providers]
				([id],[pa_id],[prv_fav_id],[enable],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [id],[pa_id],[prv_fav_id],[enable],[active],[last_modified_date],[last_modified_by],GETDATE()
				FROM [dbo].[patient_care_providers] WITH(NOLOCK) WHERE pa_id=@deleted_id 
				AND NOT EXISTS(SELECT prv_fav_id FROM [bk].[patient_care_providers] WITH(NOLOCK) WHERE pa_id=@new_id))
			
			--INSERT INTO [bk].[patient_appointment_request] SELECT *,GETDATE() FROM patient_appointment_request WHERE pat_id=@deleted_id
			INSERT INTO [bk].[patient_appointment_request]
				([pat_appt_req_id],[pat_id],[dg_id],[req_appt_date],[req_appt_time],[primary_reason],[is_completed],[created_datetime],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pat_appt_req_id],[pat_id],[dg_id],[req_appt_date],[req_appt_time],[primary_reason],[is_completed],[created_datetime],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_appointment_request] WITH(NOLOCK) WHERE pat_id=@deleted_id)

--INSERT INTO [bk].[patient_active_meds_external] SELECT *,GETDATE() FROM patient_active_meds_external WHERE pame_pa_id=@deleted_id
			INSERT INTO [bk].[patient_active_meds_external]
				([pame_id],[pame_pa_id],[pame_drug_id],[pame_date_added],[pame_compound],[pame_comments],[pame_status],[pame_drug_name],[pame_dosage]
				,[pame_duration_amount],[pame_duration_unit],[pame_drug_comments],[pame_numb_refills],[pame_use_generic],[pame_days_supply],[pame_prn],[pame_prn_description]
				,[pame_date_start],[pame_date_end],[pame_source_name],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pame_id],[pame_pa_id],[pame_drug_id],[pame_date_added],[pame_compound],[pame_comments],[pame_status],[pame_drug_name],[pame_dosage]
				,[pame_duration_amount],[pame_duration_unit],[pame_drug_comments],[pame_numb_refills],[pame_use_generic],[pame_days_supply],[pame_prn],[pame_prn_description]
				,[pame_date_start],[pame_date_end],[pame_source_name],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_active_meds_external]
				WITH(NOLOCK) WHERE pame_pa_id=@deleted_id)

--INSERT INTO [bk].[patient_active_meds] SELECT *,GETDATE() FROM patient_active_meds WHERE pa_id = @deleted_id AND 
			--	drug_id NOT IN(SELECT drug_id FROM patient_active_meds WHERE pa_id = @new_id)
			INSERT INTO [bk].[patient_active_meds]
				([pam_id],[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id]
				,[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description]
				,[date_start],[date_end],[for_dr_id],[source_type],[record_source],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pam_id],[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id]
				,[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description]
				,[date_start],[date_end],[for_dr_id],[source_type],[record_source],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_active_meds] WITH(NOLOCK) WHERE pa_id = @deleted_id AND 
				drug_id NOT IN(SELECT drug_id FROM [dbo].[patient_active_meds] WITH(NOLOCK) WHERE pa_id = @new_id))

--INSERT INTO [bk].[patient_active_diagnosis_external] SELECT *,GETDATE() FROM patient_active_diagnosis_external WHERE pde_pa_id=@deleted_id
			INSERT INTO [bk].[patient_active_diagnosis_external]
				([pde_id],[pde_pa_id],[pde_source_name],[pde_icd9],[pde_added_by_dr_id],[pde_date_added],[pde_icd9_description],[pde_enabled],[pde_onset],[pde_severity]
				,[pde_status],[pde_type],[pde_record_modified_date],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pde_id],[pde_pa_id],[pde_source_name],[pde_icd9],[pde_added_by_dr_id],[pde_date_added],[pde_icd9_description],[pde_enabled],[pde_onset],[pde_severity]
				,[pde_status],[pde_type],[pde_record_modified_date],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_active_diagnosis_external]
				WITH(NOLOCK) WHERE pde_pa_id=@deleted_id)

--INSERT INTO [bk].[patient_active_diagnosis] SELECT *,GETDATE() FROM patient_active_diagnosis WHERE pa_id = @deleted_id AND 
			--	  icd9 NOT IN(SELECT icd9 FROM patient_active_diagnosis WHERE pa_id = @new_id)
			INSERT INTO [bk].[patient_active_diagnosis]
				([pad],[pa_id],[icd9],[added_by_dr_id],[date_added],[icd9_description],[enabled],[onset],[severity],[status],[type],[record_modified_date],[source_type]
				,[record_source],[status_date],[code_type],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pad],[pa_id],[icd9],[added_by_dr_id],[date_added],[icd9_description],[enabled],[onset],[severity],[status],[type],[record_modified_date],[source_type]
				,[record_source],[status_date],[code_type],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[patient_active_diagnosis]
				WITH(NOLOCK) WHERE pa_id = @deleted_id AND icd9 NOT IN(SELECT icd9 FROM [dbo].[patient_active_diagnosis] WITH(NOLOCK) WHERE pa_id = @new_id))
				  
			--INSERT INTO [bk].[MUMeasureCounts] SELECT *,GETDATE() FROM MUMeasureCounts WHERE pa_id=@deleted_id
			INSERT INTO [bk].[MUMeasureCounts]
				([Id],[MUMeasuresId],[MeasureCode],[dc_id],[dg_id],[dr_id],[pa_id],[enc_id],[enc_date],[DateAdded],[IsNumerator],[IsDenominator]
				,[RecordCreateUserId],[RecordCreateDateTime],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [Id],[MUMeasuresId],[MeasureCode],[dc_id],[dg_id],[dr_id],[pa_id],[enc_id],[enc_date],[DateAdded],[IsNumerator],[IsDenominator]
				,[RecordCreateUserId],[RecordCreateDateTime],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[MUMeasureCounts]
				WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[lab_pat_details] SELECT *,GETDATE() FROM lab_pat_details WHERE pat_id=@deleted_id
			INSERT INTO [bk].[lab_pat_details]
				([lab_id],[pat_id],[ext_pat_id],[lab_pat_id],[alt_pat_id],[pa_first],[pa_last],[pa_middle],[pa_dob],[pa_sex],[pa_address1],[pa_city],[pa_state]
				,[pa_zip],[pa_acctno],[spm_status],[fasting],[notes],[pa_suffix],[pa_race],[pa_alternate_race],[lab_patid_namespace_id],[lab_patid_type_code]
				,[lab_pat_id_uid],[lab_pat_id_uid_type],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [lab_id],[pat_id],[ext_pat_id],[lab_pat_id],[alt_pat_id],[pa_first],[pa_last],[pa_middle],[pa_dob],[pa_sex],[pa_address1],[pa_city],[pa_state]
				,[pa_zip],[pa_acctno],[spm_status],[fasting],[notes],[pa_suffix],[pa_race],[pa_alternate_race],[lab_patid_namespace_id],[lab_patid_type_code]
				,[lab_pat_id_uid],[lab_pat_id_uid_type],[active],[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[lab_pat_details]
				WITH(NOLOCK) WHERE pat_id=@deleted_id)
		
--INSERT INTO [bk].[patient_measure_compliance] SELECT *,GETDATE() FROM patient_measure_compliance WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_measure_compliance]
				([rec_id],[pa_id],[dr_id],[src_dr_id],[rec_type],[rec_date],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [rec_id],[pa_id],[dr_id],[src_dr_id],[rec_type],[rec_date],[active],[last_modified_date],[last_modified_by],GETDATE()
				FROM [dbo].[patient_measure_compliance] WITH(NOLOCK) WHERE pa_id=@deleted_id)
			
--INSERT INTO [bk].[patient_login] SELECT *,GETDATE() FROM patient_login WHERE pa_id=@deleted_id
			--	AND NOT EXISTS(SELECT pa_id FROM [bk].[patient_login] WHERE pa_id=@new_id)	
			INSERT INTO [bk].[patient_login]
				([pa_id],[pa_username],[pa_password],[pa_email],[pa_phone],[salt],[enabled],[cellphone],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pa_id],[pa_username],[pa_password],[pa_email],[pa_phone],[salt],[enabled],[cellphone],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_login] WITH(NOLOCK) WHERE pa_id=@deleted_id AND NOT EXISTS(SELECT pa_id FROM [bk].[patient_login] WITH(NOLOCK) WHERE pa_id=@new_id))	
			
			--INSERT INTO [bk].[patient_lab_orders_master] SELECT *,GETDATE() FROM patient_lab_orders_master WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_lab_orders_master]
				([lab_master_id],[pa_id],[added_date],[added_by],[order_date],[order_status],[comments],[last_edit_by],[last_edit_date],[dr_id],[isActive],[external_lab_order_id]
				,[doc_group_lab_xref_id],[abn_file_path],[requisition_file_path],[label_file_path],[lab_id],[order_sent_date],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [lab_master_id],[pa_id],[added_date],[added_by],[order_date],[order_status],[comments],[last_edit_by],[last_edit_date],[dr_id],[isActive],[external_lab_order_id]
				,[doc_group_lab_xref_id],[abn_file_path],[requisition_file_path],[label_file_path],[lab_id],[order_sent_date],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_lab_orders_master] WITH(NOLOCK) WHERE pa_id=@deleted_id)
			
--INSERT INTO [bk].[dr_custom_messages] SELECT *,GETDATE() FROM dr_custom_messages WHERE patid=@deleted_id
			INSERT INTO [bk].[dr_custom_messages]
				([dr_cst_msg_id],[dr_src_id],[dr_dst_id],[msg_date],[message],[is_read],[is_complete],[patid],[message_typeid],[message_subtypeid],[active],[last_modified_date]
				,[last_modified_by],[created_date])
			(SELECT [dr_cst_msg_id],[dr_src_id],[dr_dst_id],[msg_date],[message],[is_read],[is_complete],[patid],[message_typeid],[message_subtypeid],[active],[last_modified_date]
				,[last_modified_by],GETDATE() FROM [dbo].[dr_custom_messages] WITH(NOLOCK) WHERE patid=@deleted_id)
			
--INSERT INTO [bk].[patients_fav_pharms] SELECT *,GETDATE() FROM patients_fav_pharms A WHERE pa_id = @deleted_id
			--	AND NOT EXISTS(SELECT pharm_id FROM patients_fav_pharms WHERE pa_id = @new_id AND pharm_id = A.pharm_id)
			INSERT INTO [bk].[patients_fav_pharms]
				([pa_id],[pharm_id],[pharm_use_date]
				--,[active],[last_modified_date],[last_modified_by],[created_date]
				)
			(SELECT [pa_id],[pharm_id],[pharm_use_date]
			--,[active],[last_modified_date],[last_modified_by],GETDATE() 
				FROM [dbo].[patients_fav_pharms] A WITH(NOLOCK) WHERE pa_id = @deleted_id
				AND NOT EXISTS(SELECT pharm_id FROM [dbo].[patients_fav_pharms] WHERE pa_id = @new_id AND pharm_id = A.pharm_id))

--INSERT INTO [bk].[prescriptions] SELECT *,GETDATE() FROM prescriptions WHERE pa_id = @deleted_id
			INSERT INTO [bk].[prescriptions]
				([pres_id],[dr_id],[dg_id],[pharm_id],[pa_id],[pres_entry_date],[pres_read_date],[only_faxed],[pharm_viewed],[off_dr_list],[opener_user_id],[pres_is_refill]
				,[rx_number],[last_pharm_name],[last_pharm_address],[last_pharm_city],[last_pharm_state],[last_pharm_phone],[pharm_state_holder],[pharm_city_holder],[pharm_id_holder]
				,[fax_conf_send_date],[fax_conf_numb_pages],[fax_conf_remote_fax_id],[fax_conf_error_string],[pres_delivery_method],[prim_dr_id],[print_count],[pda_written]
				,[authorizing_dr_id],[sfi_is_sfi],[sfi_pres_id],[field_not_used1],[admin_notes],[pres_approved_date],[pres_void],[last_edit_date],[last_edit_dr_id],[pres_prescription_type]
				,[pres_void_comments],[eligibility_checked],[eligibility_trans_id],[off_pharm_list],[DoPrintAfterPatHistory],[DoPrintAfterPatOrig],[DoPrintAfterPatCopy]
				,[DoPrintAfterPatMonograph],[PatOrigPrintType],[PrintHistoryBackMonths],[DoPrintAfterScriptGuide],[approve_source],[pres_void_code],[send_count],[print_options]
				,[writing_dr_id],[presc_src],[pres_start_date],[pres_end_date],[is_signed],[created_date])
			(SELECT [pres_id],[dr_id],[dg_id],[pharm_id],[pa_id],[pres_entry_date],[pres_read_date],[only_faxed],[pharm_viewed],[off_dr_list],[opener_user_id],[pres_is_refill]
				,[rx_number],[last_pharm_name],[last_pharm_address],[last_pharm_city],[last_pharm_state],[last_pharm_phone],[pharm_state_holder],[pharm_city_holder],[pharm_id_holder]
				,[fax_conf_send_date],[fax_conf_numb_pages],[fax_conf_remote_fax_id],[fax_conf_error_string],[pres_delivery_method],[prim_dr_id],[print_count],[pda_written]
				,[authorizing_dr_id],[sfi_is_sfi],[sfi_pres_id],[field_not_used1],[admin_notes],[pres_approved_date],[pres_void],[last_edit_date],[last_edit_dr_id],[pres_prescription_type]
				,[pres_void_comments],[eligibility_checked],[eligibility_trans_id],[off_pharm_list],[DoPrintAfterPatHistory],[DoPrintAfterPatOrig],[DoPrintAfterPatCopy]
				,[DoPrintAfterPatMonograph],[PatOrigPrintType],[PrintHistoryBackMonths],[DoPrintAfterScriptGuide],[approve_source],[pres_void_code],[send_count],[print_options]
				,[writing_dr_id],[presc_src],[pres_start_date],[pres_end_date],[is_signed],GETDATE() 
				FROM [dbo].[prescriptions] WITH(NOLOCK) WHERE pa_id = @deleted_id)

--INSERT INTO [bk].[patient_medications_hx] SELECT *,GETDATE() FROM patient_medications_hx  WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_medications_hx]
				([pam_id],[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason]
				,[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description]
				,[date_start],[date_end],[for_dr_id],[source_type],[record_source],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [pam_id],[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason]
				,[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description]
				,[date_start],[date_end],[for_dr_id],[source_type],[record_source],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_medications_hx] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[patient_notes] SELECT *,GETDATE() FROM patient_notes WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_notes]
				([note_id],[pa_id],[note_date],[dr_id],[void],[note_text],[partner_id],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [note_id],[pa_id],[note_date],[dr_id],[void],[note_text],[partner_id],[active],[last_modified_date],[last_modified_by],GETDATE()
				FROM [dbo].[patient_notes] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[patient_lab_orders] SELECT *,GETDATE() FROM patient_lab_orders WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_lab_orders]
				([pa_lab_id],[pa_id],[lab_test_id],[lab_test_name],[added_date],[added_by],[order_date],[order_status],[comments],[last_edit_by],[last_edit_date],[from_main_lab_id]
				,[recurringinformation],[diagnosis],[urgency],[dr_id],[isActive],[sendElectronically],[external_lab_order_id],[doc_group_lab_xref_id],[abn_file_path]
				,[requisition_file_path],[label_file_path],[lab_master_id],[lab_id],[lab_result_info_id],[enc_id],[specimen_time],[test_type],[active],[last_modified_date]
				,[last_modified_by],[created_date])
			(SELECT [pa_lab_id],[pa_id],[lab_test_id],[lab_test_name],[added_date],[added_by],[order_date],[order_status],[comments],[last_edit_by],[last_edit_date],[from_main_lab_id]
				,[recurringinformation],[diagnosis],[urgency],[dr_id],[isActive],[sendElectronically],[external_lab_order_id],[doc_group_lab_xref_id],[abn_file_path]
				,[requisition_file_path],[label_file_path],[lab_master_id],[lab_id],[lab_result_info_id],[enc_id],[specimen_time],[test_type],[active],[last_modified_date]
				,[last_modified_by],GETDATE() FROM [dbo].[patient_lab_orders] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[enchanced_encounter] SELECT *,GETDATE() FROM enchanced_encounter WHERE patient_id = @deleted_id
			INSERT INTO [bk].[enchanced_encounter]
				([enc_id],[patient_id],[dr_id],[added_by_dr_id],[enc_date],[enc_text],[chief_complaint],[type],[issigned],[dtsigned],[case_id],[loc_id]
				,[last_modified_date],[last_modified_by],[datasets_selection],[type_of_visit],[clinical_summary_first_date],[active],[created_date])
			(SELECT [enc_id],[patient_id],[dr_id],[added_by_dr_id],[enc_date],[enc_text],[chief_complaint],[type],[issigned],[dtsigned],[case_id],[loc_id]
				,[last_modified_date],[last_modified_by],[datasets_selection],[type_of_visit],[clinical_summary_first_date],[active],GETDATE()
				FROM [dbo].[enchanced_encounter] WITH(NOLOCK) WHERE patient_id = @deleted_id)
					
			--INSERT INTO [bk].[lab_main] SELECT *,GETDATE() FROM lab_main WHERE pat_id=@deleted_id
			INSERT INTO [bk].[lab_main]
				([lab_id],[send_appl],[send_facility],[rcv_appl],[rcv_facility],[message_date],[message_type],[message_ctrl_id],[version],[component_sep],[subcomponent_sep]
				,[escape_delim],[filename],[dr_id],[pat_id],[dg_id],[is_read],[read_by],[PROV_NAME],[comments],[result_file_path],[lab_order_master_id],[type],[active]
				,[last_modified_date],[last_modified_by],[created_date])
			(SELECT [lab_id],[send_appl],[send_facility],[rcv_appl],[rcv_facility],[message_date],[message_type],[message_ctrl_id],[version],[component_sep],[subcomponent_sep]
				,[escape_delim],[filename],[dr_id],[pat_id],[dg_id],[is_read],[read_by],[PROV_NAME],[comments],[result_file_path],[lab_order_master_id],[type],[active]
				,[last_modified_date],[last_modified_by],GETDATE() FROM [dbo].[lab_main] WITH(NOLOCK) WHERE pat_id=@deleted_id)

--INSERT INTO [bk].[referral_main] SELECT *,GETDATE() FROM referral_main WHERE pa_id=@deleted_id
			INSERT INTO [bk].[referral_main]
				([ref_id],[main_dr_id],[target_dr_id],[pa_id],[ref_det_xref_id],[ref_start_date],[ref_end_date],[carrier_xref_id],[pa_member_no],[ref_det_ident]
				,[main_prv_id1],[main_prv_id2],[target_prv_id1],[target_prv_id2],[inst_id],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [ref_id],[main_dr_id],[target_dr_id],[pa_id],[ref_det_xref_id],[ref_start_date],[ref_end_date],[carrier_xref_id],[pa_member_no],[ref_det_ident]
				,[main_prv_id1],[main_prv_id2],[target_prv_id1],[target_prv_id2],[inst_id],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[referral_main] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[refill_requests] SELECT *,GETDATE() FROM refill_requests WHERE pa_id=@deleted_id
			INSERT INTO [bk].[refill_requests]
				([refreq_id],[dg_id],[dr_id],[pa_id],[pharm_id],[pharm_ncpdp],[refreq_date],[trc_number],[ctrl_number],[recverVector],[senderVector],[pres_id],[response_type]
				,[init_date],[msg_date],[response_id],[status_code],[status_code_qualifier],[status_msg],[response_conf_date],[error_string],[pres_fill_time],[msg_ref_number]
				,[drug_name],[drug_ndc],[drug_form],[drug_strength],[drug_strength_units],[qty1],[qty1_units],[qty1_enum],[qty2],[qty2_units],[qty2_enum],[dosage1],[dosage2]
				,[days_supply],[date1],[date1_enum],[date2],[date2_enum],[date3],[date3_enum],[substitution_code],[refills],[refills_enum],[void_comments],[void_code]
				,[comments1],[comments2],[comments3],[disp_drug_info],[supervisor],[SupervisorSeg],[PharmSeg],[PatientSeg],[DoctorSeg],[DispDRUSeg],[PrescDRUSeg],[drug_strength_code]
				,[drug_strength_source_code],[drug_form_code],[drug_form_source_code],[qty1_units_potency_code],[qty2_units_potency_code],[doc_info_text],[fullRequestMessage]
				,[versionType],[created_date])
			(SELECT [refreq_id],[dg_id],[dr_id],[pa_id],[pharm_id],[pharm_ncpdp],[refreq_date],[trc_number],[ctrl_number],[recverVector],[senderVector],[pres_id],[response_type]
				,[init_date],[msg_date],[response_id],[status_code],[status_code_qualifier],[status_msg],[response_conf_date],[error_string],[pres_fill_time],[msg_ref_number]
				,[drug_name],[drug_ndc],[drug_form],[drug_strength],[drug_strength_units],[qty1],[qty1_units],[qty1_enum],[qty2],[qty2_units],[qty2_enum],[dosage1],[dosage2]
				,[days_supply],[date1],[date1_enum],[date2],[date2_enum],[date3],[date3_enum],[substitution_code],[refills],[refills_enum],[void_comments],[void_code]
				,[comments1],[comments2],[comments3],[disp_drug_info],[supervisor],[SupervisorSeg],[PharmSeg],[PatientSeg],[DoctorSeg],[DispDRUSeg],[PrescDRUSeg],[drug_strength_code]
				,[drug_strength_source_code],[drug_form_code],[drug_form_source_code],[qty1_units_potency_code],[qty2_units_potency_code],[doc_info_text],[fullRequestMessage]
				,[versionType],GETDATE() FROM [dbo].[refill_requests] WITH(NOLOCK) WHERE pa_id=@deleted_id)

--INSERT INTO [bk].[patient_visit] SELECT *,GETDATE() FROM patient_visit WHERE pa_id=@deleted_id
			INSERT INTO [bk].[patient_visit]
				([visit_id],[appt_id],[pa_id],[dr_id],[dtCreate],[dtEnd],[enc_id],[chkout_notes],[vital_id],[reason],[active],[last_modified_date],[last_modified_by]
				,[created_date])
			(SELECT [visit_id],[appt_id],[pa_id],[dr_id],[dtCreate],[dtEnd],[enc_id],[chkout_notes],[vital_id],[reason],[active],[last_modified_date],[last_modified_by]
				,GETDATE() FROM [dbo].[patient_visit]  WITH(NOLOCK) WHERE pa_id=@deleted_id)
	
--INSERT INTO [bk].[scheduled_rx_archive] SELECT *,GETDATE() FROM scheduled_rx_archive WHERE pa_id=@deleted_id
			INSERT INTO [bk].[scheduled_rx_archive]
				([pres_id],[pd_id],[pa_id],[pa_first],[pa_middle],[pa_last],[pa_dob],[pa_gender],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip],[dr_id],[dg_id]
				,[dr_first_name],[dr_middle_initial],[dr_last_name],[dr_address1],[dr_address2],[dr_city],[dr_state],[dr_zip],[dr_dea_numb],[ddid],[drug_name],[dosage]
				,[qty],[units],[days_supply],[refills],[approved_date],[signature],[scheduled_rx_id],[active],[last_modified_date],[last_modified_by],[created_date])
			(SELECT [pres_id],[pd_id],[pa_id],[pa_first],[pa_middle],[pa_last],[pa_dob],[pa_gender],[pa_address1],[pa_address2],[pa_city],[pa_state],[pa_zip],[dr_id],[dg_id]
				,[dr_first_name],[dr_middle_initial],[dr_last_name],[dr_address1],[dr_address2],[dr_city],[dr_state],[dr_zip],[dr_dea_numb],[ddid],[drug_name],[dosage]
				,[qty],[units],[days_supply],[refills],[approved_date],[signature],[scheduled_rx_id],[active],[last_modified_date],[last_modified_by],GETDATE() 
				FROM [dbo].[scheduled_rx_archive] WITH(NOLOCK) WHERE pa_id=@deleted_id)	
	  END TRY
	  BEGIN CATCH
	   DECLARE @bkErrorMessage AS NVARCHAR(4000),@bkErrorSeverity AS INT,@bkErrorState AS INT;
		SELECT 
			@bkErrorMessage = ERROR_MESSAGE(),
			@bkErrorSeverity = ERROR_SEVERITY(),
			@bkErrorState = ERROR_STATE();
		RAISERROR (@bkErrorMessage, -- Message text.
				   @bkErrorSeverity, -- Severity.
				   @bkErrorState -- State.
				   );
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','mergePatients_New','Primary PatientId:'+CONVERT(VARCHAR(500),@new_id)+',Secondry PatientId:'+CONVERT(VARCHAR(500),@deleted_id),ERROR_LINE ())				   
	  END CATCH
	  -- Backup Tables end
	  
	  BEGIN TRY
		BEGIN TRANSACTION 
			--INSERT INTO [bk].[patients] SELECT *,GETDATE() FROM patients WHERE pa_id= @deleted_id
			
			
			UPDATE patients  
				SET 
				pa_race_type=COALESCE(pa_race_type,t.raceType),
				pa_ethn_type=COALESCE(pa_ethn_type,t.ethnType),
				pref_lang=COALESCE(pref_lang,t.prefLang)
			FROM (SELECT 
				pa_race_type AS raceType,
				pa_ethn_type AS ethnType,
				pref_lang AS prefLang
				FROM patients AS P WHERE pa_id=@deleted_id)AS t
				WHERE pa_id = @new_id 
				
			
				UPDATE patient_vitals SET pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
				
			
			
				UPDATE patient_social_hx SET pat_id=@new_id,last_modified_on=GETDATE(),last_modified_by=1 WHERE pat_id=@deleted_id
			
			
			
				UPDATE patient_registration SET pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
			

			
				UPDATE patient_reg_db SET pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
			
			
				UPDATE patient_profile SET patient_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE patient_id=@deleted_id
			
			
			
				UPDATE patient_procedures SET pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
			
			
				UPDATE patient_phr_access_log SET pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
						
			
			
				UPDATE patient_next_of_kin 
				SET
				kin_relation_code=COALESCE(kin_relation_code,kin.relationcode),
				kin_first=COALESCE(kin_first,kin.kinfirst),
				kin_middle=COALESCE(kin_middle,kin.kinmiddle),
				kin_last=COALESCE(kin_last,kin.kinlast),
				kin_address1=COALESCE(kin_address1,kin.kinaddress1),
				kin_city=COALESCE(kin_city,kin.kincity),
				kin_state=COALESCE(kin_state,kin.kinstate),
				kin_zip=COALESCE(kin_zip,kin.kinzip),
				kin_country=COALESCE(kin_country,kin.kincountry),
				kin_phone=COALESCE(kin_phone,kin.kinphone),
				kin_email=COALESCE(kin_email,kin.kinemail),
				last_modified_date=GETDATE(),last_modified_by=1
				FROM(SELECT  
				kin_relation_code AS relationcode,
				kin_first AS kinfirst,
				kin_middle AS kinmiddle,
				kin_last AS kinlast,
				kin_address1 AS kinaddress1,
				kin_city AS kincity,
				kin_state AS kinstate,
				kin_zip AS kinzip,
				kin_country AS kincountry,
				kin_phone AS kinphone,
				kin_email AS kinemail
				FROM patient_next_of_kin 
				WHERE pa_id=@deleted_id)AS kin
				WHERE pa_id=@new_id
		
			
			
				UPDATE patient_new_allergies_external SET pae_pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pae_pa_id=@deleted_id
			
			
				
				 UPDATE patient_new_allergies SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 FROM patient_new_allergies A WHERE pa_id = @deleted_id
				 AND NOT EXISTS(SELECT pa_allergy_id FROM patient_new_allergies WHERE pa_id = @new_id AND allergy_id = A.allergy_id AND allergy_type = A.allergy_type)
			
			
			
				UPDATE scheduler_main SET ext_link_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 where ext_link_id = @deleted_id
						
			
			
				UPDATE tblVaccinationRecord SET vac_pat_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE vac_pat_id=@deleted_id
			
			
			
				UPDATE interaction_warning_log SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id = @deleted_id					
			
			

			
				UPDATE patient_flag_details SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id = @deleted_id
			
			
			
				UPDATE patient_family_hx SET pat_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pat_id = @deleted_id
						
			
				
				UPDATE patient_extended_details  
				SET 
				pa_ext_ref=COALESCE(pa_ext_ref,t.ref),
				pa_ref_name_details=COALESCE(pa_ref_name_details,t.details),
				pa_ref_date=COALESCE(pa_ref_date,t.ref_date),
				prim_dr_id=COALESCE(prim_dr_id,t.pdr_id),
				dr_id=COALESCE(dr_id,t.drId),
				cell_phone=COALESCE(cell_phone,t.cellphone),
				marital_status=COALESCE(marital_status,t.maritalstatus),
				empl_status=COALESCE(empl_status,t.emplstatus),
				work_phone=COALESCE(work_phone,t.workphone),
				other_phone=COALESCE(other_phone,t.otherphone),
				comm_pref=COALESCE(comm_pref,t.commpref),
				pref_phone=COALESCE(pref_phone,t.prefphone),
				time_zone=COALESCE(time_zone,t.timezone),
				pref_start_time=COALESCE(pref_start_time,t.pstarttime),
				pref_end_time=COALESCE(pref_end_time,t.pendtime),
				mother_first=COALESCE(mother_first,t.motherfirst),
				mother_middle=COALESCE(mother_middle,t.mothermiddle),
				mother_last=COALESCE(mother_last,t.motherlast),
				pa_death_date=COALESCE(pa_death_date,t.padeathdate),
				emergency_contact_first=COALESCE(emergency_contact_first,t.econtactfirst),
				emergency_contact_last=COALESCE(emergency_contact_last,t.econtactlast),
				emergency_contact_address1=COALESCE(emergency_contact_address1,t.econtactaddress1),
				emergency_contact_address2=COALESCE(emergency_contact_address2,t.econtactaddress2),
				emergency_contact_city=COALESCE(emergency_contact_city,t.econtactcity),
				emergency_contact_state=COALESCE(emergency_contact_state,t.econtactstate),
				emergency_contact_zip=COALESCE(emergency_contact_zip,t.econtactzip),
				emergency_contact_phone=COALESCE(emergency_contact_phone,t.econtactphone),
				emergency_contact_release_documents=COALESCE(emergency_contact_release_documents,t.econtactreldoc),
				emergency_contact_relationship=COALESCE(emergency_contact_relationship,t.econtactrelationship),
				last_modified_date=GETDATE(),last_modified_by=1
				FROM (SELECT 
				p.pa_ext_ref AS ref,
				p.pa_ref_name_details AS details,
				pa_ref_date AS ref_date,
				prim_dr_id AS pdr_id,
				dr_id AS drId,
				cell_phone AS cellphone,
				marital_status AS maritalstatus,
				empl_status AS emplstatus,
				work_phone AS workphone,
				other_phone AS otherphone,
				comm_pref AS commpref,
				pref_phone AS prefphone,
				time_zone AS timezone,
				pref_start_time AS pstarttime,
				pref_end_time AS pendtime,
				mother_first AS motherfirst,
				mother_middle AS mothermiddle,
				mother_last AS motherlast,
				pa_death_date AS padeathdate,
				emergency_contact_first AS econtactfirst,
				emergency_contact_last AS econtactlast,
				emergency_contact_address1 AS econtactaddress1,
				emergency_contact_address2 AS econtactaddress2,
				emergency_contact_city AS econtactcity,
				emergency_contact_state AS econtactstate,
				emergency_contact_zip AS econtactzip,
				emergency_contact_phone AS econtactphone,
				emergency_contact_release_documents AS econtactreldoc,
				emergency_contact_relationship AS econtactrelationship
				FROM patient_extended_details AS P WITH(NOLOCK) WHERE pa_id=@deleted_id)AS t
				WHERE pa_id = @new_id 	  
				
			
			
				UPDATE patient_documents SET pat_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pat_id=@deleted_id
			
			
			
				UPDATE patient_appointment_request SET pat_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pat_id=@deleted_id
			
			
			
				UPDATE patient_active_meds_external SET pame_pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pame_pa_id=@deleted_id
			
			
				
			UPDATE patient_active_meds SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id = @deleted_id AND 
				drug_id NOT IN(SELECT drug_id FROM patient_active_meds WHERE pa_id = @new_id)	
			
			
			
				UPDATE patient_active_diagnosis_external SET pde_pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pde_pa_id=@deleted_id
			
			 UPDATE patient_active_diagnosis SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id = @deleted_id AND 
				  icd9 NOT IN(SELECT icd9 FROM patient_active_diagnosis WHERE pa_id = @new_id)
			
				UPDATE MUMeasureCounts SET pa_id =  @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id			
			
			
				 UPDATE lab_pat_details SET pat_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pat_id=@deleted_id			
			
			
				UPDATE patient_medical_hx SET pat_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pat_id=@deleted_id
			
			
				UPDATE patient_measure_compliance SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
			
				UPDATE patient_lab_orders_master SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
			
				UPDATE dr_custom_messages SET patid = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE patid=@deleted_id
			
				
				UPDATE patients_fav_pharms 
				SET pa_id = @new_id
				--,last_modified_date=GETDATE()
				--,last_modified_by=1 
				FROM patients_fav_pharms A WHERE pa_id = @deleted_id
				AND NOT EXISTS(SELECT pharm_id FROM patients_fav_pharms WHERE pa_id = @new_id AND pharm_id = A.pharm_id)
			
				
				 UPDATE prescriptions SET pa_id = @new_id WHERE pa_id = @deleted_id
			
			
				UPDATE patient_medications_hx SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
			
				UPDATE patient_notes SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
						
				UPDATE patient_lab_orders SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
			
				
				UPDATE lab_main SET pat_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pat_id=@deleted_id
				
				
				UPDATE referral_main SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
				
							
				UPDATE refill_requests SET pa_id = @new_id WHERE pa_id=@deleted_id	
			
				
				UPDATE patient_visit SET pa_id = @new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id
				
										
			--Update enchanced_encounter Starts 
				DECLARE @tempTable TABLE
				(
					[index] INT IDENTITY(1,1) ,
					[enc_id] INT
				)
				DECLARE @encId INT
				DECLARE @index INT
				DECLARE @rowCount INT	
				DECLARE @enctext VARCHAR(MAX)
				--fetch records for which new patiend id needs to be updated that are not signed.
				-- including signed ones as well based on user feedback
				INSERT INTO @tempTable SELECT [enc_id]FROM [dbo].[enchanced_encounter] WITH(NOLOCK) WHERE patient_id= @deleted_id	--and issigned=0
				SET @rowCount=@@ROWCOUNT
				SET @index=1
				--loop through each encounter id
				WHILE(@index<=@rowCount)
				BEGIN	
					--fetch encounter id
					SELECT @encId=enc_id FROM @tempTable WHERE [index]=@index
					--fetch xml,patient id and type
					SELECT @enctext= [enc_text] FROM [dbo].[enchanced_encounter]WHERE enc_id=@encId	
					SET @enctext=REPLACE(@enctext,'<PatientId>'+CONVERT(VARCHAR(MAX),@deleted_id)+'</PatientId>','<PatientId>'+CONVERT(VARCHAR(MAX),@new_id)+'</PatientId>')
					---Update encounder text and patientId with new patientId			
					UPDATE [dbo].[enchanced_encounter] SET [enc_text]=@enctext,patient_id=@new_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE enc_id=@encId	
					--increment the index
					SET @index=@index+1
				END	
				-- Update secondray patient record to inactive
				UPDATE patients SET dg_id=-dg_id,dr_id=-dr_id,active=0,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@deleted_id 
			--Update enchanced_encounter End
			 					
		COMMIT
	  
	END  TRY
	
	BEGIN CATCH
		ROLLBACK -- Rollback TRANSACTION
		
		DECLARE @ErrorMessage AS NVARCHAR(4000),@ErrorSeverity AS INT,@ErrorState AS INT;
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','mergePatients','Primary PatientId:'+CONVERT(VARCHAR(500),@new_id)+',Secondry PatientId:'+CONVERT(VARCHAR(500),@deleted_id),ERROR_LINE ())				   
	END CATCH
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
