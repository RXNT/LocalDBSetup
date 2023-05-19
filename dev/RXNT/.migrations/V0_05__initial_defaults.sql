ALTER TABLE [adm].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__7DFAF530] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[admin_companies] ADD CONSTRAINT [DF_admin_companies_admin_company_rights] DEFAULT ((0)) FOR [admin_company_rights]
GO
ALTER TABLE [dbo].[admin_companies] ADD CONSTRAINT [DF_admin_companies_enabled] DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[admin_sales_exclusions] ADD  DEFAULT ((0)) FOR [SALES_PERSON_ID]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_username] DEFAULT ('') FOR [admin_username]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_password] DEFAULT ('') FOR [admin_password]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_first_name] DEFAULT ('') FOR [admin_first_name]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_middle_initial] DEFAULT ('') FOR [admin_middle_initial]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_last_name] DEFAULT ('') FOR [admin_last_name]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF__admin_use__enabl__69092E94] DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_users_admin_user_rights] DEFAULT ((-1)) FOR [admin_user_rights]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_users_admin_user_create_date] DEFAULT (getdate()) FOR [admin_user_create_date]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ((0)) FOR [sales_person_id]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ('') FOR [tracker_uid]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ('') FOR [tracker_pwd]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ((0)) FOR [is_token]
GO
ALTER TABLE [aut].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__6371E77D] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [bk].[doctors] ADD CONSTRAINT [DF__doctors__created__2B17B46A] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[doctors_Imports] ADD CONSTRAINT [DF__doctors_I__creat__292F6BF8] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[dr_custom_messages] ADD CONSTRAINT [DF__dr_custom__creat__27472386] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__creat__36896716] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[erx_patients] ADD CONSTRAINT [DF__erx_patie__creat__1DBDB94C] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[interaction_warning_log] ADD CONSTRAINT [DF__interacti__creat__7F39322C] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[lab_main] ADD CONSTRAINT [DF__lab_main__create__3871AF88] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[lab_pat_details] ADD CONSTRAINT [DF__lab_pat_d__creat__1BD570DA] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[MUMeasureCounts] ADD CONSTRAINT [DF__MUMeasure__creat__19ED2868] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patients] ADD CONSTRAINT [DF__patients__create__666D8462] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patients_fav_pharms] ADD CONSTRAINT [DF__patients___creat__2CFFFCDC] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_diagnosis] ADD CONSTRAINT [DF__patient_a__creat__1804DFF6] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_diagnosis_external] ADD CONSTRAINT [DF__patient_a__creat__161C9784] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_diagnosis_external] ADD CONSTRAINT [DF_patient_active_diagnosis_external_is_from_ccd_1] DEFAULT ((0)) FOR [is_from_ccd]
GO
ALTER TABLE [bk].[patient_active_meds] ADD CONSTRAINT [DF__patient_a__creat__14344F12] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_meds_external] ADD CONSTRAINT [DF__patient_a__creat__124C06A0] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_meds_external] ADD CONSTRAINT [DF_patient_active_meds_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
ALTER TABLE [bk].[patient_appointment_request] ADD CONSTRAINT [DF__patient_a__creat__1063BE2E] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_care_providers] ADD CONSTRAINT [DF__patient_c__creat__0E7B75BC] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_consent] ADD CONSTRAINT [DF__patient_c__creat__0C932D4A] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_documents] ADD CONSTRAINT [DF__patient_d__creat__0AAAE4D8] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_electronic_forms] ADD CONSTRAINT [DF__patient_e__is_re__07A91F05] DEFAULT ((0)) FOR [is_reviewed_by_prescriber]
GO
ALTER TABLE [bk].[patient_extended_details] ADD CONSTRAINT [DF__patient_e__creat__08C29C66] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_family_hx] ADD CONSTRAINT [DF__patient_f__creat__06DA53F4] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_flag_details] ADD CONSTRAINT [DF__patient_f__creat__04F20B82] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_hm_alerts] ADD CONSTRAINT [DF__patient_h__creat__0309C310] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_immunization_registry_settings] ADD CONSTRAINT [DF__patient_i__creat__01217A9E] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__creat__34A11EA4] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_lab_orders_master] ADD CONSTRAINT [DF__patient_l__creat__255EDB14] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_login] ADD CONSTRAINT [DF__patient_l__creat__237692A2] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_measure_compliance] ADD CONSTRAINT [DF__patient_m__creat__218E4A30] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_medical_hx] ADD CONSTRAINT [DF__patient_m__creat__1FA601BE] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_medications_hx] ADD CONSTRAINT [DF__patient_m__creat__30D08DC0] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_new_allergies] ADD CONSTRAINT [DF__patient_n__creat__798058D6] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_new_allergies_external] ADD CONSTRAINT [DF__patient_n__creat__77981064] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_new_allergies_external] ADD CONSTRAINT [DF_patient_new_allergies_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
ALTER TABLE [bk].[patient_next_of_kin] ADD CONSTRAINT [DF__patient_n__creat__75AFC7F2] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_notes] ADD CONSTRAINT [DF__patient_n__creat__32B8D632] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_phr_access_log] ADD CONSTRAINT [DF__patient_p__creat__73C77F80] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_procedures] ADD CONSTRAINT [DF__patient_p__creat__71DF370E] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_profile] ADD CONSTRAINT [DF__patient_p__creat__6FF6EE9C] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_registration] ADD CONSTRAINT [DF__patient_r__creat__6C265DB8] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_reg_db] ADD CONSTRAINT [DF__patient_r__creat__6E0EA62A] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_social_hx] ADD CONSTRAINT [DF__patient_s__creat__6A3E1546] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_visit] ADD CONSTRAINT [DF__patient_v__creat__3E2A88DE] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_vitals] ADD CONSTRAINT [DF__patient_v__creat__6855CCD4] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[prescriptions] ADD CONSTRAINT [DF__prescript__creat__2EE8454E] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[referral_main] ADD CONSTRAINT [DF__referral___creat__3A59F7FA] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[refill_requests] ADD CONSTRAINT [DF__refill_re__creat__3C42406C] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[scheduled_rx_archive] ADD CONSTRAINT [DF__scheduled__creat__4012D150] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[scheduler_main] ADD CONSTRAINT [DF__scheduler__creat__7B68A148] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[tblVaccinationRecord] ADD CONSTRAINT [DF__tblVaccin__creat__7D50E9BA] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[company_forms] ADD  DEFAULT ((0)) FOR [pres_id]
GO
ALTER TABLE [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] ADD CONSTRAINT [DF_cqm2018_DoctorCQMCalcPop3CMS138v6_NQF0028_Numerator] DEFAULT ((0)) FOR [Numerator]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_EmpID] DEFAULT ((0)) FOR [EmpID]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_OrderID] DEFAULT ((0)) FOR [OrderID]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_bSendSuccess] DEFAULT ((0)) FOR [bSendAttempted]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_bSMTPSVGFailed] DEFAULT ((0)) FOR [bSMTPSVGFailed]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strLastSMTPError] DEFAULT ('') FOR [strSMTPSVGErrorMsg]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strMDFailedAddress] DEFAULT ('') FOR [strMDFailedAddress]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strSubject] DEFAULT ('') FOR [strSubject]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strMDSessionTranscript] DEFAULT ('') FOR [strMDSessionTranscript]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_strBody] DEFAULT ('') FOR [strBody]
GO
ALTER TABLE [dbo].[CustomerEmailQueue] ADD CONSTRAINT [DF_CustomerEmailQueue_lngMasterOrderID] DEFAULT ((0)) FOR [lngMasterOrderID]
GO
ALTER TABLE [dbo].[CustomerNotes] ADD CONSTRAINT [DF_CustomerNotes_bVoid] DEFAULT ((0)) FOR [bVoid]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustSalesPersonID] DEFAULT ((0)) FOR [CustSalesPersonID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustFirstName] DEFAULT ('') FOR [CustFirstName]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustLastName] DEFAULT ('') FOR [CustLastName]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustEmail] DEFAULT ('') FOR [CustEmail]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustAddress1] DEFAULT ('') FOR [CustAddress1]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustAddress2] DEFAULT ('') FOR [CustAddress2]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustCity] DEFAULT ('') FOR [CustCity]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustState] DEFAULT ('') FOR [CustState]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustZip] DEFAULT ('') FOR [CustZip]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustOfficePhone] DEFAULT ('') FOR [CustOfficePhone]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustHomePhone] DEFAULT ('') FOR [CustHomePhone]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustFax] DEFAULT ('') FOR [CustFax]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustMobile] DEFAULT ('') FOR [CustMobile]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustComments] DEFAULT ('') FOR [CustComments]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_RigID] DEFAULT ((0)) FOR [CustRigID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustBoatName] DEFAULT ('') FOR [CustBoatName]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_PeachTreeID] DEFAULT ('') FOR [PeachTreeID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_bIs205DiscountCust] DEFAULT ((0)) FOR [bIs205DiscountCust]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_LastEdited] DEFAULT (getdate()) FOR [LastEdited]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustCountry] DEFAULT ('') FOR [CustCountry]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_lngCountryID] DEFAULT ((0)) FOR [lngCountryID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustShippingCountryID] DEFAULT ((0)) FOR [CustShippingCountryID]
GO
ALTER TABLE [dbo].[custom_drugs] ADD  DEFAULT ((0)) FOR [dc_id]
GO
ALTER TABLE [dbo].[custom_drug_options] ADD CONSTRAINT [DF__custom_dr__add_d__169AEF1A] DEFAULT (getdate()) FOR [add_date]
GO
ALTER TABLE [dbo].[cust_drug_taper_info] ADD CONSTRAINT [DF_cust_drug_taper_info_Active] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[direct_email_addresses] ADD CONSTRAINT [DF_direct_email_addresses_DirectPassword] DEFAULT ('Yhsfw@34adws') FOR [DirectPassword]
GO
ALTER TABLE [dbo].[direct_email_addresses] ADD CONSTRAINT [DF_direct_email_addresses_AgreementAccepted] DEFAULT ((0)) FOR [AgreementAccepted]
GO
ALTER TABLE [dbo].[direct_email_addresses] ADD CONSTRAINT [DF_direct_email_addresses_DirectDomainID] DEFAULT ((0)) FOR [DirectDomainID]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__doctoriss__Conta__4420F751] DEFAULT ('') FOR [ContactName]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__doctoriss__Conta__45151B8A] DEFAULT ('') FOR [Contact]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__DoctorIss__resol__46093FC3] DEFAULT ((0)) FOR [resolution_status]
GO
ALTER TABLE [dbo].[DoctorIssues] ADD CONSTRAINT [DF__DoctorIss__Respo__628582E0] DEFAULT ('') FOR [Response]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dc_id] DEFAULT ((0)) FOR [dr_field_not_used1]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_username] DEFAULT ('') FOR [dr_username]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_password] DEFAULT ('') FOR [dr_password]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_first_name] DEFAULT ('') FOR [dr_first_name]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_middle_initial] DEFAULT ('') FOR [dr_middle_initial]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_last_name] DEFAULT ('') FOR [dr_last_name]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_address1] DEFAULT ('') FOR [dr_address1]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_address2] DEFAULT ('') FOR [dr_address2]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_city] DEFAULT ('') FOR [dr_city]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_state] DEFAULT ('') FOR [dr_state]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_zip] DEFAULT ('') FOR [dr_zip]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_phone] DEFAULT ('') FOR [dr_phone]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_lic_numb] DEFAULT ('') FOR [dr_lic_numb]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_lic_state] DEFAULT ('') FOR [dr_lic_state]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_dea_numb] DEFAULT ('') FOR [dr_dea_numb]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_sig_file] DEFAULT (' ') FOR [dr_sig_file]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_sig_width] DEFAULT (' ') FOR [dr_sig_width]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_sig_height] DEFAULT (' ') FOR [dr_sig_height]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_create_date] DEFAULT (getdate()) FOR [dr_create_date]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_enabled] DEFAULT ((1)) FOR [dr_enabled]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_ma] DEFAULT ((0)) FOR [dr_ma]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_prim_dr_id] DEFAULT ((0)) FOR [prim_dr_id]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_last_pat_id] DEFAULT ('') FOR [dr_last_pat_id]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_last_phrm_id] DEFAULT ('') FOR [dr_last_phrm_id]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_def_pharm_state] DEFAULT ('') FOR [dr_def_pharm_state]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_def_pharm_city] DEFAULT ('') FOR [dr_def_pharm_city]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_palm_dev_id] DEFAULT ('') FOR [dr_palm_dev_id]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_palm_conn_time] DEFAULT (((1)/(1))/(95)) FOR [dr_palm_conn_time]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_agreement_acptd] DEFAULT ((0)) FOR [dr_agreement_acptd]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_logoff_int] DEFAULT ((1)) FOR [dr_logoff_int]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_pharm_search_opt] DEFAULT ((0)) FOR [dr_pharm_search_opt]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_logged_in] DEFAULT ((0)) FOR [dr_logged_in]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_time_difference] DEFAULT ((0)) FOR [time_difference]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_hipaa_agreement_acptd] DEFAULT ((0)) FOR [hipaa_agreement_acptd]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_fav_patients_criteria] DEFAULT ((0)) FOR [fav_patients_criteria]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_qlf] DEFAULT ((0)) FOR [dr_type]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_prescribing_authority] DEFAULT ((-1)) FOR [prescribing_authority]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_medco_target_physician] DEFAULT ((0)) FOR [medco_target_physician]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_sfi_is_sfi] DEFAULT ((0)) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_sfi_password_decrypted] DEFAULT ((0)) FOR [sfi_password_decrypted]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_report_print_date] DEFAULT (((7)/(1))/(2004)) FOR [report_print_date]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_def_print_options] DEFAULT ((0)) FOR [dr_def_print_options]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_def_no_pharm_print_options] DEFAULT ((0)) FOR [dr_def_no_pharm_print_options]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_def_pat_history_back_to] DEFAULT ((0)) FOR [dr_def_pat_history_back_to]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_last_alias_dr_id] DEFAULT ((0)) FOR [dr_last_alias_dr_id]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_last_auth_dr_id] DEFAULT ((0)) FOR [dr_last_auth_dr_id]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_def_rxcard_history_back_to] DEFAULT ((24)) FOR [dr_def_rxcard_history_back_to]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_rxcard_search_consent_type] DEFAULT ('Y') FOR [dr_rxcard_search_consent_type]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_dea_displayed] DEFAULT ((0)) FOR [dr_dea_hidden]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_opt_two_printers] DEFAULT ((0)) FOR [dr_opt_two_printers]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_office_contact_name] DEFAULT ('') FOR [office_contact_name]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_office_contact_email] DEFAULT ('') FOR [office_contact_email]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_office_contact_phone] DEFAULT ('') FOR [office_contact_phone]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_best_call_time] DEFAULT ('') FOR [best_call_time]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_practice_mgmt_sys] DEFAULT ('') FOR [practice_mgmt_sys]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_internet_connect_type] DEFAULT ('') FOR [internet_connect_type]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_pda_type] DEFAULT ('') FOR [pda_type]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_how_heard_about] DEFAULT ('') FOR [how_heard_about]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_numb_dr_in_practice] DEFAULT ((0)) FOR [numb_dr_in_practice]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_is_sub_practice] DEFAULT ((0)) FOR [is_sub_practice]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_use_pda] DEFAULT ((0)) FOR [use_pda]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_professional_designation] DEFAULT ('') FOR [professional_designation]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_dr_force_pass_change] DEFAULT ((0)) FOR [dr_force_pass_change]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__rxhub_r__00D5CB2D] DEFAULT ((1)) FOR [rxhub_reportable]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF_doctors_ss_enable] DEFAULT ((0)) FOR [ss_enable]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__dr_view__342B5201] DEFAULT ((1)) FOR [dr_view_group_prescriptions]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__epocrat__5D227A9C] DEFAULT ((0)) FOR [epocrates_active]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__billing__5E169ED5] DEFAULT ((0)) FOR [billing_enabled]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__rights__5F0AC30E] DEFAULT ((0)) FOR [rights]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__severit__387B05D2] DEFAULT ((2)) FOR [DR_SEVERITY]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__dr_stat__6073E893] DEFAULT ((0)) FOR [dr_status]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__lab_ena__5A860513] DEFAULT ((0)) FOR [lab_enabled]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__lowusag__61F21CB1] DEFAULT ((0)) FOR [lowusage_lock]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__loginlo__6E57F396] DEFAULT ((0)) FOR [loginlock]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__loginat__6F4C17CF] DEFAULT ((0)) FOR [loginattempts]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__isMigra__1943E849] DEFAULT ((0)) FOR [isMigrated]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__IsEmail__4ADB43DD] DEFAULT ((0)) FOR [IsEmailVerified]
GO
ALTER TABLE [dbo].[doctors] ADD CONSTRAINT [DF__doctors__IsEmail__4CC38C4F] DEFAULT ((0)) FOR [IsEmailVerificationPending]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dc_id] DEFAULT ((0)) FOR [dr_field_not_used1]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dr_first_name] DEFAULT ('') FOR [dr_first_name]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dr_middle_initial] DEFAULT ('') FOR [dr_middle_initial]
GO
ALTER TABLE [dbo].[doctors_log_delete] ADD CONSTRAINT [DF_doctors_log_dr_last_name] DEFAULT ('') FOR [dr_last_name]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app_i__PM__169198D0] DEFAULT ((0)) FOR [PM]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app___EHR__1785BD09] DEFAULT ((0)) FOR [EHR]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app___ERX__1879E142] DEFAULT ((0)) FOR [ERX]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_app__EPCS__196E057B] DEFAULT ((0)) FOR [EPCS]
GO
ALTER TABLE [dbo].[doctor_app_info] ADD CONSTRAINT [DF__doctor_ap__SCHED__1A6229B4] DEFAULT ((0)) FOR [SCHEDULER]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ('') FOR [dr_dea_first_name]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ('') FOR [dr_dea_last_name]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ('') FOR [dr_dea_middle_initial]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [blowusageemail]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((1)) FOR [is_custom_tester]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [is_epcs]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [settings]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF__doctor_in__Versi__61DDD96F] DEFAULT ('ehrv8') FOR [VersionURL]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF__doctor_in__bOver__161275E3] DEFAULT ((0)) FOR [bOverrideDEA]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF_doctor_info_encounter_version] DEFAULT ('v1.1') FOR [encounter_version]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [is_institutional_dea]
GO
ALTER TABLE [dbo].[doctor_info] ADD  DEFAULT ((0)) FOR [hide_encounter_sign_confirmation_popup]
GO
ALTER TABLE [dbo].[doctor_info] ADD CONSTRAINT [DF_doctor_info_dont_ignore_popup_on_doctor_sign_encounter] DEFAULT ((0)) FOR [dont_ignore_popup_on_doctor_sign_encounter]
GO
ALTER TABLE [dbo].[doctor_patient_messages] ADD CONSTRAINT [DF_doctor_pa_msg_date] DEFAULT (NULL) FOR [msg_date]
GO
ALTER TABLE [dbo].[doctor_patient_messages] ADD CONSTRAINT [DF__doctor_pa__is_re__6F6CDEB7] DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[doc_admin] ADD  DEFAULT (7 / 1 / 2004) FOR [report_date]
GO
ALTER TABLE [dbo].[doc_admin] ADD  DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [dbo].[doc_admin] ADD CONSTRAINT [DF__doc_admin__versi__3F88C16B] DEFAULT ('10.6') FOR [version]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT (0) FOR [partner_id]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF__doc_compa__SHOW___1551C526] DEFAULT ((0)) FOR [SHOW_EMAIL]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF_doc_companies_dc_host_id] DEFAULT ((1)) FOR [dc_host_id]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT ((1)) FOR [admin_company_id]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF__doc_compa__emr_m__4DEB2404] DEFAULT ((255)) FOR [emr_modules]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT ((0)) FOR [dc_settings]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF__doc_compa__Enabl__21CC1117] DEFAULT ((0)) FOR [EnableV2EncounterTemplate]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT ((0)) FOR [IsBannerAdsDisabled]
GO
ALTER TABLE [dbo].[doc_company_hosts] ADD CONSTRAINT [DF_doc_company_hosts_dc_host_login_proto] DEFAULT ('') FOR [dc_host_login_proto]
GO
ALTER TABLE [dbo].[doc_fav_pharms] ADD CONSTRAINT [DF_doc_fav_pharms_update_code] DEFAULT (0) FOR [update_code]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_script] DEFAULT (' ') FOR [dosage]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_use_generic] DEFAULT ((0)) FOR [use_generic]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_prn] DEFAULT ((0)) FOR [prn]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_as_directed] DEFAULT ((0)) FOR [as_directed]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_drug_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF_doc_fav_scripts_prn_description] DEFAULT ('') FOR [prn_description]
GO
ALTER TABLE [dbo].[doc_fav_scripts] ADD CONSTRAINT [DF__doc_fav_s__compo__0194E53C] DEFAULT ((0)) FOR [compound]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_beta_tester] DEFAULT ((0)) FOR [beta_tester]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_sfi_group] DEFAULT ((0)) FOR [sfi_group]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_sfi_patient_lookup] DEFAULT ((0)) FOR [sfi_patient_lookup]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_payment_plan_id] DEFAULT ((1)) FOR [payment_plan_id]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_payment_reoccurrence] DEFAULT ((0)) FOR [payment_reoccurrence]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF__doc_group__sched__7FAC9CCA] DEFAULT ((1)) FOR [scheduled_enabled]
GO
ALTER TABLE [dbo].[doc_groups] ADD  DEFAULT ((0)) FOR [lab_status]
GO
ALTER TABLE [dbo].[doc_groups] ADD  DEFAULT ((0)) FOR [emr_modules]
GO
ALTER TABLE [dbo].[doc_group_actions] ADD CONSTRAINT [DF_doc_group_actions_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[doc_group_encounter_templates] ADD CONSTRAINT [DF__doc_group__enc_n__2FE2F609] DEFAULT ('') FOR [enc_name]
GO
ALTER TABLE [dbo].[doc_group_enhanced_encounter_templates] ADD CONSTRAINT [DF__doc_group__enc_n__2D06895E] DEFAULT ('') FOR [enc_name]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_script] DEFAULT (' ') FOR [dosage]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_use_generic] DEFAULT ((0)) FOR [use_generic]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_prn] DEFAULT ((0)) FOR [prn]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_as_directed] DEFAULT ((0)) FOR [as_directed]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_drug_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF_doc_group_fav_scripts_prn_description] DEFAULT ('') FOR [prn_description]
GO
ALTER TABLE [dbo].[doc_group_fav_scripts] ADD CONSTRAINT [DF__doc_group__compo__4F8A1F0A] DEFAULT ((0)) FOR [compound]
GO
ALTER TABLE [dbo].[doc_group_freetext_meds] ADD CONSTRAINT [DF__doc_group__drug___4600B4D0] DEFAULT ((0)) FOR [drug_category]
GO
ALTER TABLE [dbo].[doc_group_freetext_med_ingredients] ADD CONSTRAINT [DF_doc_group_freetext_med_ingredients_is_active] DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[doc_group_hm_rules] ADD CONSTRAINT [DF_doc_group_hm_rules_date_added] DEFAULT (getdate()) FOR [date_added]
GO
ALTER TABLE [dbo].[doc_group_module_action] ADD CONSTRAINT [DF_doc_group_module_action_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[doc_group_module_info] ADD CONSTRAINT [DF_doc_group_module_info_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[doc_group_page_info] ADD CONSTRAINT [DF_doc_group_page_info_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[doc_group_page_module_info] ADD CONSTRAINT [DF_doc_group_page_module_info_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ('') FOR [password1]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ('') FOR [password2]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ('') FOR [password3]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ((1)) FOR [nowactive]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_stage] DEFAULT ((0)) FOR [stage]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_comments] DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_ups_tracking_id] DEFAULT ('') FOR [ups_tracking_id]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_ups_label_file] DEFAULT ('') FOR [ups_label_file]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_fee] DEFAULT ((0)) FOR [shipping_fee]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_address1] DEFAULT ('') FOR [shipping_address1]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_city] DEFAULT ('') FOR [shipping_city]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_state] DEFAULT ('XX') FOR [shipping_state]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF_doc_token_info_shipping_zip] DEFAULT ('') FOR [shipping_zip]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__email__7450C40E] DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__idret__0F04BA4A] DEFAULT ((0)) FOR [idretries]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__maxid__0FF8DE83] DEFAULT ((0)) FOR [maxidretries]
GO
ALTER TABLE [dbo].[doc_token_info] ADD CONSTRAINT [DF__doc_token__IsSig__7B5E7FA7] DEFAULT ((0)) FOR [IsSigRequired]
GO
ALTER TABLE [dbo].[dr_custom_messages] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[dr_custom_messages] ADD CONSTRAINT [dr_custom_messages_message_typeid_default] DEFAULT ((1)) FOR [message_typeid]
GO
ALTER TABLE [dbo].[dr_email_alert_rec] ADD CONSTRAINT [DF__dr_email___frequ__03B3CE86] DEFAULT ((1)) FOR [frequency]
GO
ALTER TABLE [dbo].[dtproperties] ADD CONSTRAINT [DF__dtpropert__versi__02DC7882] DEFAULT (0) FOR [version]
GO
ALTER TABLE [ehr].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__0571F9C6] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [enc].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__1884CE3A] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__enc_t__0CB8B83C] DEFAULT ('') FOR [enc_text]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__chief__0DACDC75] DEFAULT ('') FOR [chief_complaint]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced___type__6CE4AC70] DEFAULT ('RxNTEncounterModels.EnhancedPatientEncounter') FOR [type]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__issig__6ECCF4E2] DEFAULT ((0)) FOR [issigned]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__last___4D21E854] DEFAULT (getdate()) FOR [last_modified_date]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__is_mu__72D81F51] DEFAULT ((0)) FOR [is_multisignature]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__is_in__73CC438A] DEFAULT ((0)) FOR [is_inreview]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD  DEFAULT (NULL) FOR [EncounterReasonSnomedCode]
GO
ALTER TABLE [dbo].[enchanced_encounter_additional_info] ADD CONSTRAINT [DF__enchanced___type__1F9BE01D] DEFAULT ('RxNTEncounterModels.EnhancedPatientEncounter') FOR [type]
GO
ALTER TABLE [dbo].[enchanced_encounter_additional_info] ADD CONSTRAINT [DF__enchanced__issig__20900456] DEFAULT ((0)) FOR [issigned]
GO
ALTER TABLE [dbo].[enchanced_encounter_additional_info] ADD CONSTRAINT [DF__enchanced__last___2184288F] DEFAULT (getdate()) FOR [last_modified_date]
GO
ALTER TABLE [dbo].[enchanced_encounter_templates] ADD  DEFAULT ('') FOR [enc_name]
GO
ALTER TABLE [dbo].[encounter_form_settings] ADD CONSTRAINT [DF__encounter___name__1BD3DA2C] DEFAULT ('') FOR [name]
GO
ALTER TABLE [dbo].[encounter_smart_form_settings] ADD CONSTRAINT [DF__encounter___formid] DEFAULT ('') FOR [form_id]
GO
ALTER TABLE [epa].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__6A88F960] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_dc_id] DEFAULT (0) FOR [dc_id]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_pa_sex] DEFAULT ('U') FOR [pa_sex]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_pa_address1] DEFAULT ('') FOR [pa_address1]
GO
ALTER TABLE [dbo].[erx_patients] ADD CONSTRAINT [DF_erx_patients_pa_address2] DEFAULT ('') FOR [pa_address2]
GO
ALTER TABLE [dbo].[erx_senders] ADD CONSTRAINT [DF_erx_senders_generate_tracking_numb] DEFAULT (0) FOR [generate_tracking_numb]
GO
ALTER TABLE [ext].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__0EFB6400] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_update_code] DEFAULT (0) FOR [update_code]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_notes_update_code] DEFAULT (0) FOR [notes_update_code]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_drugs_update_code] DEFAULT (0) FOR [drugs_update_code]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_pharm_update_code] DEFAULT (0) FOR [pharm_update_code]
GO
ALTER TABLE [dbo].[form_fill_options] ADD  DEFAULT ((0)) FOR [sort_order]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ('') FOR [uid]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ('') FOR [pwd]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((0)) FOR [allergy_upload]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((0)) FOR [diagnosis_upload]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD  DEFAULT ((0)) FOR [sched_upload]
GO
ALTER TABLE [dbo].[hl7_cross_reference] ADD CONSTRAINT [DF_hl7_cross_reference_chart_no] DEFAULT ((0)) FOR [chart_no]
GO
ALTER TABLE [dbo].[hx_migrated_encounters] ADD  DEFAULT ((0)) FOR [error]
GO
ALTER TABLE [dbo].[ICWTransmitter_transactions] ADD  DEFAULT ((0)) FOR [PD_ID]
GO
ALTER TABLE [dbo].[ICWTransmitter_transactions] ADD  DEFAULT ((0)) FOR [pres_void_transmit]
GO
ALTER TABLE [dbo].[lab_main] ADD CONSTRAINT [DF_lab_main_is_read] DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[lab_main] ADD CONSTRAINT [DF__lab_main__PROV_N__5230B634] DEFAULT ('') FOR [PROV_NAME]
GO
ALTER TABLE [dbo].[lab_main] ADD CONSTRAINT [DF__lab_main__type__3CAC54C0] DEFAULT ('Lab') FOR [type]
GO
ALTER TABLE [dbo].[lab_partners] ADD CONSTRAINT [DF__lab_partn__partn__51E69D71] DEFAULT ('') FOR [partner_sendapp_text]
GO
ALTER TABLE [dbo].[lab_test_lists] ADD CONSTRAINT [DF_lab_test_lists_active] DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[lab_test_lists] ADD CONSTRAINT [DF__lab_test___test___607ED58B] DEFAULT ((1)) FOR [test_type]
GO
ALTER TABLE [dbo].[lab_test_lists] ADD CONSTRAINT [DF__lab_test___CODE___226272D8] DEFAULT ('LOINC') FOR [CODE_TYPE]
GO
ALTER TABLE [dbo].[language_resource] ADD  DEFAULT ((0)) FOR [POSITION]
GO
ALTER TABLE [mda].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__220E3874] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[messaging_folders] ADD CONSTRAINT [DF_messaging_folders_parent_folder_id] DEFAULT ((0)) FOR [parent_folder_id]
GO
ALTER TABLE [dbo].[messaging_folder_types] ADD CONSTRAINT [DF_messaging_folder_types_icon_image] DEFAULT ('') FOR [icon_image]
GO
ALTER TABLE [dbo].[messaging_messages] ADD CONSTRAINT [DF_messaging_messages_mm_create_date] DEFAULT (getdate()) FOR [mm_create_date]
GO
ALTER TABLE [dbo].[MichiganTargetPhysicians] ADD CONSTRAINT [DF_MichiganTargetPhysicians_faxed] DEFAULT ((0)) FOR [faxed]
GO
ALTER TABLE [dbo].[MichiganTargetPhysicians] ADD CONSTRAINT [DF_MichiganTargetPhysicians_not_interested] DEFAULT ((0)) FOR [not_interested]
GO
ALTER TABLE [dbo].[MIPSMeasures] ADD CONSTRAINT [DF__MIPSMeasu__Measu__631AB187] DEFAULT (NULL) FOR [MeasureClass]
GO
ALTER TABLE [dbo].[MIPSMeasures] ADD CONSTRAINT [DF__MIPSMeasu__Perfo__640ED5C0] DEFAULT (NULL) FOR [Performace_points_per_10_percent]
GO
ALTER TABLE [dbo].[MIPSMeasures] ADD CONSTRAINT [DF__MIPSMeasu__Measu__6502F9F9] DEFAULT (NULL) FOR [MeasureCalculation]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_db_ver] DEFAULT (256) FOR [db_ver]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_city_ver] DEFAULT (0) FOR [city_ver]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_app_ver] DEFAULT ('') FOR [app_ver]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_url] DEFAULT ('') FOR [url]
GO
ALTER TABLE [dbo].[misc] ADD CONSTRAINT [DF_misc_file] DEFAULT ('') FOR [fileName]
GO
ALTER TABLE [dbo].[MU3Measures] ADD CONSTRAINT [DF__MU3Measur__Measu__1A072CD5] DEFAULT ('Core Measures') FOR [MeasureGroupName]
GO
ALTER TABLE [dbo].[MU4Measures] ADD CONSTRAINT [DF__MU4Measur__Measu__1A072CD5] DEFAULT ('Core Measures') FOR [MeasureGroupName]
GO
ALTER TABLE [dbo].[MUMeasures] ADD CONSTRAINT [DF__MUMeasure__Measu__7619DC46] DEFAULT ('Core Measures') FOR [MeasureGroupName]
GO
ALTER TABLE [dbo].[PARTNER_ACCOUNTS] ADD CONSTRAINT [DF_PARTNER_ACCOUNTS_ENABLED] DEFAULT ((0)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[PARTNER_ACCOUNTS] ADD CONSTRAINT [DF_PARTNER_ACCOUNTS_admin_company_id] DEFAULT ((0)) FOR [admin_company_id]
GO
ALTER TABLE [dbo].[passwords_change_log] ADD CONSTRAINT [DF_passwords_change_log_user_type] DEFAULT (1) FOR [user_type]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_EncounterId] DEFAULT (NULL) FOR [EncounterId]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_EffectiveDate] DEFAULT (getdate()) FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_CreatedUserId] DEFAULT (NULL) FOR [CreatedUserId]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_CreatedTimestamp] DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_LastModifiedUserId] DEFAULT (NULL) FOR [LastModifiedUserId]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_LastModifiedTimestamp] DEFAULT (getdate()) FOR [LastModifiedTimestamp]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_License] DEFAULT (NULL) FOR [License]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_RoleDescription] DEFAULT (NULL) FOR [RoleDescription]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_PhoneNumber] DEFAULT (NULL) FOR [PhoneNumber]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_Email] DEFAULT (NULL) FOR [Email]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_AddressId] DEFAULT (NULL) FOR [AddressId]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_StatusId] DEFAULT (NULL) FOR [StatusId]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT ('') FOR [RoleCode]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT ('') FOR [LastName]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT ((1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_EncounterId] DEFAULT (NULL) FOR [EncounterId]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_EffectiveDate] DEFAULT (getdate()) FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_CreatedUserId] DEFAULT (NULL) FOR [CreatedUserId]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_CreatedTimestamp] DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_LastModifiedUserId] DEFAULT (NULL) FOR [LastModifiedUserId]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_LastModifiedTimestamp] DEFAULT (getdate()) FOR [LastModifiedTimestamp]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_EncounterId] DEFAULT (NULL) FOR [EncounterId]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_EffectiveDate] DEFAULT (getdate()) FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_CreatedUserId] DEFAULT (NULL) FOR [CreatedUserId]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_CreatedTimestamp] DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_LastModifiedUserId] DEFAULT (NULL) FOR [LastModifiedUserId]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_LastModifiedTimestamp] DEFAULT (getdate()) FOR [LastModifiedTimestamp]
GO
ALTER TABLE [dbo].[PatientImportFiles] ADD CONSTRAINT [DF_PatientImportFiles_PIFileImportComplete] DEFAULT ((0)) FOR [PIFileImportComplete]
GO
ALTER TABLE [dbo].[PatientImportFiles] ADD CONSTRAINT [DF_PatientImportFiles_PIFileUploadDateTime] DEFAULT (getdate()) FOR [PIFileUploadDateTime]
GO
ALTER TABLE [dbo].[PatientImportFiles] ADD CONSTRAINT [DF_PatientImportFiles_PIFileUserFieldMapIndexes] DEFAULT ('') FOR [PIFileUserFieldMapIndexes]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_dg_id] DEFAULT (0) FOR [dg_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_dr_id] DEFAULT (0) FOR [dr_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_first] DEFAULT (' ') FOR [pa_first]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_middle] DEFAULT (' ') FOR [pa_middle]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_last] DEFAULT (' ') FOR [pa_last]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_ssn] DEFAULT (' ') FOR [pa_ssn]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_address1] DEFAULT (' ') FOR [pa_address1]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_address2] DEFAULT (' ') FOR [pa_address2]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_city] DEFAULT (' ') FOR [pa_city]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_state] DEFAULT (' ') FOR [pa_state]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_zip] DEFAULT (' ') FOR [pa_zip]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_phone] DEFAULT (' ') FOR [pa_phone]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_wgt] DEFAULT (0) FOR [pa_wgt]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_sex] DEFAULT (' ') FOR [pa_sex]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ic_id] DEFAULT (0) FOR [ic_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ic_group_numb] DEFAULT (' ') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_id] DEFAULT (' ') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_first] DEFAULT (' ') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_mi] DEFAULT (' ') FOR [card_holder_mi]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_card_holder_last] DEFAULT (' ') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ins_pat_numb] DEFAULT (' ') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ins_relate_code] DEFAULT (' ') FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_ins_person_code] DEFAULT (' ') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_formulary_id] DEFAULT (' ') FOR [formulary_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_alternative_id] DEFAULT (' ') FOR [alternative_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_bin] DEFAULT (' ') FOR [pa_bin]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_primary_pharm_id] DEFAULT (0) FOR [primary_pharm_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_pa_notes] DEFAULT (' ') FOR [pa_notes]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_def_ins_id] DEFAULT (0) FOR [def_ins_id]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_last_check_date] DEFAULT (1 / 1 / 2000) FOR [last_check_date]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF_patients_check_eligibility] DEFAULT (0) FOR [check_eligibility]
GO
ALTER TABLE [dbo].[patients] ADD CONSTRAINT [DF__patients__sfi_is__046664EF] DEFAULT (0) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[patients] ADD  DEFAULT (0) FOR [pa_ht]
GO
ALTER TABLE [dbo].[patients] ADD  DEFAULT (getdate()) FOR [add_date]
GO
ALTER TABLE [dbo].[patients] ADD  DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_ic_group_numb] DEFAULT (' ') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_card_holder_id] DEFAULT (' ') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_card_holder_first] DEFAULT (' ') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_card_holder_mi] DEFAULT (' ') FOR [card_holder_mi]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_card_holder_last] DEFAULT (' ') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_ic_plan_numb] DEFAULT (' ') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_ins_relate_code] DEFAULT (' ') FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_ins_person_code] DEFAULT (' ') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_formulary_id] DEFAULT (' ') FOR [formulary_id]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_alternative_id] DEFAULT (' ') FOR [alternative_id]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_pa_bin] DEFAULT (' ') FOR [pa_bin]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_pa_notes] DEFAULT (' ') FOR [pa_notes]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patient_coverage_info_def_ins_id] DEFAULT (0) FOR [def_ins_id]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD CONSTRAINT [DF_patients_coverage_info_formulary_type] DEFAULT (1) FOR [formulary_type]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [copay_id]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [coverage_id]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ((0)) FOR [pa_diff_info]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [longterm_pharmacy_coverage]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [specialty_pharmacy_coverage]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [prim_payer]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [sec_payer]
GO
ALTER TABLE [dbo].[patients_coverage_info] ADD  DEFAULT ('') FOR [ter_payer]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ic_group_numb] DEFAULT (' ') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_id] DEFAULT (' ') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_first] DEFAULT (' ') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_mi] DEFAULT (' ') FOR [card_holder_mi]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_card_holder_last] DEFAULT (' ') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ic_plan_numb] DEFAULT (' ') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ins_relate_code] DEFAULT (' ') FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_ins_person_code] DEFAULT (' ') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_formulary_id] DEFAULT (' ') FOR [formulary_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_alternative_id] DEFAULT (' ') FOR [alternative_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_pa_bin] DEFAULT (' ') FOR [pa_bin]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_pa_notes] DEFAULT (' ') FOR [pa_notes]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_def_ins_id] DEFAULT ((0)) FOR [def_ins_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD CONSTRAINT [DF_patients_coverage_info_external_formulary_type] DEFAULT ((1)) FOR [formulary_type]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD  DEFAULT ('') FOR [copay_id]
GO
ALTER TABLE [dbo].[patients_coverage_info_external] ADD  DEFAULT ('') FOR [coverage_id]
GO
ALTER TABLE [dbo].[patients_member_info] ADD  DEFAULT ((0)) FOR [pharm_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_dg_id] DEFAULT ((0)) FOR [dg_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_dr_id] DEFAULT ((0)) FOR [dr_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_first] DEFAULT (' ') FOR [pa_first]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_middle] DEFAULT (' ') FOR [pa_middle]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_last] DEFAULT (' ') FOR [pa_last]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_ssn] DEFAULT (' ') FOR [pa_ssn]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_address1] DEFAULT (' ') FOR [pa_address1]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_address2] DEFAULT (' ') FOR [pa_address2]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_city] DEFAULT (' ') FOR [pa_city]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_state] DEFAULT (' ') FOR [pa_state]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_zip] DEFAULT (' ') FOR [pa_zip]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_phone] DEFAULT (' ') FOR [pa_phone]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_wgt] DEFAULT ((0)) FOR [pa_wgt]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_sex] DEFAULT (' ') FOR [pa_sex]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_ic_id] DEFAULT ((0)) FOR [ic_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_ic_group_numb] DEFAULT (' ') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_card_holder_id] DEFAULT (' ') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_card_holder_first] DEFAULT (' ') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_card_holder_mi] DEFAULT (' ') FOR [card_holder_mi]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_card_holder_last] DEFAULT (' ') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_ins_pat_numb] DEFAULT (' ') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_ins_relate_code] DEFAULT (' ') FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_ins_person_code] DEFAULT (' ') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_formulary_id] DEFAULT (' ') FOR [formulary_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_alternative_id] DEFAULT (' ') FOR [alternative_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_bin] DEFAULT (' ') FOR [pa_bin]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_primary_pharm_id] DEFAULT ((0)) FOR [primary_pharm_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_notes] DEFAULT (' ') FOR [pa_notes]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_def_ins_id] DEFAULT ((0)) FOR [def_ins_id]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_last_check_date] DEFAULT (((1)/(1))/(2000)) FOR [last_check_date]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_check_eligibility] DEFAULT ((0)) FOR [check_eligibility]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF__patients_merge__sfi_is__046664EF] DEFAULT ((0)) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD CONSTRAINT [DF_patients_merge_pa_ht] DEFAULT ((0)) FOR [pa_ht]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD  DEFAULT (getdate()) FOR [add_date]
GO
ALTER TABLE [dbo].[patients_merge_back] ADD  DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[patient_activemeds_deleted] ADD  DEFAULT ((0)) FOR [deleted_dr_id]
GO
ALTER TABLE [dbo].[patient_active_diagnosis] ADD CONSTRAINT [DF_patient_active_diagnosis_icd9] DEFAULT ('') FOR [icd9]
GO
ALTER TABLE [dbo].[patient_active_diagnosis] ADD CONSTRAINT [DF__patient_a__enabl__304FD425] DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[patient_active_diagnosis] ADD CONSTRAINT [DF__patient_a__recor__3EE8D796] DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[patient_active_diagnosis_external] ADD CONSTRAINT [DF_patient_active_diagnosis_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
ALTER TABLE [dbo].[patient_active_meds] ADD CONSTRAINT [DF_patient_active_meds_from_pres_id] DEFAULT (0) FOR [from_pd_id]
GO
ALTER TABLE [dbo].[patient_active_meds] ADD  DEFAULT (0) FOR [compound]
GO
ALTER TABLE [dbo].[patient_active_meds] ADD CONSTRAINT [DF__patient_a__drug___71601421] DEFAULT ('') FOR [drug_name]
GO
ALTER TABLE [dbo].[patient_active_meds_external] ADD CONSTRAINT [DF_patient_active_meds_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
ALTER TABLE [dbo].[patient_care_providers] ADD CONSTRAINT [DF__patient_c__enabl__2415B120] DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD CONSTRAINT [DF_patient_claims_history_claim_download_date] DEFAULT (getdate()) FOR [claim_download_date]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD CONSTRAINT [DF_patient_claims_history_ddid] DEFAULT ((0)) FOR [ddid]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD CONSTRAINT [DF_patient_claims_history_ndc] DEFAULT ('') FOR [ndc]
GO
ALTER TABLE [dbo].[patient_claims_history] ADD  DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[patient_electronic_forms] ADD  DEFAULT ((0)) FOR [is_reviewed_by_prescriber]
GO
ALTER TABLE [dbo].[patient_encounters] ADD CONSTRAINT [DF__patient_e__enc_t__479C827A] DEFAULT ('') FOR [enc_reason]
GO
ALTER TABLE [dbo].[patient_family_hx] ADD CONSTRAINT [DF_patient_family_hx_enable] DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[patient_family_hx_external] ADD CONSTRAINT [DF_patient_family_hx_external_enable] DEFAULT ((1)) FOR [pfhe_enable]
GO
ALTER TABLE [dbo].[patient_hospitalization_hx] ADD CONSTRAINT [DF__patient_h__enabl__20FCAC79] DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[patient_hospitalization_hx_external] ADD CONSTRAINT [DF__patient_h__phe_e__23D91924] DEFAULT ((1)) FOR [phe_enable]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_pa_id] DEFAULT ((0)) FOR [pa_id]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_lab_test_id] DEFAULT ((0)) FOR [lab_test_id]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_lab_test_name] DEFAULT ('') FOR [lab_test_name]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_added_by] DEFAULT ((0)) FOR [added_by]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_order_status] DEFAULT ((0)) FOR [order_status]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_comments] DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_last_edit_by] DEFAULT ((0)) FOR [last_edit_by]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF_patient_lab_orders_from_main_lab_id] DEFAULT ((0)) FOR [from_main_lab_id]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__recur__7E0F3872] DEFAULT ('') FOR [recurringinformation]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__diagn__7F035CAB] DEFAULT ('') FOR [diagnosis]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__urgen__7FF780E4] DEFAULT ((1)) FOR [urgency]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__sendE__2CE0014B] DEFAULT ((0)) FOR [sendElectronically]
GO
ALTER TABLE [dbo].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__test___2D350706] DEFAULT ((0)) FOR [test_type]
GO
ALTER TABLE [dbo].[patient_login] ADD  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[patient_login] ADD CONSTRAINT [DF__patient_l__signa__1365B5CB] DEFAULT ('') FOR [signature]
GO
ALTER TABLE [dbo].[patient_login] ADD CONSTRAINT [DF__patient_l__passw__154DFE3D] DEFAULT ('1.0') FOR [passwordversion]
GO
ALTER TABLE [dbo].[patient_login] ADD  DEFAULT (NULL) FOR [inactivated_by]
GO
ALTER TABLE [dbo].[patient_login] ADD  DEFAULT (NULL) FOR [inactivated_date]
GO
ALTER TABLE [dbo].[patient_medical_hx] ADD CONSTRAINT [DF_patient_medical_hx_enable] DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[patient_medical_hx_external] ADD CONSTRAINT [DF_patient_medical_hx_external_enable] DEFAULT ((1)) FOR [pme_enable]
GO
ALTER TABLE [dbo].[patient_new_allergies] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[patient_new_allergies_external] ADD CONSTRAINT [DF_patient_new_allergies_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
ALTER TABLE [dbo].[patient_notes] ADD CONSTRAINT [DF_patient_notes_note_date] DEFAULT (getdate()) FOR [note_date]
GO
ALTER TABLE [dbo].[patient_notes] ADD CONSTRAINT [DF_patient_notes_void] DEFAULT (0) FOR [void]
GO
ALTER TABLE [dbo].[patient_notes] ADD  DEFAULT ((0)) FOR [partner_id]
GO
ALTER TABLE [dbo].[patient_phr_access_log] ADD  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[patient_phr_access_log] ADD  DEFAULT (NULL) FOR [phr_access_datetime_utc]
GO
ALTER TABLE [dbo].[patient_procedures] ADD CONSTRAINT [DF__patient_p__recor__13C96F67] DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[patient_social_hx] ADD CONSTRAINT [DF_patient_social_hx_enable] DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[patient_surgery_hx] ADD CONSTRAINT [DF_patient_surgery_hx_enable] DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[patient_surgery_hx_external] ADD CONSTRAINT [DF_patient_surgery_hx_external_enable] DEFAULT ((1)) FOR [pse_enable]
GO
ALTER TABLE [dbo].[patient_visit] ADD  DEFAULT ((0)) FOR [vital_id]
GO
ALTER TABLE [dbo].[patient_vitals] ADD  DEFAULT ((0)) FOR [pa_oxm]
GO
ALTER TABLE [dbo].[patient_vitals] ADD  DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[patient_vitals] ADD  DEFAULT ((0)) FOR [pa_hc]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_rxhub_pmb_id] DEFAULT ('') FOR [rxhub_pmb_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ic_group_numb] DEFAULT ('') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ic_plan_numb] DEFAULT ('') FOR [ic_plan_numb]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_formulary_id] DEFAULT ('') FOR [formulary_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_alternative_id] DEFAULT ('') FOR [alternative_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_pbm_member_id] DEFAULT ('') FOR [pbm_member_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_pa_bin] DEFAULT ('') FOR [pa_bin]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ins_relate_code] DEFAULT (21) FOR [ins_relate_code]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_ins_person_code] DEFAULT ('') FOR [ins_person_code]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_id] DEFAULT ('') FOR [card_holder_id]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_first] DEFAULT ('') FOR [card_holder_first]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_middle] DEFAULT ('') FOR [card_holder_middle]
GO
ALTER TABLE [dbo].[pat_ins_info] ADD CONSTRAINT [DF_pat_ins_info_card_holder_last] DEFAULT ('') FOR [card_holder_last]
GO
ALTER TABLE [dbo].[payor_login] ADD  DEFAULT ((0)) FOR [SEARCHID]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_rxhub_part_id] DEFAULT ('               ') FOR [rxhub_part_id]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_pbm_name] DEFAULT ('') FOR [pbm_name]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_pbm_notes] DEFAULT ('') FOR [pbm_notes]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_disp_string] DEFAULT ('') FOR [disp_string]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF_pbms_disp_options] DEFAULT ('') FOR [disp_options]
GO
ALTER TABLE [dbo].[pbms] ADD CONSTRAINT [DF__pbms__is_gcn_bas__59DE5BA2] DEFAULT ((0)) FOR [is_gcn_based_form]
GO
ALTER TABLE [dbo].[pending_transmittals] ADD CONSTRAINT [DF_pending_transmittals_pending_ack] DEFAULT ((0)) FOR [pending_ack]
GO
ALTER TABLE [dbo].[pending_transmittals] ADD CONSTRAINT [DF_pending_transmittals_pres_delivery_method] DEFAULT ((1)) FOR [pres_delivery_method]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_notify_fax] DEFAULT (0) FOR [pharm_notify_fax]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_notify_email] DEFAULT (0) FOR [pharm_notify_email]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_participant] DEFAULT (1) FOR [pharm_participant]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_ncpdp_numb] DEFAULT (0) FOR [ncpdp_numb]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_disp_type] DEFAULT (1) FOR [disp_type]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_enable_dummy_code] DEFAULT (0) FOR [enable_dummy_code]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF__pharmacie__sfi_i__037240B6] DEFAULT (0) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_added_by_dr_id] DEFAULT (0) FOR [pharm_added_by_dr_id]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_pending_addition] DEFAULT (0) FOR [pharm_pending_addition]
GO
ALTER TABLE [dbo].[pharmacies] ADD  DEFAULT ((3)) FOR [SS_VERSION]
GO
ALTER TABLE [dbo].[pharmacy_users] ADD CONSTRAINT [DF_pharmacy_users_pharm_user_agreement_acptd] DEFAULT ((0)) FOR [pharm_user_agreement_acptd]
GO
ALTER TABLE [dbo].[pharmacy_users] ADD CONSTRAINT [DF_pharmacy_users_pharm_user_hipaa_agreement_acptd] DEFAULT ((0)) FOR [pharm_user_hipaa_agreement_acptd]
GO
ALTER TABLE [phr].[PatientEmailLogs] ADD CONSTRAINT [DF_Token] DEFAULT (NULL) FOR [Token]
GO
ALTER TABLE [phr].[RegistrationWorkflow] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[practice_def_formulary_files] ADD CONSTRAINT [DF__practice___pbms___19C0A931] DEFAULT ('') FOR [pbms_cross_id]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pharm_viewed] DEFAULT (0) FOR [pharm_viewed]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_off_dr_list] DEFAULT (0) FOR [off_dr_list]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_opener_user_id] DEFAULT (0) FOR [opener_user_id]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptio_pres_is_ref] DEFAULT (0) FOR [pres_is_refill]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_rx_number] DEFAULT (' ') FOR [rx_number]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_last_pharm_name] DEFAULT (' ') FOR [last_pharm_name]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_last_pharm_address] DEFAULT (' ') FOR [last_pharm_address]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_last_pharm_city] DEFAULT (' ') FOR [last_pharm_city]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_last_pharm_state] DEFAULT (' ') FOR [last_pharm_state]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_last_pharm_phone] DEFAULT (' ') FOR [last_pharm_phone]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pharm_state_holder] DEFAULT (' ') FOR [pharm_state_holder]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pharm_city_holder] DEFAULT (' ') FOR [pharm_city_holder]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pharm_id_holder] DEFAULT (' ') FOR [pharm_id_holder]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pres_delivery_method] DEFAULT (1) FOR [pres_delivery_method]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_prim_dr_id] DEFAULT (0) FOR [prim_dr_id]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_print_count] DEFAULT (0) FOR [print_count]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pda_written] DEFAULT (0) FOR [pda_written]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF__prescript__sfi_i__055A8928] DEFAULT (0) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_patient_delivery_method] DEFAULT (0) FOR [field_not_used1]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pres_void] DEFAULT (0) FOR [pres_void]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_last_edit_dr_id] DEFAULT (0) FOR [last_edit_dr_id]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pres_prescription_type] DEFAULT (1) FOR [pres_prescription_type]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_pres_void_comments] DEFAULT ('') FOR [pres_void_comments]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_off_pharm_list] DEFAULT (0) FOR [off_pharm_list]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_DoPrintAfterPatHistory] DEFAULT (0) FOR [DoPrintAfterPatHistory]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_DoPrintAfterPatOrig] DEFAULT (0) FOR [DoPrintAfterPatOrig]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_DoPrintAfterPatCopy] DEFAULT (0) FOR [DoPrintAfterPatCopy]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_DoPrintAfterPatMonograph] DEFAULT (0) FOR [DoPrintAfterPatMonograph]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_PatOrigPrintType] DEFAULT (0) FOR [PatOrigPrintType]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_PrintHistoryBackMonths] DEFAULT (3) FOR [PrintHistoryBackMonths]
GO
ALTER TABLE [dbo].[prescriptions] ADD CONSTRAINT [DF_prescriptions_DoPrintAfterScriptGuide] DEFAULT (0) FOR [DoPrintAfterScriptGuide]
GO
ALTER TABLE [dbo].[prescriptions] ADD  DEFAULT (0) FOR [send_count]
GO
ALTER TABLE [dbo].[prescriptions] ADD  DEFAULT ((0)) FOR [print_options]
GO
ALTER TABLE [dbo].[prescriptions] ADD  DEFAULT ((0)) FOR [is_signed]
GO
ALTER TABLE [dbo].[prescriptions_archive] ADD  DEFAULT ((0)) FOR [is_signed]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_pharm_viewed] DEFAULT (0) FOR [pharm_viewed]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_opener_user_id] DEFAULT (0) FOR [opener_user_id]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_rx_number] DEFAULT (' ') FOR [rx_number]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_pres_delivery_method] DEFAULT (1) FOR [pres_delivery_method]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_prim_dr_id] DEFAULT (0) FOR [prim_dr_id]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_print_count] DEFAULT (0) FOR [print_count]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_pda_written] DEFAULT (0) FOR [pda_written]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_pres_void] DEFAULT (0) FOR [pres_void]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_pres_prescription_type] DEFAULT (1) FOR [pres_prescription_type]
GO
ALTER TABLE [dbo].[prescriptions_change_log] ADD CONSTRAINT [DF_prescription_change_log_pres_void_comments] DEFAULT ('') FOR [pres_void_comments]
GO
ALTER TABLE [dbo].[prescription_coverage_info] ADD CONSTRAINT [DF__prescript__ic_gr__25676607] DEFAULT ('') FOR [ic_group_numb]
GO
ALTER TABLE [dbo].[prescription_coverage_info] ADD CONSTRAINT [DF__prescript__formu__265B8A40] DEFAULT ('0') FOR [formulary_id]
GO
ALTER TABLE [dbo].[prescription_coverage_info] ADD CONSTRAINT [DF__prescript__formu__274FAE79] DEFAULT ((0)) FOR [formulary_type]
GO
ALTER TABLE [dbo].[Prescription_Date_Info] ADD CONSTRAINT [DF_Prescription_Date_Info_Active] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_drug_name] DEFAULT (' ') FOR [drug_name]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_use_generic] DEFAULT ((0)) FOR [use_generic]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_numb_refills] DEFAULT ((0)) FOR [numb_refills]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_prn] DEFAULT ((0)) FOR [prn]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_as_directed] DEFAULT ((0)) FOR [as_directed]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_form_status] DEFAULT ((-1)) FOR [form_status]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_actual_form_status] DEFAULT ((-1)) FOR [actual_form_status]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_enabled] DEFAULT ((1)) FOR [history_enabled]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_patient_delivery_method] DEFAULT ((0)) FOR [patient_delivery_method]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_vps_pres_id] DEFAULT ('') FOR [vps_pres_id]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_include_in_print] DEFAULT ((1)) FOR [include_in_print]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_include_in_pharm_deliver] DEFAULT ((1)) FOR [include_in_pharm_deliver]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF_prescription_details_prn_description] DEFAULT ('') FOR [prn_description]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF__prescript__compo__00A0C103] DEFAULT ((0)) FOR [compound]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF__prescripti__icd9__1E3123EA] DEFAULT ('') FOR [icd9]
GO
ALTER TABLE [dbo].[prescription_details] ADD CONSTRAINT [DF__prescript__is_specialty] DEFAULT (NULL) FOR [is_specialty]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_drug_name] DEFAULT (' ') FOR [drug_name]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_use_generic] DEFAULT (0) FOR [use_generic]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_numb_refills] DEFAULT (0) FOR [numb_refills]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_comments] DEFAULT (' ') FOR [comments]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_prn] DEFAULT (0) FOR [prn]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_as_directed] DEFAULT (0) FOR [as_directed]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_drug_version] DEFAULT ('FDB1.1') FOR [drug_version]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_history_enabled] DEFAULT (1) FOR [history_enabled]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_patient_delivery_method] DEFAULT (0) FOR [patient_delivery_method]
GO
ALTER TABLE [dbo].[prescription_details_change_log] ADD CONSTRAINT [DF_prescription_details_change_log_vps_pres_id] DEFAULT ('') FOR [vps_pres_id]
GO
ALTER TABLE [dbo].[prescription_pharm_actions] ADD CONSTRAINT [DF_prescription_pharm_actions_action_date] DEFAULT (getdate()) FOR [action_date]
GO
ALTER TABLE [dbo].[prescription_pharm_actions] ADD CONSTRAINT [DF_prescription_pharm_actions_detail_text] DEFAULT ('') FOR [detail_text]
GO
ALTER TABLE [dbo].[prescription_sendws_log] ADD CONSTRAINT [DF_prescription_sendws_log_entry_date] DEFAULT (getdate()) FOR [entry_date]
GO
ALTER TABLE [dbo].[prescription_sendws_partner_log] ADD CONSTRAINT [DF_prescription_sendws_partner_log_entry_date] DEFAULT (getdate()) FOR [entry_date]
GO
ALTER TABLE [dbo].[prescription_taper_info] ADD CONSTRAINT [DF_prescription_taper_info_Active] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[prescription_transmittals] ADD  DEFAULT (0) FOR [transmission_flags]
GO
ALTER TABLE [dbo].[PrinterMaster] ADD CONSTRAINT [DF_PrinterMaster_is_activated] DEFAULT ((1)) FOR [is_activated]
GO
ALTER TABLE [dbo].[printer_registration] ADD CONSTRAINT [DF__printer_r__pm_id__5CB79AF1] DEFAULT ((0)) FOR [pm_id]
GO
ALTER TABLE [prv].[AppLoginTokens] ADD CONSTRAINT [DF__AppLoginT__Activ__5EE23C8A] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[referral_dr_carrier_ids] ADD  DEFAULT ((-1)) FOR [CARRIER_XREF_ID]
GO
ALTER TABLE [dbo].[referral_main] ADD  DEFAULT ((0)) FOR [inst_id]
GO
ALTER TABLE [dbo].[referral_michigan_det] ADD  DEFAULT ((0)) FOR [bWorkerComp]
GO
ALTER TABLE [dbo].[referral_michigan_det] ADD  DEFAULT ((0)) FOR [bautoacc]
GO
ALTER TABLE [dbo].[referral_michigan_det] ADD  DEFAULT ('') FOR [icd9]
GO
ALTER TABLE [dbo].[referral_michigan_det] ADD  DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[refill_requests] ADD CONSTRAINT [DF_refill_requests_msg_ref_number] DEFAULT ('') FOR [msg_ref_number]
GO
ALTER TABLE [dbo].[refill_requests] ADD CONSTRAINT [DF__refill_re__disp___0B1E4F76] DEFAULT ((0)) FOR [disp_drug_info]
GO
ALTER TABLE [dbo].[RefTracking] ADD CONSTRAINT [DF_RefTracking_DT] DEFAULT (getdate()) FOR [DT]
GO
ALTER TABLE [dbo].[rxntlibertydo] ADD  DEFAULT ((0)) FOR [void]
GO
ALTER TABLE [dbo].[rxntlibertydo] ADD  DEFAULT ((0)) FOR [sent_item]
GO
ALTER TABLE [dbo].[rxnt_coupons] ADD CONSTRAINT [DF_rxnt_coupons_is_complete] DEFAULT ((0)) FOR [is_complete]
GO
ALTER TABLE [dbo].[rxnt_coupons] ADD CONSTRAINT [DF__rxnt_coup__is_ph__5A7BE372] DEFAULT ((0)) FOR [is_pharm_comment]
GO
ALTER TABLE [dbo].[rxnt_coupons] ADD CONSTRAINT [DF__rxnt_coup__is_ne__5C642BE4] DEFAULT ((0)) FOR [is_new_pat]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD CONSTRAINT [DF__rxnt_sg_p__sessi__07C4568C] DEFAULT ((40541)) FOR [session_count]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD CONSTRAINT [DF__rxnt_sg_p__curre__09AC9EFE] DEFAULT ((0)) FOR [current_count]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [speciality_1]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [speciality_2]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [speciality_3]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ('') FOR [url]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [clickthroughs]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [sponsor_id]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD  DEFAULT ((0)) FOR [increments]
GO
ALTER TABLE [dbo].[rxnt_sg_promotions] ADD CONSTRAINT [DF__rxnt_sg_p__Activ__79B7C505] DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[sales_person_info] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO
ALTER TABLE [dbo].[sales_person_info] ADD  DEFAULT ((1)) FOR [admin_company_id]
GO
ALTER TABLE [dbo].[sales_person_info] ADD  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_pd_id] DEFAULT (0) FOR [pd_id]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_entry_date] DEFAULT (getdate()) FOR [entry_date]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_event_text] DEFAULT ('') FOR [event_text]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_fire_count] DEFAULT (0) FOR [fire_count]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_repeat_unit] DEFAULT ('') FOR [repeat_unit]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_repeat_interval] DEFAULT (0) FOR [repeat_interval]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_repeat_count] DEFAULT (0) FOR [repeat_count]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_event_flags] DEFAULT (0) FOR [event_flags]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_parent_event_id] DEFAULT (0) FOR [parent_event_id]
GO
ALTER TABLE [dbo].[scheduled_rx_archive] ADD CONSTRAINT [DF_scheduled_rx_archive_signature_version] DEFAULT ('V1') FOR [signature_version]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler__ext_l__0D6FE0E5] DEFAULT ((0)) FOR [ext_link_id]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler___note__0E64051E] DEFAULT ('') FOR [note]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler__detai__0F582957] DEFAULT ('') FOR [detail_header]
GO
ALTER TABLE [dbo].[scheduler_main] ADD  DEFAULT ((0)) FOR [is_new_pat]
GO
ALTER TABLE [dbo].[scheduler_main] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[scheduler_main] ADD  DEFAULT ((0)) FOR [is_confirmed]
GO
ALTER TABLE [dbo].[scheduler_main] ADD CONSTRAINT [DF__scheduler__is_de__65E3747D] DEFAULT ((0)) FOR [is_delete_attempt]
GO
ALTER TABLE [dbo].[scheduler_types] ADD CONSTRAINT [DF__scheduler__durat__7683F09A] DEFAULT ('15') FOR [duration]
GO
ALTER TABLE [dbo].[ScriptGuideCoupons] ADD  DEFAULT ((0)) FOR [used]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_trigger_type] DEFAULT ((1)) FOR [trigger_type]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF__ScriptGui__test___41E4747B] DEFAULT ((0)) FOR [test_count]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF__ScriptGui__contr__42D898B4] DEFAULT ((0)) FOR [control_count]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_sg_desc_text] DEFAULT ('') FOR [sg_desc_text]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_bRequireCoupon] DEFAULT ((0)) FOR [bRequireCoupon]
GO
ALTER TABLE [dbo].[ScriptGuideProgramSpecifications] ADD CONSTRAINT [DF_ScriptGuideProgramSpecifications_bIsActive] DEFAULT ((0)) FOR [bIsActive]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors1_sponsor_name] DEFAULT ('') FOR [sponsor_name]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors1_sponsor_lbl] DEFAULT ('') FOR [sponsor_lbl]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors_sponsor_type_id] DEFAULT (0) FOR [sponsor_type_id]
GO
ALTER TABLE [dbo].[sponsors] ADD CONSTRAINT [DF_sponsors_sponsor_msg] DEFAULT ('') FOR [sponsor_msg]
GO
ALTER TABLE [dbo].[State] ADD CONSTRAINT [DF__State__created_d__7B7E7B38] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[StoreCategoryProductTypes] ADD CONSTRAINT [DF_StoreCategoryProductTypes_SortID] DEFAULT ((0)) FOR [SortID]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_Orders_UPSTrackingNumber] DEFAULT ('') FOR [UPSTrackingNumber]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_Orders_CCFailed] DEFAULT ((0)) FOR [CCFailed]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_Orders_CCFailReason] DEFAULT ('') FOR [CCFailReason]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_QEmpID] DEFAULT ((0)) FOR [QEmpID]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_Void] DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_CommissionBilled] DEFAULT ((0)) FOR [RoyaltyBilled]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_RoyaltyPaid] DEFAULT ((0)) FOR [RoyaltyPaid]
GO
ALTER TABLE [dbo].[StorePaymentMethods] ADD CONSTRAINT [DF_PaymentMethods_Enabled] DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [dbo].[StorePayments] ADD CONSTRAINT [DF_Payments_PaymentDate] DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[StorePayments] ADD CONSTRAINT [DF_StorePayments_PONumber] DEFAULT ('') FOR [PONumber]
GO
ALTER TABLE [dbo].[StorePayments] ADD CONSTRAINT [DF_StorePayments_POPaid] DEFAULT ((0)) FOR [POPaid]
GO
ALTER TABLE [dbo].[StoreProductCPT] ADD CONSTRAINT [DF_StoreProductCPT_SortID] DEFAULT ((0)) FOR [SortID]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_InActive] DEFAULT ((0)) FOR [InActive]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_ShowOnHomePage] DEFAULT ((0)) FOR [ShowOnHomePage]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_ForEmployeesOnly] DEFAULT ((0)) FOR [ForEmployeesOnly]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_SortID] DEFAULT ((0)) FOR [SortID]
GO
ALTER TABLE [dbo].[StoreProducts] ADD  DEFAULT ('') FOR [PriceUnits]
GO
ALTER TABLE [dbo].[StoreSalesReports] ADD CONSTRAINT [DF_StoreSalesReports_SSRDate] DEFAULT (getdate()) FOR [SSRDate]
GO
ALTER TABLE [dbo].[StoreSalesReports] ADD CONSTRAINT [DF_StoreSalesReports_SSRPaid] DEFAULT ((0)) FOR [SSRPaid]
GO
ALTER TABLE [dbo].[surescript_admin_message] ADD CONSTRAINT [DF__surescrip__messa__06B8C1B5] DEFAULT ((0)) FOR [message_type]
GO
ALTER TABLE [dbo].[table_audit_log] ADD CONSTRAINT [DF_table_audit_log_audit_id] DEFAULT (newid()) FOR [audit_id]
GO
ALTER TABLE [dbo].[tblHealthGuidelines] ADD CONSTRAINT [DF_tblHealthGuidelines_date_added] DEFAULT (getdate()) FOR [date_added]
GO
ALTER TABLE [dbo].[tblHealthGuidelinesCallHistory] ADD  DEFAULT (getutcdate()) FOR [CraetedOn]
GO
ALTER TABLE [dbo].[tblHealthGuidelinesTemplates] ADD  DEFAULT ((1)) FOR [isactive]
GO
ALTER TABLE [dbo].[tblHealthGuidelinesTemplates] ADD  DEFAULT (getdate()) FOR [date_added]
GO
ALTER TABLE [dbo].[tblHealthGuidelines_Ex1] ADD  DEFAULT (getutcdate()) FOR [RuleNextExecutionOn]
GO
ALTER TABLE [dbo].[tblPatientExternalVaccinationRecord] ADD CONSTRAINT [DF__tblPatientExternalVaccin__recor__15B1B7D9] DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[tblSubHealthGuidelines] ADD CONSTRAINT [DF__tblsubhea__is_ne__4FBD9286] DEFAULT ((0)) FOR [is_neg]
GO
ALTER TABLE [dbo].[tblTasks] ADD CONSTRAINT [DF__tblTasks__task_s__0495A9BF] DEFAULT ('FALSE') FOR [task_src_deleted]
GO
ALTER TABLE [dbo].[tblTasks] ADD CONSTRAINT [DF__tblTasks__task_d__067DF231] DEFAULT ('FALSE') FOR [task_dst_deleted]
GO
ALTER TABLE [dbo].[tblVaccinationRecord] ADD CONSTRAINT [DF__tblVaccin__recor__15B1B7D9] DEFAULT (getdate()) FOR [record_modified_date]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__dc_id__7D9A3726] DEFAULT ((0)) FOR [dc_id]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__vac_e__7E8E5B5F] DEFAULT ('99') FOR [vac_exp_code]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__CVX_C__27114E05] DEFAULT ('') FOR [CVX_CODE]
GO
ALTER TABLE [dbo].[tblVaccines] ADD CONSTRAINT [DF__tblVaccin__mvx_c__28F99677] DEFAULT ('') FOR [mvx_code]
GO
ALTER TABLE [dbo].[temp_encounterupdate_docgroups] ADD CONSTRAINT [DF_PerformedDate] DEFAULT (getdate()) FOR [PerformedDate]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_OFFSET] DEFAULT ((-1)) FOR [OFFSET_HR]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_OFFSET_MI] DEFAULT ((0)) FOR [OFFSET_MI]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_DST_OFFSET] DEFAULT ((-1)) FOR [DST_OFFSET_HR]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_DST_OFFSET_MI] DEFAULT ((0)) FOR [DST_OFFSET_MI]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_DST_EFF_DT] DEFAULT ('03210200') FOR [DST_EFF_DT]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_DST_END_DT] DEFAULT ('11110200') FOR [DST_END_DT]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_EFF_DT] DEFAULT (getutcdate()) FOR [EFF_DT]
GO
ALTER TABLE [dbo].[TIME_ZONES] ADD CONSTRAINT [DF_TIME_ZONES_END_DT] DEFAULT ('12/31/9999') FOR [END_DT]
GO
ALTER TABLE [dbo].[webinars] ADD CONSTRAINT [DF__webinars__meetin__6D849645] DEFAULT ('') FOR [meetingURL]
GO
ALTER TABLE [dbo].[webinars] ADD CONSTRAINT [DF_webinars_activeFlag] DEFAULT ((1)) FOR [activeFlag]
GO
ALTER TABLE [dbo].[webinars] ADD CONSTRAINT [DF__webinars__eventt__790135E9] DEFAULT ((1)) FOR [eventtype_id]
GO
ALTER TABLE [dbo].[webinar_customers] ADD CONSTRAINT [DF__webinar_c__event__7718ED77] DEFAULT ((1)) FOR [eventtype_id]
GO
