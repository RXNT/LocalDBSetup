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
