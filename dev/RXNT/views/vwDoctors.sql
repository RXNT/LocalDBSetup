SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[vwDoctors]
AS
SELECT doc_groups.dg_id, doc_groups.dg_name, doc_companies.dc_name, doctors.dr_id, doctors.dr_username, doctors.dr_password, 
doctors.dr_prefix, doctors.dr_first_name, doctors.dr_middle_initial, doctors.dr_last_name, doctors.dr_suffix, 
doctors.dr_address1, doctors.dr_address2, doctors.dr_city, doctors.dr_state, doctors.dr_zip, doctors.dr_phone, 
doctors.dr_phone_alt1, doctors.dr_phone_alt2, doctors.dr_phone_emerg, doctors.dr_fax, doctors.dr_lic_numb, 
doctors.dr_lic_state, doctors.dr_dea_numb, doctors.dr_sig_file, doctors.dr_sig_width, doctors.dr_sig_height, 
doctors.dr_create_date, doctors.dr_enabled, doctors.dr_ma, doctors.prim_dr_id, doctors.dr_last_pat_id, 
doctors.dr_last_phrm_id, doctors.dr_def_pharm_state, doctors.dr_def_pharm_city, doctors.dr_palm_dev_id, 
doctors.dr_palm_conn_time, doctors.dr_exp_date, doctors.dr_agreement_acptd, doctors.dr_logoff_int, doc_companies.dc_id, 
doctors.dr_pharm_search_opt, doctors.dr_logged_in, doctors.dr_session_id, doctors.time_difference, 
doctors.hipaa_agreement_acptd, doctors.fav_patients_criteria, doctors.activated_date, doctors.deactivated_date, doctors.dr_type, 
doctors.prescribing_authority, doctors.medco_target_physician, doctors.medco_reported, doctors.report_print_date, 
doctors.dr_def_print_options, doctors.dr_def_no_pharm_print_options, doctors.dr_def_pat_history_back_to, 
doctors.dr_last_alias_dr_id, doctors.dr_last_auth_dr_id, doctors.dr_def_rxcard_history_back_to, 
doctors.dr_rxcard_search_consent_type, doctors.dr_dea_hidden, doctors.dr_opt_two_printers, doctors.office_contact_name, 
doctors.office_contact_email, doctors.office_contact_phone, doctors.best_call_time, doctors.practice_mgmt_sys, 
doctors.internet_connect_type, doctors.pda_type, doctors.how_heard_about, doctors.numb_dr_in_practice, 
doctors.is_sub_practice, doctors.use_pda, doctors.professional_designation, doctors.dr_first_login_date, 
ISNULL(doctors.dr_first_name, '') + ' ' + 
ISNULL(doctors.dr_middle_initial, '') + ' ' + 
ISNULL(doctors.dr_last_name, '') + ' ' + 
ISNULL(doctors.dr_suffix, '') 
AS doctor_full_name
FROM doctors 
INNER JOIN doc_groups ON doctors.dg_id = doc_groups.dg_id 
INNER JOIN doc_companies ON doc_groups.dc_id = doc_companies.dc_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
