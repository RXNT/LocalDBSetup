CREATE TABLE [dbo].[Address] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [Address1] [varchar](200) NOT NULL,
   [Address2] [varchar](200) NULL,
   [PostalCode] [varchar](20) NOT NULL,
   [City] [varchar](200) NOT NULL,
   [StateCode] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_Address_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [adm].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [adm].[MigratedAppointments] (
   [migrated_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [event_id] [int] NOT NULL,
   [ExternalAppointmentId] [bigint] NULL,
   [request_id] [bigint] NOT NULL,
   [status] [int] NOT NULL,
   [retry_count] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastEditedOn] [datetime] NULL

   ,CONSTRAINT [PK_MigratedAppointments] PRIMARY KEY CLUSTERED ([migrated_id])
)


GO
CREATE TABLE [adm].[MigratedPatients] (
   [migrated_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ExternalPatientId] [bigint] NULL,
   [request_id] [bigint] NOT NULL,
   [status] [int] NOT NULL,
   [retry_count] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastEditedOn] [datetime] NULL

   ,CONSTRAINT [PK_MigratedPatients] PRIMARY KEY CLUSTERED ([migrated_id])
)


GO
CREATE TABLE [adm].[PatientDataMigrationRequests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL,
   [reuested_on] [datetime] NOT NULL,
   [migrated_on] [datetime] NULL,
   [status] [int] NOT NULL

   ,CONSTRAINT [PK_PatientDataMigrationRequests] PRIMARY KEY CLUSTERED ([request_id])
)


GO
CREATE TABLE [adm].[PatientQueue] (
   [PatientQueueId] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [ActionType] [varchar](5) NOT NULL,
   [OwnerType] [varchar](5) NOT NULL,
   [QueueStatus] [varchar](5) NOT NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [ModifiedDate] [datetime] NULL,
   [ModifiedBy] [int] NULL,
   [QueueCreatedDate] [datetime] NULL,
   [QueueProcessStartDate] [datetime] NULL,
   [QueueProcessEndDate] [datetime] NULL,
   [JobId] [bigint] NULL

   ,CONSTRAINT [PK_PatientQueue] PRIMARY KEY NONCLUSTERED ([PatientQueueId])
)


GO
CREATE TABLE [adm].[SchedulerDataMigrationRequests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL,
   [reuested_on] [datetime] NOT NULL,
   [migrated_on] [datetime] NULL,
   [status] [int] NOT NULL

   ,CONSTRAINT [PK_SchedulerDataMigrationRequests] PRIMARY KEY CLUSTERED ([request_id])
)


GO
CREATE TABLE [dbo].[admin_companies] (
   [admin_company_id] [int] NOT NULL
      IDENTITY (1,1),
   [admin_company_name] [varchar](100) NOT NULL,
   [admin_company_rights] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_admin_companies] PRIMARY KEY CLUSTERED ([admin_company_id])
)


GO
CREATE TABLE [dbo].[admin_sales_exclusions] (
   [admiinuser_sales_xrefid] [int] NOT NULL
      IDENTITY (1,1),
   [admin_user_id] [int] NOT NULL,
   [SALES_PERSON_ID] [int] NOT NULL

   ,CONSTRAINT [PK_admin_sales_exclusions] PRIMARY KEY CLUSTERED ([admiinuser_sales_xrefid])
)


GO
CREATE TABLE [dbo].[admin_users] (
   [admin_id] [int] NOT NULL
      IDENTITY (1,1),
   [admin_company_id] [int] NULL,
   [admin_username] [varchar](50) NOT NULL,
   [admin_password] [varchar](50) NOT NULL,
   [admin_first_name] [varchar](50) NOT NULL,
   [admin_middle_initial] [varchar](2) NOT NULL,
   [admin_last_name] [varchar](50) NOT NULL,
   [enabled] [bit] NOT NULL,
   [admin_user_rights] [int] NOT NULL,
   [admin_user_create_date] [datetime] NOT NULL,
   [sales_person_id] [int] NOT NULL,
   [tracker_uid] [varchar](50) NOT NULL,
   [tracker_pwd] [varchar](50) NOT NULL,
   [is_token] [bit] NOT NULL

   ,CONSTRAINT [PK_admin_users] PRIMARY KEY NONCLUSTERED ([admin_id])
)


GO
CREATE TABLE [dbo].[All State Ops_RxNT_1-25-16] (
   [First Name] [varchar](50) NULL,
   [MI] [varchar](50) NULL,
   [Last Name] [varchar](50) NULL,
   [CLIENT ID] [varchar](50) NULL,
   [DATE OF BIRTH] [varchar](50) NULL,
   [CLIENT ADDRESS STREET 1] [varchar](50) NULL,
   [CLIENT ADDRESS STREET 2] [varchar](50) NULL,
   [CLIENT ADDRESS CITY] [varchar](50) NULL,
   [CLIENT ADDRESS STATE] [varchar](50) NULL,
   [CLIENT ADDRESS ZIP CODE] [varchar](50) NULL,
   [CLIENT PHONE NUMBER] [varchar](50) NULL,
   [SEX] [varchar](50) NULL
)


GO
CREATE TABLE [dbo].[alternatives] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [acr_id] [int] NOT NULL,
   [source_ndc] [varchar](11) NOT NULL,
   [alternate_ndc] [varchar](11) NOT NULL,
   [form_status] [int] NOT NULL,
   [rel_value] [int] NULL,
   [text] [varchar](200) NULL

   ,CONSTRAINT [PK_alternatives] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[alt_cross_reference] (
   [acr_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [alternative_id] [varchar](10) NOT NULL,
   [rel_value_limit] [int] NOT NULL

   ,CONSTRAINT [PK_alt_cross_reference] PRIMARY KEY CLUSTERED ([acr_id])
)


GO
CREATE TABLE [dbo].[Applications] (
   [ApplicationID] [bigint] NOT NULL
      IDENTITY (1,1),
   [Name] [nvarchar](50) NOT NULL,
   [Descrption] [nvarchar](250) NULL,
   [ApplicationTypeID] [int] NOT NULL,
   [ApplicationVersionID] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime] NULL,
   [InactivatedBy] [bigint] NULL,
   [IsDefault] [bit] NOT NULL

   ,CONSTRAINT [AK_Applications_Column] UNIQUE NONCLUSTERED ([Name])
   ,CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED ([ApplicationID])
)


GO
CREATE TABLE [dbo].[ApplicationTypes] (
   [ApplicationTypeID] [int] NOT NULL,
   [ApplicationTypeName] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_ApplicationTypes] PRIMARY KEY CLUSTERED ([ApplicationTypeID])
)


GO
CREATE TABLE [dbo].[ApplicationVersions] (
   [ApplicationVersionID] [int] NOT NULL,
   [ApplicationVersion] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_ApplicationVersions] PRIMARY KEY CLUSTERED ([ApplicationVersionID])
)


GO
CREATE TABLE [dbo].[AppSettings] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [Category] [varchar](100) NOT NULL,
   [Key] [varchar](100) NOT NULL,
   [Value] [varchar](100) NOT NULL
)


GO
CREATE TABLE [dbo].[ASP_Error_Log] (
   [err_id] [int] NOT NULL
      IDENTITY (1,1),
   [error_code] [int] NOT NULL,
   [error_desc] [varchar](1024) NULL,
   [error_time] [datetime] NOT NULL,
   [application] [varchar](50) NOT NULL,
   [method] [varchar](2048) NULL,
   [comments] [text] NULL

   ,CONSTRAINT [PK_ASP_Error_Log] PRIMARY KEY CLUSTERED ([err_id])
)


GO
CREATE TABLE [dbo].[AttachmentResponseCodes] (
   [codeID] [nvarchar](10) NOT NULL,
   [codeSystemID] [nvarchar](10) NOT NULL,
   [description] [ntext] NULL,
   [sortKey] [nvarchar](50) NULL

   ,CONSTRAINT [PK_AttachmentResponseCodes] PRIMARY KEY CLUSTERED ([codeID])
)


GO
CREATE TABLE [dbo].[AugustTargetDocs] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [DEA] [nvarchar](255) NULL,
   [LastName] [nvarchar](255) NULL,
   [FirstName] [nvarchar](255) NULL,
   [Address] [nvarchar](255) NULL,
   [Address2] [nvarchar](255) NULL,
   [City] [nvarchar](255) NULL,
   [State] [nvarchar](255) NULL,
   [Zip] [nvarchar](255) NULL,
   [Phone] [float] NULL,
   [Fax] [float] NULL,
   [dg_id] [int] NULL

   ,CONSTRAINT [PK_AugustTargetDocs] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [aut].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_aut_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_aut_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [dbo].[aux_doc_messages] (
   [DrMsgId] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [DrMsgDate] [datetime] NULL,
   [DrMsgBy] [varchar](100) NULL,
   [DrMessage] [text] NULL,
   [showMessage] [bit] NOT NULL

   ,CONSTRAINT [PK_aux_doc_messages] PRIMARY KEY CLUSTERED ([DrMsgId])
)


GO
CREATE TABLE [bk].[ enchanced_encounter] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [xml] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](50) NULL,
   [type_of_visit] [char](5) NULL,
   [clinical_summary_first_date] [datetime] NULL

   ,CONSTRAINT [PK_enchanced_encounter] PRIMARY KEY CLUSTERED ([enc_id])
)


GO
CREATE TABLE [bk].[doctors] (
   [dr_last_pat_id] [varchar](30) NOT NULL,
   [fav_patients_criteria] [int] NOT NULL,
   [created_date] [datetime] NOT NULL
)


GO
CREATE TABLE [bk].[doctors_20161108] (
   [dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [dr_username] [varchar](50) NULL,
   [dr_password] [varchar](250) NULL,
   [salt] [varchar](250) NULL,
   [password_expiry_date] [smalldatetime] NULL
)


GO
CREATE TABLE [bk].[doctors_20161109] (
   [dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [dr_username] [varchar](50) NULL,
   [dr_password] [varchar](250) NULL,
   [salt] [varchar](250) NULL,
   [password_expiry_date] [smalldatetime] NULL
)


GO
CREATE TABLE [bk].[doctors_20161111] (
   [dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [dr_field_not_used1] [int] NULL,
   [dr_username] [varchar](50) NULL,
   [dr_password] [varchar](250) NULL,
   [dr_prefix] [varchar](10) NULL,
   [dr_first_name] [varchar](50) NULL,
   [dr_middle_initial] [varchar](20) NULL,
   [dr_last_name] [varchar](50) NULL,
   [dr_suffix] [varchar](20) NULL,
   [dr_address1] [varchar](100) NULL,
   [dr_address2] [varchar](100) NULL,
   [dr_city] [varchar](50) NULL,
   [dr_state] [varchar](30) NULL,
   [dr_zip] [varchar](20) NULL,
   [dr_phone] [varchar](30) NULL,
   [dr_phone_alt1] [varchar](30) NULL,
   [dr_phone_alt2] [varchar](30) NULL,
   [dr_phone_emerg] [varchar](30) NULL,
   [dr_fax] [varchar](30) NULL,
   [dr_email] [varchar](50) NULL,
   [dr_lic_numb] [varchar](50) NULL,
   [dr_lic_state] [varchar](30) NULL,
   [dr_dea_numb] [varchar](30) NULL,
   [dr_sig_file] [varchar](100) NOT NULL,
   [dr_sig_width] [varchar](4) NOT NULL,
   [dr_sig_height] [varchar](4) NOT NULL,
   [dr_create_date] [datetime] NOT NULL,
   [dr_enabled] [bit] NOT NULL,
   [dr_ma] [bit] NOT NULL,
   [prim_dr_id] [int] NOT NULL,
   [dr_last_pat_id] [varchar](30) NOT NULL,
   [dr_last_phrm_id] [varchar](30) NOT NULL,
   [dr_def_pharm_state] [varchar](2) NOT NULL,
   [dr_def_pharm_city] [varchar](50) NOT NULL,
   [dr_palm_dev_id] [varchar](30) NOT NULL,
   [dr_palm_conn_time] [datetime] NOT NULL,
   [dr_exp_date] [datetime] NULL,
   [dr_agreement_acptd] [bit] NOT NULL,
   [dr_logoff_int] [int] NOT NULL,
   [dr_pharm_search_opt] [int] NOT NULL,
   [dr_logged_in] [bit] NOT NULL,
   [dr_session_id] [varchar](255) NULL,
   [time_difference] [int] NULL,
   [hipaa_agreement_acptd] [bit] NOT NULL,
   [fav_patients_criteria] [int] NOT NULL,
   [activated_date] [datetime] NULL,
   [deactivated_date] [datetime] NULL,
   [dr_type] [int] NOT NULL,
   [prescribing_authority] [int] NOT NULL,
   [medco_target_physician] [int] NOT NULL,
   [sfi_docid] [varchar](255) NULL,
   [sfi_docpracticename] [varchar](255) NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_login] [varchar](50) NULL,
   [sfi_encrypted_password] [varchar](50) NULL,
   [sfi_password_decrypted] [bit] NOT NULL,
   [medco_reported] [smalldatetime] NULL,
   [report_print_date] [smalldatetime] NOT NULL,
   [dr_def_print_options] [smallint] NULL,
   [dr_def_no_pharm_print_options] [smallint] NULL,
   [dr_def_pat_history_back_to] [smallint] NULL,
   [dr_last_alias_dr_id] [int] NULL,
   [dr_last_auth_dr_id] [int] NULL,
   [dr_def_rxcard_history_back_to] [smallint] NULL,
   [dr_rxcard_search_consent_type] [varchar](50) NULL,
   [dr_dea_hidden] [bit] NOT NULL,
   [dr_opt_two_printers] [bit] NULL,
   [office_contact_name] [varchar](50) NULL,
   [office_contact_email] [varchar](50) NULL,
   [office_contact_phone] [varchar](50) NULL,
   [best_call_time] [varchar](50) NULL,
   [practice_mgmt_sys] [varchar](50) NULL,
   [internet_connect_type] [varchar](50) NULL,
   [pda_type] [varchar](50) NULL,
   [how_heard_about] [varchar](50) NULL,
   [numb_dr_in_practice] [int] NULL,
   [is_sub_practice] [bit] NULL,
   [use_pda] [bit] NULL,
   [professional_designation] [varchar](50) NULL,
   [medco_rebilled] [bit] NULL,
   [rxhub_reported] [smalldatetime] NULL,
   [medco_rebill_date] [smalldatetime] NULL,
   [dr_first_login_date] [datetime] NULL,
   [dr_force_pass_change] [bit] NOT NULL,
   [rxhub_reportable] [bit] NULL,
   [dr_dea_suffix] [varchar](10) NULL,
   [spi_id] [varchar](19) NULL,
   [password_expiry_date] [smalldatetime] NULL,
   [ss_enable] [bit] NULL,
   [dr_speciality_code] [varchar](50) NULL,
   [dr_view_group_prescriptions] [int] NOT NULL,
   [epocrates_active] [bit] NOT NULL,
   [billing_enabled] [bit] NOT NULL,
   [rights] [bigint] NOT NULL,
   [dr_promo] [varchar](50) NULL,
   [NPI] [varchar](30) NULL,
   [AvgNumb] [int] NULL,
   [printpref] [smallint] NULL,
   [beta_tester] [bit] NULL,
   [DR_SEVERITY] [tinyint] NOT NULL,
   [sales_person_id] [smallint] NULL,
   [dr_status] [smallint] NOT NULL,
   [lab_enabled] [bit] NULL,
   [lowusage_lock] [bit] NOT NULL,
   [loginlock] [bit] NOT NULL,
   [loginattempts] [tinyint] NOT NULL,
   [msg_alert_cell_number] [varchar](20) NULL,
   [commpreference] [char](1) NULL,
   [epcs_enabled] [bit] NULL,
   [billingDate] [datetime] NULL,
   [salt] [varchar](250) NULL,
   [timezone] [varchar](10) NULL,
   [isMigrated] [bit] NOT NULL,
   [IsEmailVerified] [bit] NOT NULL,
   [IsEmailVerificationPending] [bit] NOT NULL
)


GO
CREATE TABLE [bk].[doctors_Imports] (
   [dr_last_pat_id] [varchar](30) NOT NULL,
   [fav_patients_criteria] [int] NOT NULL,
   [created_date] [datetime] NOT NULL
)


GO
CREATE TABLE [bk].[dr_custom_messages] (
   [dr_cst_msg_id] [int] NOT NULL,
   [dr_src_id] [int] NOT NULL,
   [dr_dst_id] [int] NOT NULL,
   [msg_date] [datetime] NOT NULL,
   [message] [text] NOT NULL,
   [is_read] [bit] NOT NULL,
   [is_complete] [bit] NULL,
   [patid] [bigint] NULL,
   [message_typeid] [int] NULL,
   [message_subtypeid] [int] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[enchanced_encounter] (
   [enc_id] [int] NOT NULL,
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](500) NULL,
   [type_of_visit] [char](10) NULL,
   [clinical_summary_first_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [encounter_version] [varchar](10) NULL
)


GO
CREATE TABLE [bk].[enchanced_encounter_additional_info] (
   [enc_info_id] [int] NOT NULL,
   [enc_id] [int] NOT NULL,
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [JSON] [nvarchar](max) NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](50) NULL,
   [type_of_visit] [char](5) NULL,
   [clinical_summary_first_date] [datetime] NULL,
   [active] [bit] NULL,
   [created_date] [datetime] NOT NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[erx_patients] (
   [erx_pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NOT NULL,
   [pa_sex] [char](1) NOT NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [pa_ext] [varchar](10) NULL,
   [pa_email] [varchar](50) NULL,
   [ins_code] [varchar](20) NULL,
   [created_date] [datetime] NOT NULL
)


GO
CREATE TABLE [bk].[interaction_warning_log] (
   [int_warn_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [response] [tinyint] NOT NULL,
   [date] [smalldatetime] NOT NULL,
   [warning_source] [smallint] NULL,
   [reason] [varchar](255) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[lab_main] (
   [lab_id] [int] NOT NULL,
   [send_appl] [varchar](1000) NOT NULL,
   [send_facility] [varchar](1000) NULL,
   [rcv_appl] [varchar](1000) NOT NULL,
   [rcv_facility] [varchar](1000) NOT NULL,
   [message_date] [datetime] NOT NULL,
   [message_type] [varchar](50) NOT NULL,
   [message_ctrl_id] [varchar](100) NULL,
   [version] [varchar](10) NOT NULL,
   [component_sep] [varchar](1) NOT NULL,
   [subcomponent_sep] [varchar](1) NOT NULL,
   [escape_delim] [varchar](1) NOT NULL,
   [filename] [varchar](500) NULL,
   [dr_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [is_read] [bit] NOT NULL,
   [read_by] [int] NULL,
   [PROV_NAME] [varchar](500) NOT NULL,
   [comments] [varchar](7000) NULL,
   [result_file_path] [varchar](255) NULL,
   [lab_order_master_id] [bigint] NULL,
   [type] [varchar](10) NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[lab_pat_details] (
   [lab_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [ext_pat_id] [varchar](1000) NULL,
   [lab_pat_id] [varchar](1000) NOT NULL,
   [alt_pat_id] [varchar](1000) NULL,
   [pa_first] [varchar](200) NOT NULL,
   [pa_last] [varchar](200) NOT NULL,
   [pa_middle] [varchar](200) NOT NULL,
   [pa_dob] [datetime] NOT NULL,
   [pa_sex] [varchar](3) NOT NULL,
   [pa_address1] [varchar](200) NOT NULL,
   [pa_city] [varchar](200) NOT NULL,
   [pa_state] [varchar](5) NOT NULL,
   [pa_zip] [varchar](200) NOT NULL,
   [pa_acctno] [varchar](200) NOT NULL,
   [spm_status] [varchar](200) NULL,
   [fasting] [varchar](200) NOT NULL,
   [notes] [varchar](max) NULL,
   [pa_suffix] [varchar](10) NULL,
   [pa_race] [varchar](35) NULL,
   [pa_alternate_race] [varchar](35) NULL,
   [lab_patid_namespace_id] [varchar](25) NULL,
   [lab_patid_type_code] [varchar](25) NULL,
   [lab_pat_id_uid] [varchar](20) NULL,
   [lab_pat_id_uid_type] [varchar](20) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[MUMeasureCounts] (
   [Id] [bigint] NOT NULL,
   [MUMeasuresId] [int] NOT NULL,
   [MeasureCode] [varchar](3) NOT NULL,
   [dc_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [enc_id] [int] NULL,
   [enc_date] [datetime] NULL,
   [DateAdded] [datetime] NOT NULL,
   [IsNumerator] [bit] NOT NULL,
   [IsDenominator] [bit] NOT NULL,
   [RecordCreateUserId] [int] NULL,
   [RecordCreateDateTime] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patients] (
   [pa_id] [int] NOT NULL,
   [pa_field_not_used1] [int] NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](61) NULL,
   [pa_ssn] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](80) NULL,
   [pa_wgt] [int] NOT NULL,
   [pa_sex] [varchar](1) NOT NULL,
   [ic_id] [int] NOT NULL,
   [ic_group_numb] [varchar](30) NOT NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](50) NOT NULL,
   [card_holder_mi] [varchar](1) NOT NULL,
   [card_holder_last] [varchar](50) NOT NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](30) NOT NULL,
   [primary_pharm_id] [int] NULL,
   [pa_notes] [varchar](255) NULL,
   [ph_drugs] [varchar](100) NULL,
   [pa_email] [varchar](80) NULL,
   [pa_ext] [varchar](10) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [last_check_date] [smalldatetime] NOT NULL,
   [check_eligibility] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_patid] [varchar](50) NULL,
   [pa_ht] [int] NOT NULL,
   [pa_upd_stat] [smallint] NULL,
   [pa_flag] [tinyint] NULL,
   [pa_ext_id] [varchar](20) NULL,
   [access_date] [datetime] NULL,
   [access_user] [int] NULL,
   [pa_ins_type] [tinyint] NULL,
   [pa_race_type] [tinyint] NULL,
   [pa_ethn_type] [tinyint] NULL,
   [pref_lang] [smallint] NULL,
   [add_date] [smalldatetime] NULL,
   [add_by_user] [int] NULL,
   [record_modified_date] [datetime] NULL,
   [pa_ext_ssn_no] [varchar](25) NULL,
   [pa_prefix] [varchar](10) NULL,
   [pa_suffix] [varchar](10) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL

)

CREATE NONCLUSTERED INDEX [ix_patients_merge_reqid] ON [bk].[patients] ([pa_merge_reqid])

GO
CREATE TABLE [bk].[patients_fav_pharms] (
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_use_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_active_diagnosis] (
   [pad] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [icd9] [varchar](100) NOT NULL,
   [added_by_dr_id] [int] NULL,
   [date_added] [datetime] NOT NULL,
   [icd9_description] [varchar](255) NULL,
   [enabled] [tinyint] NOT NULL,
   [onset] [datetime] NULL,
   [severity] [varchar](50) NULL,
   [status] [varchar](10) NULL,
   [type] [smallint] NULL,
   [record_modified_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [status_date] [datetime] NULL,
   [code_type] [varchar](50) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [icd9_desc] [varchar](255) NULL,
   [icd10_desc] [varchar](255) NULL,
   [icd10] [varchar](100) NULL,
   [snomed_code] [varchar](100) NULL,
   [snomed_desc] [varchar](255) NULL,
   [diagnosis_sequence] [int] NULL
)


GO
CREATE TABLE [bk].[patient_active_diagnosis_external] (
   [pde_id] [int] NOT NULL,
   [pde_pa_id] [int] NOT NULL,
   [pde_source_name] [varchar](200) NOT NULL,
   [pde_icd9] [varchar](100) NOT NULL,
   [pde_added_by_dr_id] [int] NULL,
   [pde_date_added] [datetime] NOT NULL,
   [pde_icd9_description] [varchar](200) NOT NULL,
   [pde_enabled] [tinyint] NOT NULL,
   [pde_onset] [datetime] NULL,
   [pde_severity] [varchar](50) NULL,
   [pde_status] [varchar](10) NULL,
   [pde_type] [smallint] NULL,
   [pde_record_modified_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [is_from_ccd] [bit] NULL
)


GO
CREATE TABLE [bk].[patient_active_meds] (
   [pam_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [from_pd_id] [int] NOT NULL,
   [compound] [bit] NOT NULL,
   [comments] [varchar](255) NULL,
   [status] [tinyint] NULL,
   [dt_status_change] [datetime] NULL,
   [change_dr_id] [int] NULL,
   [reason] [varchar](150) NULL,
   [drug_name] [varchar](200) NULL,
   [dosage] [varchar](255) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [drug_comments] [varchar](255) NULL,
   [numb_refills] [int] NULL,
   [use_generic] [int] NULL,
   [days_supply] [smallint] NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [date_start] [datetime] NULL,
   [date_end] [datetime] NULL,
   [for_dr_id] [int] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_active_meds_external] (
   [pame_id] [int] NOT NULL,
   [pame_pa_id] [int] NOT NULL,
   [pame_drug_id] [int] NOT NULL,
   [pame_date_added] [datetime] NOT NULL,
   [pame_compound] [bit] NOT NULL,
   [pame_comments] [varchar](255) NULL,
   [pame_status] [tinyint] NULL,
   [pame_drug_name] [varchar](200) NULL,
   [pame_dosage] [varchar](255) NULL,
   [pame_duration_amount] [varchar](15) NULL,
   [pame_duration_unit] [varchar](80) NULL,
   [pame_drug_comments] [varchar](255) NULL,
   [pame_numb_refills] [int] NULL,
   [pame_use_generic] [int] NULL,
   [pame_days_supply] [smallint] NULL,
   [pame_prn] [bit] NULL,
   [pame_prn_description] [varchar](50) NULL,
   [pame_date_start] [datetime] NULL,
   [pame_date_end] [datetime] NULL,
   [pame_source_name] [varchar](500) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [external_id] [varchar](100) NULL,
   [is_from_ccd] [bit] NULL
)


GO
CREATE TABLE [bk].[patient_appointment_request] (
   [pat_appt_req_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [req_appt_date] [varchar](20) NOT NULL,
   [req_appt_time] [varchar](20) NOT NULL,
   [primary_reason] [varchar](max) NOT NULL,
   [is_completed] [bit] NOT NULL,
   [created_datetime] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_care_providers] (
   [id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [prv_fav_id] [int] NOT NULL,
   [enable] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_consent] (
   [consent_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_documents] (
   [document_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [description] [varchar](225) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [cat_id] [smallint] NOT NULL,
   [owner_id] [bigint] NULL,
   [owner_type] [varchar](3) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_electronic_forms] (
   [electronic_form_id] [int] NULL,
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [description] [varchar](255) NULL,
   [type] [int] NULL,
   [is_reviewed_by_prescriber] [bit] NOT NULL
)


GO
CREATE TABLE [bk].[patient_extended_details] (
   [pa_id] [int] NOT NULL,
   [pa_ext_ref] [bit] NOT NULL,
   [pa_ref_name_details] [varchar](255) NULL,
   [pa_ref_date] [smalldatetime] NULL,
   [prim_dr_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [cell_phone] [varchar](50) NULL,
   [marital_status] [tinyint] NULL,
   [empl_status] [tinyint] NULL,
   [work_phone] [varchar](50) NULL,
   [other_phone] [varchar](50) NULL,
   [comm_pref] [tinyint] NULL,
   [pref_phone] [tinyint] NULL,
   [time_zone] [varchar](6) NULL,
   [pref_start_time] [time] NULL,
   [pref_end_time] [time] NULL,
   [mother_first] [varchar](35) NULL,
   [mother_middle] [varchar](35) NULL,
   [mother_last] [varchar](35) NULL,
   [pa_death_date] [smalldatetime] NULL,
   [emergency_contact_first] [varchar](35) NULL,
   [emergency_contact_last] [varchar](35) NULL,
   [emergency_contact_address1] [varchar](100) NULL,
   [emergency_contact_address2] [varchar](100) NULL,
   [emergency_contact_city] [varchar](50) NULL,
   [emergency_contact_state] [varchar](2) NULL,
   [emergency_contact_zip] [varchar](20) NULL,
   [emergency_contact_phone] [varchar](20) NULL,
   [emergency_contact_release_documents] [bit] NULL,
   [emergency_contact_relationship] [varchar](3) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_family_hx] (
   [fhxid] [bigint] NOT NULL,
   [pat_id] [bigint] NOT NULL,
   [member_relation_id] [int] NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [icd10] [varchar](max) NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL
)


GO
CREATE TABLE [bk].[patient_flag_details] (
   [pa_flag_id] [bigint] NOT NULL,
   [pa_id] [int] NOT NULL,
   [flag_id] [int] NOT NULL,
   [flag_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_hm_alerts] (
   [rule_prf_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [rule_id] [int] NOT NULL,
   [dt_performed] [smalldatetime] NULL,
   [dr_performed_by] [int] NULL,
   [notes] [varchar](max) NULL,
   [due_date] [datetime] NULL,
   [rxnt_status_id] [int] NULL,
   [date_added] [datetime] NULL,
   [last_edited_on] [datetime] NULL,
   [last_edited_by] [int] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_identifiers] (
   [pa_id] [bigint] NOT NULL,
   [pik_id] [bigint] NOT NULL,
   [value] [varchar](50) NULL,
   [created_date] [datetime] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_immunization_registry_settings] (
   [pa_id] [bigint] NOT NULL,
   [publicity_code] [varchar](2) NULL,
   [publicity_code_effective_date] [datetime] NULL,
   [registry_status] [varchar](2) NULL,
   [registry_status_effective_date] [datetime] NULL,
   [entered_by] [bigint] NULL,
   [dr_id] [bigint] NULL,
   [entered_on] [datetime] NULL,
   [modified_on] [datetime] NULL,
   [protection_indicator] [varchar](1) NULL,
   [protection_indicator_effective_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_lab_orders] (
   [pa_lab_id] [bigint] NOT NULL,
   [pa_id] [bigint] NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [lab_test_name] [varchar](500) NOT NULL,
   [added_date] [datetime] NOT NULL,
   [added_by] [bigint] NOT NULL,
   [order_date] [datetime] NOT NULL,
   [order_status] [smallint] NOT NULL,
   [comments] [varchar](500) NOT NULL,
   [last_edit_by] [bigint] NOT NULL,
   [last_edit_date] [datetime] NOT NULL,
   [from_main_lab_id] [bigint] NOT NULL,
   [recurringinformation] [varchar](500) NULL,
   [diagnosis] [varchar](5000) NULL,
   [urgency] [smallint] NOT NULL,
   [dr_id] [bigint] NULL,
   [isActive] [bit] NULL,
   [sendElectronically] [bit] NULL,
   [external_lab_order_id] [varchar](50) NULL,
   [doc_group_lab_xref_id] [int] NULL,
   [abn_file_path] [varchar](255) NULL,
   [requisition_file_path] [varchar](255) NULL,
   [label_file_path] [varchar](255) NULL,
   [lab_master_id] [bigint] NULL,
   [lab_id] [int] NULL,
   [lab_result_info_id] [int] NULL,
   [enc_id] [bigint] NULL,
   [specimen_time] [datetime] NULL,
   [test_type] [smallint] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_lab_orders_master] (
   [lab_master_id] [bigint] NOT NULL,
   [pa_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [added_by] [bigint] NOT NULL,
   [order_date] [datetime] NOT NULL,
   [order_status] [smallint] NOT NULL,
   [comments] [varchar](500) NOT NULL,
   [last_edit_by] [bigint] NOT NULL,
   [last_edit_date] [datetime] NOT NULL,
   [dr_id] [bigint] NULL,
   [isActive] [bit] NULL,
   [external_lab_order_id] [varchar](50) NULL,
   [doc_group_lab_xref_id] [int] NULL,
   [abn_file_path] [varchar](255) NULL,
   [requisition_file_path] [varchar](255) NULL,
   [label_file_path] [varchar](255) NULL,
   [lab_id] [int] NULL,
   [order_sent_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_login] (
   [pa_id] [int] NOT NULL,
   [pa_username] [varchar](30) NOT NULL,
   [pa_password] [varchar](100) NOT NULL,
   [pa_email] [varchar](100) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [salt] [varchar](20) NOT NULL,
   [enabled] [bit] NOT NULL,
   [cellphone] [varchar](20) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_measure_compliance] (
   [rec_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [rec_type] [smallint] NOT NULL,
   [rec_date] [smalldatetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_medical_hx] (
   [medhxid] [bigint] NOT NULL,
   [pat_id] [bigint] NOT NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [icd10] [varchar](max) NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL
)


GO
CREATE TABLE [bk].[patient_medications_hx] (
   [pam_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [from_pd_id] [int] NULL,
   [compound] [bit] NULL,
   [comments] [varchar](255) NULL,
   [status] [tinyint] NULL,
   [dt_status_change] [datetime] NULL,
   [change_dr_id] [int] NULL,
   [reason] [varchar](150) NULL,
   [drug_name] [varchar](200) NULL,
   [dosage] [varchar](255) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [drug_comments] [varchar](255) NULL,
   [numb_refills] [int] NULL,
   [use_generic] [int] NULL,
   [days_supply] [smallint] NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [date_start] [datetime] NULL,
   [date_end] [datetime] NULL,
   [for_dr_id] [int] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_new_allergies] (
   [pa_allergy_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NULL,
   [allergy_type] [smallint] NULL,
   [add_date] [datetime] NOT NULL,
   [comments] [varchar](2000) NULL,
   [reaction_string] [varchar](225) NULL,
   [status] [tinyint] NULL,
   [dr_modified_user] [int] NULL,
   [disable_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [allergy_description] [varchar](500) NULL,
   [record_source] [varchar](500) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_new_allergies_external] (
   [pae_pa_allergy_id] [int] NOT NULL,
   [pae_pa_id] [int] NOT NULL,
   [pae_source_name] [varchar](200) NOT NULL,
   [pae_allergy_id] [int] NULL,
   [pae_allergy_description] [varchar](500) NULL,
   [pae_allergy_type] [smallint] NULL,
   [pae_add_date] [datetime] NOT NULL,
   [pae_comments] [varchar](2000) NULL,
   [pae_reaction_string] [varchar](225) NULL,
   [pae_status] [tinyint] NULL,
   [pae_dr_modified_user] [int] NULL,
   [pae_disable_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [is_from_ccd] [bit] NULL
)


GO
CREATE TABLE [bk].[patient_next_of_kin] (
   [pa_id] [bigint] NULL,
   [kin_relation_code] [varchar](3) NULL,
   [kin_first] [varchar](35) NULL,
   [kin_middle] [varchar](35) NULL,
   [kin_last] [varchar](35) NULL,
   [kin_address1] [varchar](35) NULL,
   [kin_city] [varchar](35) NULL,
   [kin_state] [varchar](2) NULL,
   [kin_zip] [varchar](20) NULL,
   [kin_country] [varchar](10) NULL,
   [kin_phone] [varchar](20) NULL,
   [kin_email] [varchar](50) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_notes] (
   [note_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [note_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [void] [bit] NOT NULL,
   [note_text] [varchar](5000) NULL,
   [partner_id] [tinyint] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [note_html] [varchar](max) NULL
)


GO
CREATE TABLE [bk].[patient_phr_access_log] (
   [phr_access_log_id] [bigint] NOT NULL,
   [pa_id] [bigint] NOT NULL,
   [phr_access_type] [int] NOT NULL,
   [phr_access_description] [varchar](1024) NOT NULL,
   [phr_access_datetime] [datetime] NOT NULL,
   [phr_access_from_ip] [varchar](50) NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_procedures] (
   [procedure_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date_performed] [smalldatetime] NULL,
   [type] [varchar](50) NULL,
   [status] [varchar](50) NULL,
   [code] [varchar](50) NULL,
   [description] [varchar](250) NULL,
   [notes] [varchar](255) NULL,
   [record_modified_date] [datetime] NULL,
   [date_performed_to] [smalldatetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_profile] (
   [profile_id] [int] NOT NULL,
   [patient_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [entry_date] [datetime] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [last_update_dr_id] [int] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_registration] (
   [pa_reg_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [src_id] [smallint] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [token] [varchar](30) NOT NULL,
   [reg_date] [smalldatetime] NOT NULL,
   [exp_date] [smalldatetime] NULL,
   [last_update_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_reg_db] (
   [pat_reg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [date_created] [datetime] NOT NULL,
   [src_type] [smallint] NULL,
   [opt_out] [bit] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_respiration] (
   [pa_resp_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_resp_rate] [int] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL
)


GO
CREATE TABLE [bk].[patient_social_hx] (
   [sochxid] [bigint] NOT NULL,
   [pat_id] [bigint] NULL,
   [emp_info] [varchar](max) NULL,
   [marital_status] [int] NULL,
   [other_marital_status] [varchar](255) NULL,
   [household_people_no] [varchar](50) NULL,
   [smoking_status] [int] NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bigint] NULL,
   [familyhx_other] [varchar](max) NULL,
   [medicalhx_other] [varchar](max) NULL,
   [surgeryhx_other] [varchar](max) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[patient_visit] (
   [visit_id] [int] NOT NULL,
   [appt_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dtCreate] [smalldatetime] NOT NULL,
   [dtEnd] [smalldatetime] NOT NULL,
   [enc_id] [int] NOT NULL,
   [chkout_notes] [varchar](max) NULL,
   [vital_id] [int] NULL,
   [reason] [varchar](255) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [clinical_notes] [varchar](max) NULL
)


GO
CREATE TABLE [bk].[patient_vitals] (
   [pa_vt_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_wt] [float] NOT NULL,
   [pa_ht] [float] NOT NULL,
   [pa_pulse] [float] NOT NULL,
   [pa_bp_sys] [float] NOT NULL,
   [pa_bp_dys] [float] NOT NULL,
   [pa_glucose] [float] NOT NULL,
   [pa_resp_rate] [float] NOT NULL,
   [pa_temp] [float] NOT NULL,
   [pa_bmi] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [dg_id] [int] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL,
   [pa_oxm] [float] NOT NULL,
   [record_modified_date] [datetime] NULL,
   [pa_hc] [float] NOT NULL,
   [pa_bp_location] [int] NULL,
   [pa_bp_sys_statnding] [float] NULL,
   [pa_bp_dys_statnding] [float] NULL,
   [pa_bp_location_statnding] [int] NULL,
   [pa_bp_sys_supine] [float] NULL,
   [pa_bp_dys_supine] [float] NULL,
   [pa_bp_location_supine] [int] NULL,
   [pa_temp_method] [int] NULL,
   [pa_pulse_rhythm] [int] NULL,
   [pa_pulse_standing] [float] NULL,
   [pa_pulse_rhythm_standing] [int] NULL,
   [pa_pulse_supine] [float] NULL,
   [pa_pulse_rhythm_supine] [int] NULL,
   [pa_heart_rate] [float] NULL,
   [pa_fio2] [float] NULL,
   [pa_flow] [float] NULL,
   [pa_resp_quality] [int] NULL,
   [pa_comment] [varchar](max) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[prescriptions] (
   [pres_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [off_dr_list] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [pres_is_refill] [bit] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [last_pharm_name] [varchar](80) NOT NULL,
   [last_pharm_address] [varchar](50) NOT NULL,
   [last_pharm_city] [varchar](30) NOT NULL,
   [last_pharm_state] [varchar](30) NOT NULL,
   [last_pharm_phone] [varchar](30) NOT NULL,
   [pharm_state_holder] [varchar](50) NOT NULL,
   [pharm_city_holder] [varchar](50) NOT NULL,
   [pharm_id_holder] [varchar](20) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_pres_id] [varchar](50) NULL,
   [field_not_used1] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL,
   [eligibility_checked] [bit] NULL,
   [eligibility_trans_id] [int] NULL,
   [off_pharm_list] [bit] NOT NULL,
   [DoPrintAfterPatHistory] [bit] NOT NULL,
   [DoPrintAfterPatOrig] [bit] NOT NULL,
   [DoPrintAfterPatCopy] [bit] NOT NULL,
   [DoPrintAfterPatMonograph] [bit] NOT NULL,
   [PatOrigPrintType] [int] NOT NULL,
   [PrintHistoryBackMonths] [int] NOT NULL,
   [DoPrintAfterScriptGuide] [bit] NOT NULL,
   [approve_source] [varchar](1) NULL,
   [pres_void_code] [smallint] NULL,
   [send_count] [smallint] NOT NULL,
   [print_options] [int] NOT NULL,
   [writing_dr_id] [int] NULL,
   [presc_src] [tinyint] NULL,
   [pres_start_date] [datetime] NULL,
   [pres_end_date] [datetime] NULL,
   [is_signed] [bit] NULL,
   [created_date] [datetime] NOT NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[referral_main] (
   [ref_id] [int] NOT NULL,
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [ref_det_xref_id] [int] NOT NULL,
   [ref_start_date] [datetime] NOT NULL,
   [ref_end_date] [datetime] NOT NULL,
   [carrier_xref_id] [int] NOT NULL,
   [pa_member_no] [varchar](50) NOT NULL,
   [ref_det_ident] [varchar](2) NOT NULL,
   [main_prv_id1] [varchar](50) NOT NULL,
   [main_prv_id2] [varchar](50) NOT NULL,
   [target_prv_id1] [varchar](50) NOT NULL,
   [target_prv_id2] [varchar](50) NOT NULL,
   [inst_id] [int] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [old_target_dr_id] [bigint] NULL
)


GO
CREATE TABLE [bk].[refill_requests] (
   [refreq_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_ncpdp] [varchar](15) NULL,
   [refreq_date] [datetime] NOT NULL,
   [trc_number] [varchar](100) NULL,
   [ctrl_number] [varchar](100) NULL,
   [recverVector] [varchar](50) NULL,
   [senderVector] [varchar](50) NULL,
   [pres_id] [int] NULL,
   [response_type] [int] NULL,
   [init_date] [datetime] NULL,
   [msg_date] [datetime] NULL,
   [response_id] [varchar](15) NULL,
   [status_code] [varchar](15) NULL,
   [status_code_qualifier] [varchar](15) NULL,
   [status_msg] [varchar](255) NULL,
   [response_conf_date] [smalldatetime] NULL,
   [error_string] [varchar](255) NULL,
   [pres_fill_time] [datetime] NULL,
   [msg_ref_number] [varchar](35) NOT NULL,
   [drug_name] [varchar](125) NULL,
   [drug_ndc] [varchar](11) NULL,
   [drug_form] [varchar](3) NULL,
   [drug_strength] [varchar](70) NULL,
   [drug_strength_units] [varchar](3) NULL,
   [qty1] [varchar](35) NULL,
   [qty1_units] [varchar](50) NULL,
   [qty1_enum] [tinyint] NULL,
   [qty2] [varchar](35) NULL,
   [qty2_units] [varchar](50) NULL,
   [qty2_enum] [tinyint] NULL,
   [dosage1] [varchar](140) NULL,
   [dosage2] [varchar](70) NULL,
   [days_supply] [int] NULL,
   [date1] [smalldatetime] NULL,
   [date1_enum] [tinyint] NULL,
   [date2] [smalldatetime] NULL,
   [date2_enum] [tinyint] NULL,
   [date3] [smalldatetime] NULL,
   [date3_enum] [tinyint] NULL,
   [substitution_code] [tinyint] NULL,
   [refills] [varchar](35) NULL,
   [refills_enum] [tinyint] NULL,
   [void_comments] [varchar](255) NULL,
   [void_code] [smallint] NULL,
   [comments1] [varchar](210) NULL,
   [comments2] [varchar](70) NULL,
   [comments3] [varchar](70) NULL,
   [disp_drug_info] [bit] NOT NULL,
   [supervisor] [varchar](100) NULL,
   [SupervisorSeg] [varchar](5000) NULL,
   [PharmSeg] [varchar](5000) NULL,
   [PatientSeg] [varchar](5000) NULL,
   [DoctorSeg] [varchar](5000) NULL,
   [DispDRUSeg] [varchar](max) NULL,
   [PrescDRUSeg] [varchar](max) NULL,
   [drug_strength_code] [varchar](15) NULL,
   [drug_strength_source_code] [varchar](3) NULL,
   [drug_form_code] [varchar](15) NULL,
   [drug_form_source_code] [varchar](3) NULL,
   [qty1_units_potency_code] [varchar](15) NULL,
   [qty2_units_potency_code] [varchar](15) NULL,
   [doc_info_text] [varchar](5000) NULL,
   [fullRequestMessage] [xml] NULL,
   [versionType] [varchar](5) NULL,
   [created_date] [datetime] NOT NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [has_miss_match] [bit] NULL,
   [miss_match_reson] [varchar](max) NULL
)


GO
CREATE TABLE [bk].[scheduled_rx_archive] (
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NOT NULL,
   [pa_gender] [varchar](1) NOT NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_first_name] [varchar](50) NOT NULL,
   [dr_middle_initial] [varchar](10) NOT NULL,
   [dr_last_name] [varchar](50) NOT NULL,
   [dr_address1] [varchar](100) NOT NULL,
   [dr_address2] [varchar](100) NOT NULL,
   [dr_city] [varchar](30) NOT NULL,
   [dr_state] [varchar](50) NOT NULL,
   [dr_zip] [varchar](20) NOT NULL,
   [dr_dea_numb] [varchar](30) NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](125) NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [qty] [varchar](20) NOT NULL,
   [units] [varchar](50) NOT NULL,
   [days_supply] [int] NOT NULL,
   [refills] [int] NOT NULL,
   [approved_date] [smalldatetime] NOT NULL,
   [signature] [varchar](max) NOT NULL,
   [scheduled_rx_id] [bigint] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[scheduler_main] (
   [event_id] [int] NOT NULL,
   [event_start_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [type] [smallint] NOT NULL,
   [ext_link_id] [int] NOT NULL,
   [note] [varchar](100) NOT NULL,
   [detail_header] [varchar](200) NOT NULL,
   [event_end_date] [datetime] NOT NULL,
   [is_new_pat] [bit] NOT NULL,
   [recurrence] [varchar](1024) NULL,
   [recurrence_parent] [int] NULL,
   [status] [tinyint] NOT NULL,
   [dtCheckIn] [datetime] NULL,
   [dtCalled] [datetime] NULL,
   [dtCheckedOut] [datetime] NULL,
   [dtintake] [smalldatetime] NULL,
   [case_id] [int] NULL,
   [room_id] [int] NULL,
   [reason] [varchar](125) NULL,
   [is_confirmed] [bit] NULL,
   [discharge_disposition_code] [varchar](2) NULL,
   [is_delete_attempt] [bit] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
CREATE TABLE [bk].[tblVaccinationRecord] (
   [vac_rec_id] [bigint] NOT NULL,
   [vac_id] [int] NOT NULL,
   [vac_pat_id] [int] NOT NULL,
   [vac_dt_admin] [datetime] NOT NULL,
   [vac_lot_no] [nvarchar](50) NOT NULL,
   [vac_site] [nvarchar](100) NOT NULL,
   [vac_dose] [nvarchar](225) NOT NULL,
   [vac_exp_date] [datetime] NOT NULL,
   [vac_dr_id] [int] NOT NULL,
   [vac_reaction] [nvarchar](512) NULL,
   [vac_remarks] [nvarchar](512) NULL,
   [vac_name] [varchar](150) NULL,
   [vis_date] [smalldatetime] NULL,
   [vis_given_date] [smalldatetime] NULL,
   [record_modified_date] [datetime] NULL,
   [vac_site_code] [varchar](10) NULL,
   [vac_dose_unit_code] [varchar](20) NULL,
   [vac_administered_code] [varchar](2) NULL,
   [vac_administered_by] [bigint] NULL,
   [vac_entered_by] [bigint] NULL,
   [substance_refusal_reason_code] [varchar](2) NULL,
   [disease_code] [varchar](10) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [VFC_Eligibility_Status] [varchar](10) NULL,
   [vfc_code] [varchar](10) NULL
)


GO
CREATE TABLE [dbo].[bmi_gchart] (
   [Sex] [float] NULL,
   [Agemos] [float] NULL,
   [L] [float] NULL,
   [M] [float] NULL,
   [S] [float] NULL,
   [P3] [float] NULL,
   [P5] [float] NULL,
   [P10] [float] NULL,
   [P25] [float] NULL,
   [P50] [float] NULL,
   [P75] [float] NULL,
   [P85] [float] NULL,
   [P90] [float] NULL,
   [P95] [float] NULL,
   [P97] [float] NULL,
   [bmi_id] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_bmi_gchart] PRIMARY KEY CLUSTERED ([bmi_id])
)


GO
CREATE TABLE [dbo].[Calendar] (
   [dt] [smalldatetime] NOT NULL,
   [UTCOffset] [tinyint] NULL

   ,CONSTRAINT [PK__Calendar__07D7CE77] PRIMARY KEY CLUSTERED ([dt])
)


GO
CREATE TABLE [dbo].[CMS117v10_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[CMS136v11_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[CMS138v10_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[CMS147v11_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[CMS153v10_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[CMS155v10_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[CMS69v10_TempToDelete] (
   [Id] [bigint] NOT NULL,
   [ValueSetName] [varchar](max) NULL,
   [CodeSystem] [varchar](max) NULL,
   [OID] [varchar](max) NULL,
   [DefinitionVersion] [varchar](max) NULL,
   [Code] [varchar](max) NULL,
   [Description] [varchar](max) NULL,
   [CodeSystem1] [varchar](max) NULL,
   [CodeSystemVersion] [varchar](max) NULL,
   [CodeSystemOID] [varchar](max) NULL,
   [TTY] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[company_forms] (
   [form_id] [int] NOT NULL
      IDENTITY (1,1),
   [form_file] [varchar](255) NOT NULL,
   [pres_id] [int] NOT NULL,
   [saved_date] [datetime] NULL,
   [send_date] [datetime] NULL,
   [response_type] [bit] NULL,
   [response_date] [datetime] NULL

   ,CONSTRAINT [PK__company_forms__51BBB4E8] PRIMARY KEY CLUSTERED ([form_id])
)


GO
CREATE TABLE [dbo].[company_menu] (
   [company_menu_id] [int] NOT NULL
      IDENTITY (1,1),
   [master_patient_menu_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [is_show] [bit] NULL,
   [sort_order] [int] NOT NULL,
   [active] [bit] NOT NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL

   ,CONSTRAINT [PK_company_menu] PRIMARY KEY CLUSTERED ([company_menu_id])
)


GO
CREATE TABLE [dbo].[coupon_redemptions] (
   [pa_id] [int] NOT NULL,
   [coupon_id] [int] NOT NULL,
   [medid] [int] NOT NULL,
   [coupon_code] [varchar](125) NOT NULL,
   [print_date] [smalldatetime] NOT NULL,
   [user_id] [int] NOT NULL,
   [coupon_redemption_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_coupon_redemptions] PRIMARY KEY CLUSTERED ([coupon_redemption_id])
)

CREATE NONCLUSTERED INDEX [IX_coupon_redemptions] ON [dbo].[coupon_redemptions] ([pa_id], [coupon_id], [medid])

GO
CREATE TABLE [dbo].[coverage_info] (
   [ci_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [cov_list_id] [varchar](50) NOT NULL,
   [cov_list_type] [varchar](2) NOT NULL,
   [ndc] [varchar](11) NOT NULL,
   [description] [varchar](50) NULL

   ,CONSTRAINT [PK_coverage_info] PRIMARY KEY CLUSTERED ([ci_id])
)


GO
CREATE TABLE [dbo].[coverage_reference] (
   [cr_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [plan_numb] [varchar](15) NULL,
   [plan_name] [varchar](35) NOT NULL,
   [grp_numb] [varchar](15) NULL,
   [grp_name] [varchar](35) NULL,
   [cov_list_id] [varchar](50) NOT NULL,
   [cov_list_type] [varchar](2) NOT NULL

   ,CONSTRAINT [PK_coverage_reference] PRIMARY KEY CLUSTERED ([cr_id])
)


GO
CREATE TABLE [dbo].[cpt_codes] (
   [Code] [nvarchar](50) NOT NULL,
   [Description] [nvarchar](255) NOT NULL,
   [long_desc] [varchar](max) NULL,
   [created_at] [datetime] NULL,
   [updated_at] [datetime] NULL,
   [DataSource] [varchar](100) NULL,
   [ProcedureCodeTypeId] [bigint] NULL

   ,CONSTRAINT [PK_cpt_codes] PRIMARY KEY CLUSTERED ([Code])
)


GO
CREATE TABLE [dbo].[cpt_codes_backup] (
   [Code] [nvarchar](50) NOT NULL,
   [Description] [nvarchar](255) NOT NULL,
   [long_desc] [varchar](max) NULL,
   [created_at] [datetime] NULL,
   [updated_at] [datetime] NULL
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS117v6_NQF0038] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS117v6_NQF0038] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS136v7_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS136v7_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS138v6_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS138v6_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS147v7_NQF0041] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS153v6_NQF0033] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS153v6_NQF0033] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS155v6_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS155v6_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS68v7_NQF0419] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL,
   [DatePerformed] [date] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS68v7_NQF0419] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop1CMS69v6_NQF0421] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS69v6_NQF0421] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop2CMS136v7_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS136v6_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop2CMS138v6_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS138v6_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop2CMS155v6_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS155v6_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS138v6_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalcPop3CMS155v6_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS155v6_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2018].[DoctorCQMCalculationRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL
)


GO
CREATE TABLE [cqm2018].[PatientAttributeCodes] (
   [AttributeCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [AttributeId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientAttributeCodes] PRIMARY KEY CLUSTERED ([AttributeCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientCommunicationCodes] (
   [CommunicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [CommunicationId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientCommunicationCodes] PRIMARY KEY CLUSTERED ([CommunicationCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientDiagnosisCodes] (
   [DiagnosisCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DiagnosisId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosisCodes] PRIMARY KEY CLUSTERED ([DiagnosisCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientDiagnosticStudyCodes] (
   [DiagnosticStudyCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [DiagnosticStudyId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosticStudyCodes] PRIMARY KEY CLUSTERED ([DiagnosticStudyCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientEncounterCodes] (
   [EncounterCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientEncounterCodes] PRIMARY KEY CLUSTERED ([EncounterCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientImmunizationCodes] (
   [ImmunizationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [ImmunizationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientImmunizationCodes] PRIMARY KEY CLUSTERED ([ImmunizationCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientInterventionCodes] (
   [InterventionCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [InterventionId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientInterventionCodes] PRIMARY KEY CLUSTERED ([InterventionCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientLaboratoryTestCodes] (
   [LaboratoryTestCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [LaboratoryTestId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientLaboratoryTestCodes] PRIMARY KEY CLUSTERED ([LaboratoryTestCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientMedicationCodes] (
   [MedicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [MedicationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationCodes] PRIMARY KEY CLUSTERED ([MedicationCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientMedicationProcedureCodes] (
   [MedicationProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [MedicationProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationProcedureCodes] PRIMARY KEY CLUSTERED ([MedicationProcedureCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientPhysicalExamCodes] (
   [PhysicalExamCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [PhysicalExamId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientPhysicalExamCodes] PRIMARY KEY CLUSTERED ([PhysicalExamCodeId])
)

CREATE NONCLUSTERED INDEX [ix_PatientPhysicalExamCodes_PerformedFromDate_includes] ON [cqm2018].[PatientPhysicalExamCodes] ([PatientId], [PerformedFromDate]) INCLUDE ([Code])

GO
CREATE TABLE [cqm2018].[PatientProcedureCodes] (
   [ProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [ProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
CREATE TABLE [cqm2018].[PatientRiskCategoryOrAssessmentCodes] (
   [RiskCategoryOrAssessmentCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [RiskCategoryOrAssessmentId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientRiskCategoryOrAssessmentCodes] PRIMARY KEY CLUSTERED ([RiskCategoryOrAssessmentCodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS117v6_NQF0038] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C150397321B] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS136v7_NQF0108] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C157FC6A137] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS138v6_NQF0028] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C157BF61053] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS147v7_NQF0041] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C1578257F6F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS153v6_NQF0033] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C1570845DA7] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS155v6_NQF0024] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C156CB3CCC3] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS68v7_NQF0419] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C1568E33BDF] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCMS69v6_NQF0421] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C157454EE8B] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A86512AAFB] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCqmMeasurePopulationInfo] (
   [PopulationInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationIndex] [bigint] NOT NULL,
   [HasDenomException] [bit] NOT NULL,
   [HasDenomExclusion] [bit] NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasurePopCriteria] PRIMARY KEY CLUSTERED ([PopulationInfoId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCqmMeasuresInfo] (
   [MeasureInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureTitle] [varchar](max) NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [MeasureNumber] [varchar](max) NOT NULL,
   [NQFNumber] [varchar](max) NOT NULL

   ,CONSTRAINT [PK_CqmMeasures] PRIMARY KEY CLUSTERED ([MeasureInfoId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCqmMeasureStratumInfo] (
   [StratumInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationInfoId] [bigint] NOT NULL,
   [StratumIndex] [int] NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasureStratums] PRIMARY KEY CLUSTERED ([StratumInfoId])
)


GO
CREATE TABLE [cqm2018].[SysLookupCQMValueSet] (
   [ValueSetId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetName] [varchar](200) NULL,
   [ValueSetOID] [varchar](200) NULL,
   [QDMCategoryId] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__222987C15B8940C1] PRIMARY KEY CLUSTERED ([ValueSetId])
)


GO
CREATE TABLE [cqm2018].[SysLookupQDMCategory] (
   [QDMCategoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [QDMCategory] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__3C2D04FC57B8AFDD] PRIMARY KEY CLUSTERED ([QDMCategoryId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS117v7_NQF0038] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS117v7_NQF0038] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS136v8_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS136v8_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS138v7_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS138v7_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS147v8_NQF0041] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS147v8_NQF0041] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS153v7_NQF0033] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS155v7_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS155v7_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS68v8_NQF0419] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL,
   [DatePerformed] [date] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS68v8_NQF0419] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop1CMS69v7_NQF0421] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS69v7_NQF0421] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop2CMS136v8_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS136v8_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS138v7_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop2CMS155v7_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS155v7_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop3CMS138v7_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS138v7_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalcPop3CMS155v7_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS155v7_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2019].[DoctorCQMCalculationRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL

   ,CONSTRAINT [PK_DoctorCQMCalculationRequest] PRIMARY KEY CLUSTERED ([RequestId])
)


GO
CREATE TABLE [cqm2019].[PatientAttributeCodes] (
   [AttributeCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [AttributeId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientAttributeCodes] PRIMARY KEY CLUSTERED ([AttributeCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientCommunicationCodes] (
   [CommunicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [CommunicationId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientCommunicationCodes] PRIMARY KEY CLUSTERED ([CommunicationCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientDiagnosisCodes] (
   [DiagnosisCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DiagnosisId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosisCodes] PRIMARY KEY CLUSTERED ([DiagnosisCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientDiagnosticStudyCodes] (
   [DiagnosticStudyCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [DiagnosticStudyId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosticStudyCodes] PRIMARY KEY CLUSTERED ([DiagnosticStudyCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientEncounterCodes] (
   [EncounterCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientEncounterCodes] PRIMARY KEY CLUSTERED ([EncounterCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientImmunizationCodes] (
   [ImmunizationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ImmunizationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientImmunizationCodes] PRIMARY KEY CLUSTERED ([ImmunizationCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientInterventionCodes] (
   [InterventionCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [InterventionId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientInterventionCodes] PRIMARY KEY CLUSTERED ([InterventionCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientLaboratoryTestCodes] (
   [LaboratoryTestCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [LaboratoryTestId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientLaboratoryTestCodes] PRIMARY KEY CLUSTERED ([LaboratoryTestCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientMedicationCodes] (
   [MedicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationCodes] PRIMARY KEY CLUSTERED ([MedicationCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientMedicationProcedureCodes] (
   [MedicationProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationProcedureCodes] PRIMARY KEY CLUSTERED ([MedicationProcedureCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientPhysicalExamCodes] (
   [PhysicalExamCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [PhysicalExamId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientPhysicalExamCodes] PRIMARY KEY CLUSTERED ([PhysicalExamCodeId])
)

CREATE NONCLUSTERED INDEX [ix_PatientPhysicalExamCodes_PatId_PerformedFrmDt_incl] ON [cqm2019].[PatientPhysicalExamCodes] ([PatientId], [PerformedFromDate]) INCLUDE ([Code])

GO
CREATE TABLE [cqm2019].[PatientProcedureCodes] (
   [ProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
CREATE TABLE [cqm2019].[PatientRiskCategoryOrAssessmentCodes] (
   [RiskCategoryOrAssessmentCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [RiskCategoryOrAssessmentId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientRiskCategoryOrAssessmentCodes] PRIMARY KEY CLUSTERED ([RiskCategoryOrAssessmentCodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS117v7_NQF0038] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C150FDA43A7] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS136v8_NQF0108] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C1513AAD48B] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS138v7_NQF0028] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C153F8956C9] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS147v8_NQF0041] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C154542301F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS153v7_NQF0033] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C154AFB0975] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS155v7_NQF0024] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C15548473AF] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS68v8_NQF0419] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C15177B656F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCMS69v7_NQF0421] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C151B4BF653] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A81F1C8737] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCqmMeasurePopulationInfo] (
   [PopulationInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationIndex] [bigint] NOT NULL,
   [HasDenomException] [bit] NOT NULL,
   [HasDenomExclusion] [bit] NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasurePopCriteria] PRIMARY KEY CLUSTERED ([PopulationInfoId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCqmMeasuresInfo] (
   [MeasureInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureTitle] [varchar](max) NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [MeasureNumber] [varchar](max) NOT NULL,
   [NQFNumber] [varchar](max) NOT NULL

   ,CONSTRAINT [PK_CqmMeasures] PRIMARY KEY CLUSTERED ([MeasureInfoId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCqmMeasureStratumInfo] (
   [StratumInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationInfoId] [bigint] NOT NULL,
   [StratumIndex] [int] NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasureStratums] PRIMARY KEY CLUSTERED ([StratumInfoId])
)


GO
CREATE TABLE [cqm2019].[SysLookupCQMValueSet] (
   [ValueSetId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetName] [varchar](200) NULL,
   [ValueSetOID] [varchar](200) NULL,
   [QDMCategoryId] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__222987C128A5F171] PRIMARY KEY CLUSTERED ([ValueSetId])
)


GO
CREATE TABLE [cqm2019].[SysLookupQDMCategory] (
   [QDMCategoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [QDMCategory] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__3C2D04FC2C768255] PRIMARY KEY CLUSTERED ([QDMCategoryId])
)


GO
CREATE TABLE [cqm2021].[SysLookupCqmMeasurePopulationInfo] (
   [PopulationInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationIndex] [bigint] NOT NULL,
   [HasDenomException] [bit] NOT NULL,
   [HasDenomExclusion] [bit] NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasurePopCriteria] PRIMARY KEY CLUSTERED ([PopulationInfoId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS117v10_NQF0038] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS117v10_NQF0038] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS136v11_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS136v11_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS138v10_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS147v11_NQF0041] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS147v11_NQF0041] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS153v10_NQF0033] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS153v10_NQF0033] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS155v10_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS155v10_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS68v11_NQF0419] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL,
   [DatePerformed] [date] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS68v11_NQF0419] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop1CMS69v10_NQF0421] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS69v10_NQF0421] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop2CMS136v11_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS136v11_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop2CMS138v10_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS138v10_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop2CMS155v10_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS155v10_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS138v10_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalcPop3CMS155v10_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS155v10_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2022].[DoctorCQMCalculationRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL

   ,CONSTRAINT [PK_DoctorCQMCalculationRequest] PRIMARY KEY CLUSTERED ([RequestId])
)


GO
CREATE TABLE [cqm2022].[PatientAttributeCodes] (
   [AttributeCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [AttributeId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientAttributeCodes] PRIMARY KEY CLUSTERED ([AttributeCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientCommunicationCodes] (
   [CommunicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [CommunicationId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientCommunicationCodes] PRIMARY KEY CLUSTERED ([CommunicationCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientDiagnosisCodes] (
   [DiagnosisCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DiagnosisId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosisCodes] PRIMARY KEY CLUSTERED ([DiagnosisCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientDiagnosticStudyCodes] (
   [DiagnosticStudyCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [DiagnosticStudyId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosticStudyCodes] PRIMARY KEY CLUSTERED ([DiagnosticStudyCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientEncounterCodes] (
   [EncounterCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientEncounterCodes] PRIMARY KEY CLUSTERED ([EncounterCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientImmunizationCodes] (
   [ImmunizationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ImmunizationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientImmunizationCodes] PRIMARY KEY CLUSTERED ([ImmunizationCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientInterventionCodes] (
   [InterventionCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [InterventionId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [Status] [varchar](50) NULL,
   [ReasonTypeCode] [varchar](15) NULL

   ,CONSTRAINT [PK_PatientInterventionCodes] PRIMARY KEY CLUSTERED ([InterventionCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientLaboratoryTestCodes] (
   [LaboratoryTestCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [LaboratoryTestId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientLaboratoryTestCodes] PRIMARY KEY CLUSTERED ([LaboratoryTestCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientMedicationCodes] (
   [MedicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationCodes] PRIMARY KEY CLUSTERED ([MedicationCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientMedicationProcedureCodes] (
   [MedicationProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationProcedureCodes] PRIMARY KEY CLUSTERED ([MedicationProcedureCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientPhysicalExamCodes] (
   [PhysicalExamCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [PhysicalExamId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientPhysicalExamCodes] PRIMARY KEY CLUSTERED ([PhysicalExamCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientProcedureCodes] (
   [ProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [Status] [varchar](50) NULL,
   [ReasonTypeCode] [varchar](15) NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
CREATE TABLE [cqm2022].[PatientRiskCategoryOrAssessmentCodes] (
   [RiskCategoryOrAssessmentCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [RiskCategoryOrAssessmentId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientRiskCategoryOrAssessmentCodes] PRIMARY KEY CLUSTERED ([RiskCategoryOrAssessmentCodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS117v10_NQF0038] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C150FDA43A7] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS136v11_NQF0108] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C1513AAD48B] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS138v10_NQF0028] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C153F8956C9] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS147v11_NQF0041] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C154542301F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS153v10_NQF0033] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C154AFB0975] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS155v10_NQF0024] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C15548473AF] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS68v11_NQF0419] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLookupCMS68v11_NQF0419__C6DE2C15177B656F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCMS69v10_NQF0421] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C151B4BF653] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL,
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A81F1C8737] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCqmMeasurePopulationInfo] (
   [PopulationInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationIndex] [bigint] NOT NULL,
   [HasDenomException] [bit] NOT NULL,
   [HasDenomExclusion] [bit] NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasurePopCriteria] PRIMARY KEY CLUSTERED ([PopulationInfoId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCqmMeasuresInfo] (
   [MeasureInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureTitle] [varchar](max) NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [MeasureNumber] [varchar](max) NOT NULL,
   [NQFNumber] [varchar](max) NOT NULL,
   [SetId] [varchar](50) NULL

   ,CONSTRAINT [PK_CqmMeasures] PRIMARY KEY CLUSTERED ([MeasureInfoId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCqmMeasureStratumInfo] (
   [StratumInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationInfoId] [bigint] NOT NULL,
   [StratumIndex] [int] NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasureStratums] PRIMARY KEY CLUSTERED ([StratumInfoId])
)


GO
CREATE TABLE [cqm2022].[SysLookupCQMValueSet] (
   [ValueSetId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetName] [varchar](200) NULL,
   [ValueSetOID] [varchar](200) NULL,
   [QDMCategoryId] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__222987C128A5F171] PRIMARY KEY CLUSTERED ([ValueSetId])
)


GO
CREATE TABLE [cqm2022].[SysLookupQDMCategory] (
   [QDMCategoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [QDMCategory] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__3C2D04FC2C768255] PRIMARY KEY CLUSTERED ([QDMCategoryId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS117v11_NQF0038] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS117v11_NQF0038] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS136v12_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS136v12_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS138v11_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS138v11_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS147v12_NQF0041] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS147v12_NQF0041] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS153v11_NQF0033] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS153v11_NQF0033] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS155v11_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS155v11_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS68v12_NQF0419] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL,
   [DatePerformed] [date] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS68v12_NQF0419] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop1CMS69v11_NQF0421] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop1CMS69v11_NQF0421] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop2CMS136v12_NQF0108] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS136v12_NQF0108] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop2CMS138v11_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS138v11_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop2CMS155v11_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop2CMS155v11_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop3CMS138v11_NQF0028] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS138v11_NQF0028] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalcPop3CMS155v11_NQF0024] (
   [CalcId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NOT NULL,
   [RequestId] [bigint] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IPP] [bit] NULL,
   [Denominator] [bit] NULL,
   [DenomExclusions] [bit] NULL,
   [Numerator] [bit] NULL,
   [NumerExclusions] [bit] NULL,
   [DenomExceptions] [bit] NULL

   ,CONSTRAINT [PK_DoctorCQMCalcPop3CMS155v11_NQF0024] PRIMARY KEY CLUSTERED ([CalcId])
)


GO
CREATE TABLE [cqm2023].[DoctorCQMCalculationRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [int] NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL

   ,CONSTRAINT [PK_DoctorCQMCalculationRequest] PRIMARY KEY CLUSTERED ([RequestId])
)


GO
CREATE TABLE [cqm2023].[PatientAttributeCodes] (
   [AttributeCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [AttributeId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientAttributeCodes] PRIMARY KEY CLUSTERED ([AttributeCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientCommunicationCodes] (
   [CommunicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [CommunicationId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientCommunicationCodes] PRIMARY KEY CLUSTERED ([CommunicationCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientDiagnosisCodes] (
   [DiagnosisCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DiagnosisId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosisCodes] PRIMARY KEY CLUSTERED ([DiagnosisCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientDiagnosticStudyCodes] (
   [DiagnosticStudyCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [DiagnosticStudyId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosticStudyCodes] PRIMARY KEY CLUSTERED ([DiagnosticStudyCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientEncounterCodes] (
   [EncounterCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientEncounterCodes] PRIMARY KEY CLUSTERED ([EncounterCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientImmunizationCodes] (
   [ImmunizationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ImmunizationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientImmunizationCodes] PRIMARY KEY CLUSTERED ([ImmunizationCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientInterventionCodes] (
   [InterventionCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [InterventionId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [Status] [varchar](50) NULL,
   [ReasonTypeCode] [varchar](15) NULL

   ,CONSTRAINT [PK_PatientInterventionCodes] PRIMARY KEY CLUSTERED ([InterventionCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientLaboratoryTestCodes] (
   [LaboratoryTestCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [LaboratoryTestId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientLaboratoryTestCodes] PRIMARY KEY CLUSTERED ([LaboratoryTestCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientMedicationCodes] (
   [MedicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationCodes] PRIMARY KEY CLUSTERED ([MedicationCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientMedicationProcedureCodes] (
   [MedicationProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationProcedureCodes] PRIMARY KEY CLUSTERED ([MedicationProcedureCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientPhysicalExamCodes] (
   [PhysicalExamCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [PhysicalExamId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientPhysicalExamCodes] PRIMARY KEY CLUSTERED ([PhysicalExamCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientProcedureCodes] (
   [ProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [Status] [varchar](50) NULL,
   [ReasonTypeCode] [varchar](15) NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
CREATE TABLE [cqm2023].[PatientRiskCategoryOrAssessmentCodes] (
   [RiskCategoryOrAssessmentCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [RiskCategoryOrAssessmentId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientRiskCategoryOrAssessmentCodes] PRIMARY KEY CLUSTERED ([RiskCategoryOrAssessmentCodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS117v11_NQF0038] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS117v11_NQF0038] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS136v12_NQF0108] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS136v12_NQF0108] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS138v11_NQF0028] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS138v11_NQF0028] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS147v12_NQF0041] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS147v12_NQF0041] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS153v11_NQF0033] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS153v11_NQF0033] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS155v11_NQF0024] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS155v11_NQF0024] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS68v12_NQF0419] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS68v12_NQF0419] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCMS69v11_NQF0421] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS69v11_NQF0421] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL,
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLooku__BE9EB9A81F1C8737] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCqmMeasurePopulationInfo] (
   [PopulationInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationIndex] [bigint] NOT NULL,
   [HasDenomException] [bit] NOT NULL,
   [HasDenomExclusion] [bit] NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasurePopCriteria] PRIMARY KEY CLUSTERED ([PopulationInfoId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCqmMeasuresInfo] (
   [MeasureInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureTitle] [varchar](max) NOT NULL,
   [ReferenceID] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [MeasureNumber] [varchar](max) NOT NULL,
   [NQFNumber] [varchar](max) NOT NULL,
   [SetId] [varchar](50) NULL

   ,CONSTRAINT [PK_CqmMeasures] PRIMARY KEY CLUSTERED ([MeasureInfoId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCqmMeasureStratumInfo] (
   [StratumInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureInfoId] [bigint] NOT NULL,
   [PopulationInfoId] [bigint] NOT NULL,
   [StratumIndex] [int] NOT NULL,
   [IPP_ReferenceID] [varchar](max) NULL,
   [IPP_Description] [varchar](max) NULL,
   [DEN_ReferenceID] [varchar](max) NULL,
   [DEN_Description] [varchar](max) NULL,
   [NUM_ReferenceID] [varchar](max) NULL,
   [NUM_Description] [varchar](max) NULL,
   [DEN_EXCL_ReferenceID] [varchar](max) NULL,
   [DEN_EXCL_Description] [varchar](max) NULL,
   [DEN_EXCP_ReferenceID] [varchar](max) NULL,
   [DEN_EXCP_Description] [varchar](max) NULL

   ,CONSTRAINT [PK_CqmMeasureStratums] PRIMARY KEY CLUSTERED ([StratumInfoId])
)


GO
CREATE TABLE [cqm2023].[SysLookupCQMValueSet] (
   [ValueSetId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetName] [varchar](200) NULL,
   [ValueSetOID] [varchar](200) NULL,
   [QDMCategoryId] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLooku__222987C128A5F171] PRIMARY KEY CLUSTERED ([ValueSetId])
)


GO
CREATE TABLE [cqm2023].[SysLookupQDMCategory] (
   [QDMCategoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [QDMCategory] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLooku__3C2D04FC2C768255] PRIMARY KEY CLUSTERED ([QDMCategoryId])
)


GO
CREATE TABLE [dbo].[CQMQDM_Temp] (
   [Descript] [varchar](5000) NULL,
   [QDM] [varchar](500) NULL,
   [ValueSet] [varchar](500) NULL
)


GO
CREATE TABLE [dbo].[CQM_Codes] (
   [CQM_Code_Id] [int] NOT NULL,
   [code] [varchar](100) NOT NULL,
   [code_type] [varchar](20) NOT NULL,
   [NQF_id] [varchar](10) NOT NULL,
   [IsActive] [bit] NOT NULL,
   [IsExclude] [bit] NOT NULL,
   [criteria] [smallint] NOT NULL,
   [criteriatype] [varchar](10) NOT NULL,
   [version] [int] NOT NULL,
   [value_set_oid] [varchar](50) NULL,
   [code_system_oid] [varchar](50) NULL

   ,CONSTRAINT [PK_CQM_Codes] PRIMARY KEY CLUSTERED ([CQM_Code_Id])
)


GO
CREATE TABLE [dbo].[CQM_Codes_V4] (
   [CQM_Code_Id] [int] NOT NULL,
   [code] [varchar](100) NOT NULL,
   [code_type] [varchar](10) NOT NULL,
   [NQF_id] [varchar](10) NOT NULL,
   [IsActive] [bit] NOT NULL,
   [IsExclude] [bit] NOT NULL,
   [criteria] [smallint] NOT NULL,
   [criteriatype] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_CQM_Codes_V4] PRIMARY KEY CLUSTERED ([CQM_Code_Id])
)


GO
CREATE TABLE [dbo].[CQM_Measure_Reports] (
   [cqm_repid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NULL,
   [start_date] [datetime] NULL,
   [end_date] [datetime] NULL,
   [cqm_text] [varchar](max) NULL,
   [executed_date] [datetime] NULL,
   [report_version] [varchar](5) NULL

   ,CONSTRAINT [PK__CQM_Meas__3F72938A2BC1BFE0] PRIMARY KEY CLUSTERED ([cqm_repid])
)


GO
CREATE TABLE [dbo].[CustomerEmailMessageText] (
   [CEMMTID] [int] NOT NULL
      IDENTITY (1,1),
   [CEMMTYPEID] [int] NOT NULL,
   [PricerRegionID] [int] NOT NULL,
   [strSubject] [varchar](400) NOT NULL,
   [strBody] [text] NOT NULL

   ,CONSTRAINT [PK_CustomerEmailMessageText] PRIMARY KEY CLUSTERED ([CEMMTID])
)


GO
CREATE TABLE [dbo].[CustomerEmailMessageTypes] (
   [CEMMTYPEID] [int] NOT NULL,
   [strMTDescription] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_CustomerEmailMessageTypes] PRIMARY KEY CLUSTERED ([CEMMTYPEID])
)


GO
CREATE TABLE [dbo].[CustomerEmailQueue] (
   [CEMID] [int] NOT NULL
      IDENTITY (1,1),
   [CustID] [int] NOT NULL,
   [EmpID] [int] NOT NULL,
   [OrderID] [int] NOT NULL,
   [CEMMTYPEID] [int] NOT NULL,
   [dtQueueDate] [datetime] NOT NULL,
   [dtSendDate] [datetime] NULL,
   [bSendAttempted] [bit] NOT NULL,
   [bSMTPSVGFailed] [bit] NOT NULL,
   [strSMTPSVGErrorMsg] [varchar](1000) NOT NULL,
   [strMDFailedAddress] [varchar](255) NOT NULL,
   [strSubject] [varchar](400) NOT NULL,
   [strMDSessionTranscript] [text] NOT NULL,
   [strBody] [text] NOT NULL,
   [lngMasterOrderID] [int] NOT NULL

   ,CONSTRAINT [PK_CustomerEmailQueue] PRIMARY KEY CLUSTERED ([CEMID])
)


GO
CREATE TABLE [dbo].[CustomerNotes] (
   [CustNoteID] [int] NOT NULL
      IDENTITY (1,1),
   [CustID] [int] NOT NULL,
   [CustNoteDate] [datetime] NOT NULL,
   [lEmpID] [int] NOT NULL,
   [bVoid] [bit] NOT NULL,
   [CustNote] [text] NOT NULL

   ,CONSTRAINT [PK_CustomerNotes] PRIMARY KEY NONCLUSTERED ([CustNoteID])
)


GO
CREATE TABLE [dbo].[Customers] (
   [CustID] [int] NOT NULL
      IDENTITY (1,1),
   [CustSalesPersonID] [int] NULL,
   [CustFirstName] [varchar](100) NULL,
   [CustLastName] [varchar](100) NULL,
   [CustEmail] [varchar](100) NULL,
   [CustAddress1] [varchar](100) NULL,
   [CustAddress2] [varchar](100) NULL,
   [CustCity] [varchar](100) NULL,
   [CustState] [varchar](50) NULL,
   [CustZip] [varchar](40) NULL,
   [CustOfficePhone] [varchar](40) NULL,
   [CustHomePhone] [varchar](40) NULL,
   [CustFax] [varchar](40) NULL,
   [CustMobile] [varchar](40) NULL,
   [CustComments] [varchar](255) NULL,
   [CustRigID] [int] NULL,
   [CustBoatName] [varchar](50) NULL,
   [PeachTreeID] [varchar](50) NULL,
   [bIs205DiscountCust] [bit] NULL,
   [LastEdited] [datetime] NULL,
   [CustCountry] [varchar](100) NULL,
   [lngCountryID] [int] NOT NULL,
   [CustPassword] [varchar](20) NULL,
   [CustShippingAddress1] [varchar](255) NULL,
   [CustShippingAddress2] [varchar](255) NULL,
   [CustShippingCity] [varchar](100) NULL,
   [CustShippingStateOrProvince] [varchar](50) NULL,
   [CustShippingPostalCode] [varchar](50) NULL,
   [CustShippingCountryID] [int] NOT NULL,
   [CustShippingPhoneNumber] [varchar](50) NULL,
   [CustBillingFirstName] [varchar](100) NULL,
   [CustBillingLastName] [varchar](100) NULL

   ,CONSTRAINT [IX_Customers] UNIQUE NONCLUSTERED ([CustFirstName], [CustLastName], [CustEmail])
   ,CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED ([CustID])
)


GO
CREATE TABLE [dbo].[custom_drugs] (
   [CUST_ID] [int] NOT NULL
      IDENTITY (1,1),
   [DG_ID] [int] NOT NULL,
   [CUST_NAME] [varchar](80) NOT NULL,
   [CUST_OPT_XREF] [int] NOT NULL,
   [dc_id] [int] NOT NULL

   ,CONSTRAINT [IX_custom_drugs] UNIQUE CLUSTERED ([CUST_ID], [CUST_OPT_XREF], [DG_ID])
   ,CONSTRAINT [PK_custom_drugs] PRIMARY KEY NONCLUSTERED ([CUST_ID])
)

CREATE NONCLUSTERED INDEX [IX_ALT] ON [dbo].[custom_drugs] ([DG_ID], [dc_id])

GO
CREATE TABLE [dbo].[custom_drug_options] (
   [cust_drug_option_id] [int] NOT NULL
      IDENTITY (1,1),
   [CUST_OPTION_ID] [int] NOT NULL,
   [MEDID] [int] NOT NULL,
   [add_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_custom_drug_options] PRIMARY KEY CLUSTERED ([cust_drug_option_id])
)

CREATE NONCLUSTERED INDEX [IX_custom_drug_options_1] ON [dbo].[custom_drug_options] ([CUST_OPTION_ID], [MEDID])

GO
CREATE TABLE [dbo].[cust_drug_dosages] (
   [cust_drug_sig_id] [int] NOT NULL
      IDENTITY (1,1),
   [cust_id] [int] NOT NULL,
   [drugid] [int] NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [duration_unit] [varchar](80) NOT NULL,
   [duration_amount] [varchar](50) NOT NULL,
   [start_date] [datetime] NULL,
   [end_date] [datetime] NULL,
   [pharmacist_notes] [varchar](140) NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL

   ,CONSTRAINT [PK_cust_drug_dosages] PRIMARY KEY CLUSTERED ([cust_drug_sig_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[cust_drug_dosages] ([cust_id], [drugid])

GO
CREATE TABLE [dbo].[cust_drug_taper_info] (
   [cdti_id] [int] NOT NULL
      IDENTITY (1,1),
   [cust_id] [int] NOT NULL,
   [drugid] [int] NOT NULL,
   [Dose] [varchar](50) NULL,
   [Sig] [varchar](210) NULL,
   [Days] [int] NULL,
   [Hrs] [int] NULL,
   [CreatedBy] [varchar](200) NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [varchar](200) NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cust_drug_taper_info] PRIMARY KEY CLUSTERED ([cdti_id])
)


GO
CREATE TABLE [dbo].[DataExportHistory] (
   [DataExportHistoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DataExportSettingId] [bigint] NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [StatusId] [bigint] NOT NULL,
   [StatusMessage] [varchar](2000) NULL,
   [BatchName] [varchar](500) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL
)


GO
CREATE TABLE [dbo].[DataExportSettings] (
   [DataExportSettingId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [int] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [ExportType] [bigint] NOT NULL,
   [CycleName] [varchar](100) NULL,
   [CycleFrequencyTypeId] [bigint] NULL,
   [StartDate] [datetime2] NULL,
   [EndDate] [datetime2] NULL,
   [RunDayTypeId] [bigint] NULL,
   [RunAt] [datetime2] NULL,
   [RunAtTimeId] [bigint] NULL,
   [Location] [varchar](250) NULL,
   [LastRunDate] [datetime2] NULL,
   [RecurringCriteria] [bigint] NULL,
   [LastRunStatusId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DataExportSettings] PRIMARY KEY CLUSTERED ([DataExportSettingId])
)


GO
CREATE TABLE [dbo].[db_Error_Log] (
   [err_id] [int] NOT NULL
      IDENTITY (1,1),
   [error_code] [int] NOT NULL,
   [error_desc] [varchar](1024) NULL,
   [error_time] [smalldatetime] NOT NULL,
   [application] [varchar](50) NOT NULL,
   [method] [varchar](255) NULL,
   [COMMENTS] [text] NULL,
   [errorline] [int] NULL

   ,CONSTRAINT [PK_db_Error_Log] PRIMARY KEY CLUSTERED ([err_id])
)


GO
CREATE TABLE [dbo].[demo_customers] (
   [cst_id] [int] NOT NULL
      IDENTITY (1,1),
   [first_name] [varchar](50) NOT NULL,
   [last_name] [varchar](50) NOT NULL,
   [phone] [varchar](30) NOT NULL,
   [email] [varchar](100) NOT NULL,
   [sales_rep_id] [int] NOT NULL,
   [date_signed] [smalldatetime] NULL,
   [ip_addr] [varchar](50) NULL

   ,CONSTRAINT [PK_demo_customers] PRIMARY KEY CLUSTERED ([cst_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[demo_customers] ([cst_id], [email], [ip_addr])

GO
CREATE TABLE [dbo].[demo_rr] (
   [demo_rr_id] [int] NOT NULL
      IDENTITY (1,1),
   [sales_rep_id] [int] NOT NULL,
   [enroll_sales_rep_id] [int] NULL

   ,CONSTRAINT [PK_demo_rr] PRIMARY KEY CLUSTERED ([demo_rr_id])
)


GO
CREATE TABLE [dbo].[direct_email_addresses] (
   [DirectAddressOwnerType] [int] NOT NULL,
   [OwnerEntityID] [bigint] NOT NULL,
   [DirectAddressPrefix] [varchar](255) NOT NULL,
   [OwnerFullName] [varchar](255) NOT NULL,
   [DirectPassword] [varchar](50) NOT NULL,
   [AgreementAccepted] [bit] NOT NULL,
   [DirectDomainID] [int] NOT NULL

   ,CONSTRAINT [PK_direct_email_addresses] PRIMARY KEY CLUSTERED ([DirectAddressOwnerType], [OwnerEntityID])
)

CREATE UNIQUE NONCLUSTERED INDEX [no_duplicate_addresses] ON [dbo].[direct_email_addresses] ([DirectAddressPrefix])

GO
CREATE TABLE [dbo].[direct_email_address_book] (
   [DirectAddressBookID] [int] NOT NULL
      IDENTITY (1,1),
   [DirectAddressOwnerType] [int] NOT NULL,
   [OwnerEntityID] [bigint] NOT NULL,
   [DirectAddressFullName] [varchar](255) NOT NULL,
   [DirectAddress] [varchar](255) NOT NULL,
   [ModifiedDate] [datetime] NULL,
   [MasterContactId] [bigint] NULL

   ,CONSTRAINT [PK_direct_email_address_book] PRIMARY KEY CLUSTERED ([DirectAddressBookID])
)


GO
CREATE TABLE [dbo].[direct_email_domains] (
   [DirectDomainID] [int] NOT NULL
      IDENTITY (1,1),
   [DirectDomainPrefix] [varchar](255) NOT NULL,
   [FacilityAdminUsername] [varchar](50) NOT NULL,
   [FacilityAdminPassword] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_direct_email_domains] PRIMARY KEY CLUSTERED ([DirectDomainID])
)

CREATE UNIQUE NONCLUSTERED INDEX [NoDuplicatePrefixes] ON [dbo].[direct_email_domains] ([DirectDomainPrefix])

GO
CREATE TABLE [dbo].[direct_email_sent_messages] (
   [direct_message_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [from_address] [varchar](255) NOT NULL,
   [to_address] [varchar](255) NOT NULL,
   [subject] [varchar](100) NOT NULL,
   [message_id] [varchar](255) NOT NULL,
   [attachment_type] [varchar](50) NOT NULL,
   [send_success] [bit] NOT NULL,
   [error_message] [varchar](2000) NOT NULL,
   [sent_date] [datetime] NULL,
   [ref_id] [bigint] NULL

   ,CONSTRAINT [PK_direct_email_sent_messages] PRIMARY KEY CLUSTERED ([direct_message_id])
)


GO
CREATE TABLE [dbo].[dispensableXRef] (
   [ddid] [int] NOT NULL,
   [medid] [int] NOT NULL

   ,CONSTRAINT [PK_dispensableXRef] PRIMARY KEY CLUSTERED ([ddid], [medid])
)


GO
CREATE TABLE [dbo].[DoctorGroupUsageFlags] (
   [DoctorGroupId] [bigint] NOT NULL,
   [UsageFlags] [tinyint] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [CreatedDate] [datetime] NULL

   ,CONSTRAINT [PK_DoctorGroupUsageFlags] PRIMARY KEY CLUSTERED ([DoctorGroupId])
)


GO
CREATE TABLE [dbo].[DoctorIssues] (
   [IssueId] [int] NOT NULL
      IDENTITY (1,1),
   [DrId] [int] NOT NULL,
   [IssueDate] [datetime] NOT NULL,
   [Issue] [text] NOT NULL,
   [ContactName] [varchar](50) NOT NULL,
   [Contact] [varchar](50) NOT NULL,
   [resolution_status] [bit] NOT NULL,
   [Response] [text] NOT NULL

   ,CONSTRAINT [PK_DoctorIssues] PRIMARY KEY CLUSTERED ([IssueId])
)


GO
CREATE TABLE [dbo].[doctors] (
   [dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [dr_field_not_used1] [int] NULL,
   [dr_username] [varchar](50) NULL,
   [dr_password] [varchar](250) NULL,
   [dr_prefix] [varchar](10) NULL,
   [dr_first_name] [varchar](50) NULL,
   [dr_middle_initial] [varchar](20) NULL,
   [dr_last_name] [varchar](50) NULL,
   [dr_suffix] [varchar](20) NULL,
   [dr_address1] [varchar](100) NULL,
   [dr_address2] [varchar](100) NULL,
   [dr_city] [varchar](50) NULL,
   [dr_state] [varchar](30) NULL,
   [dr_zip] [varchar](20) NULL,
   [dr_phone] [varchar](30) NULL,
   [dr_phone_alt1] [varchar](30) NULL,
   [dr_phone_alt2] [varchar](30) NULL,
   [dr_phone_emerg] [varchar](30) NULL,
   [dr_fax] [varchar](30) NULL,
   [dr_email] [varchar](50) NULL,
   [dr_lic_numb] [varchar](50) NULL,
   [dr_lic_state] [varchar](30) NULL,
   [dr_dea_numb] [varchar](30) NULL,
   [dr_sig_file] [varchar](100) NOT NULL,
   [dr_sig_width] [varchar](4) NOT NULL,
   [dr_sig_height] [varchar](4) NOT NULL,
   [dr_create_date] [datetime] NOT NULL,
   [dr_enabled] [bit] NOT NULL,
   [dr_ma] [bit] NOT NULL,
   [prim_dr_id] [int] NOT NULL,
   [dr_last_pat_id] [varchar](30) NOT NULL,
   [dr_last_phrm_id] [varchar](30) NOT NULL,
   [dr_def_pharm_state] [varchar](2) NOT NULL,
   [dr_def_pharm_city] [varchar](50) NOT NULL,
   [dr_palm_dev_id] [varchar](30) NOT NULL,
   [dr_palm_conn_time] [datetime] NOT NULL,
   [dr_exp_date] [datetime] NULL,
   [dr_agreement_acptd] [bit] NOT NULL,
   [dr_logoff_int] [int] NOT NULL,
   [dr_pharm_search_opt] [int] NOT NULL,
   [dr_logged_in] [bit] NOT NULL,
   [dr_session_id] [varchar](255) NULL,
   [time_difference] [int] NULL,
   [hipaa_agreement_acptd] [bit] NOT NULL,
   [fav_patients_criteria] [int] NOT NULL,
   [activated_date] [datetime] NULL,
   [deactivated_date] [datetime] NULL,
   [dr_type] [int] NOT NULL,
   [prescribing_authority] [int] NOT NULL,
   [medco_target_physician] [int] NOT NULL,
   [sfi_docid] [varchar](255) NULL,
   [sfi_docpracticename] [varchar](255) NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_login] [varchar](50) NULL,
   [sfi_encrypted_password] [varchar](50) NULL,
   [sfi_password_decrypted] [bit] NOT NULL,
   [medco_reported] [smalldatetime] NULL,
   [report_print_date] [smalldatetime] NOT NULL,
   [dr_def_print_options] [smallint] NULL,
   [dr_def_no_pharm_print_options] [smallint] NULL,
   [dr_def_pat_history_back_to] [smallint] NULL,
   [dr_last_alias_dr_id] [int] NULL,
   [dr_last_auth_dr_id] [int] NULL,
   [dr_def_rxcard_history_back_to] [smallint] NULL,
   [dr_rxcard_search_consent_type] [varchar](50) NULL,
   [dr_dea_hidden] [bit] NOT NULL,
   [dr_opt_two_printers] [bit] NULL,
   [office_contact_name] [varchar](50) NULL,
   [office_contact_email] [varchar](50) NULL,
   [office_contact_phone] [varchar](50) NULL,
   [best_call_time] [varchar](50) NULL,
   [practice_mgmt_sys] [varchar](50) NULL,
   [internet_connect_type] [varchar](50) NULL,
   [pda_type] [varchar](50) NULL,
   [how_heard_about] [varchar](50) NULL,
   [numb_dr_in_practice] [int] NULL,
   [is_sub_practice] [bit] NULL,
   [use_pda] [bit] NULL,
   [professional_designation] [varchar](50) NULL,
   [medco_rebilled] [bit] NULL,
   [rxhub_reported] [smalldatetime] NULL,
   [medco_rebill_date] [smalldatetime] NULL,
   [dr_first_login_date] [datetime] NULL,
   [dr_force_pass_change] [bit] NOT NULL,
   [rxhub_reportable] [bit] NULL,
   [dr_dea_suffix] [varchar](10) NULL,
   [spi_id] [varchar](19) NULL,
   [password_expiry_date] [smalldatetime] NULL,
   [ss_enable] [bit] NULL,
   [dr_speciality_code] [varchar](50) NULL,
   [dr_view_group_prescriptions] [int] NOT NULL,
   [epocrates_active] [bit] NOT NULL,
   [billing_enabled] [bit] NOT NULL,
   [rights] [bigint] NOT NULL,
   [dr_promo] [varchar](50) NULL,
   [NPI] [varchar](30) NULL,
   [AvgNumb] [int] NULL,
   [printpref] [smallint] NULL,
   [beta_tester] [bit] NULL,
   [DR_SEVERITY] [tinyint] NOT NULL,
   [sales_person_id] [smallint] NULL,
   [dr_status] [smallint] NOT NULL,
   [lab_enabled] [bit] NULL,
   [lowusage_lock] [bit] NOT NULL,
   [loginlock] [bit] NOT NULL,
   [loginattempts] [tinyint] NOT NULL,
   [msg_alert_cell_number] [varchar](20) NULL,
   [commpreference] [char](1) NULL,
   [epcs_enabled] [bit] NULL,
   [billingDate] [datetime] NULL,
   [salt] [varchar](250) NULL,
   [timezone] [varchar](10) NULL,
   [isMigrated] [bit] NOT NULL,
   [IsEmailVerified] [bit] NOT NULL,
   [IsEmailVerificationPending] [bit] NOT NULL,
   [low_usage_removed_date] [datetime] NULL

   ,CONSTRAINT [PK_doctors] PRIMARY KEY NONCLUSTERED ([dr_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_doctors_23_1927066001__K1_K2_7_9_97] ON [dbo].[doctors] ([dr_id], [dg_id]) INCLUDE ([dr_first_name], [dr_last_name], [NPI])
CREATE NONCLUSTERED INDEX [_dta_index_doctors_7_450868723__K1_7_9] ON [dbo].[doctors] ([dr_id]) INCLUDE ([dr_first_name], [dr_last_name])
CREATE NONCLUSTERED INDEX [_dta_index_doctors_7_450868723__K1_K2_6_7_9] ON [dbo].[doctors] ([dr_id], [dg_id]) INCLUDE ([dr_first_name], [dr_last_name], [dr_prefix])
CREATE NONCLUSTERED INDEX [_dta_index_doctors_7_450868723__K29_K51_K1_K2_7_9_24_97] ON [dbo].[doctors] ([dr_enabled], [medco_target_physician], [dr_id], [dg_id]) INCLUDE ([dr_dea_numb], [dr_first_name], [dr_last_name], [NPI])
CREATE CLUSTERED INDEX [doctors5] ON [dbo].[doctors] ([dg_id])
CREATE NONCLUSTERED INDEX [ix_doctors_dg_id_dr_enabled_lowusage_lock_loginlock_prescribing_authority] ON [dbo].[doctors] ([dg_id], [dr_enabled], [lowusage_lock], [loginlock], [prescribing_authority])
CREATE UNIQUE NONCLUSTERED INDEX [UserNameNoDups] ON [dbo].[doctors] ([dr_username])

GO
CREATE TABLE [dbo].[doctors_log_delete] (
   [dr_log_del_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [dg_id] [int] NULL,
   [dr_field_not_used1] [int] NULL,
   [dr_prefix] [varchar](10) NULL,
   [dr_first_name] [varchar](50) NULL,
   [dr_middle_initial] [varchar](2) NULL,
   [dr_last_name] [varchar](50) NULL,
   [deleting_user] [varchar](100) NULL

   ,CONSTRAINT [PK_doctors_log_delete] PRIMARY KEY CLUSTERED ([dr_log_del_id])
)


GO
CREATE TABLE [dbo].[doctors_reactivated_status_log] (
   [rds_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [reactivated_date] [datetime] NULL,
   [reactivated_id] [varchar](50) NULL

   ,CONSTRAINT [PK_doctors_reactivated_status_log] PRIMARY KEY CLUSTERED ([rds_log_id])
)


GO
CREATE TABLE [dbo].[doctors_status_log] (
   [ds_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [change_date] [datetime] NULL,
   [changer_id] [varchar](50) NULL

   ,CONSTRAINT [PK_doctors_status_log] PRIMARY KEY CLUSTERED ([ds_log_id])
)


GO
CREATE TABLE [dbo].[doctor_app_info] (
   [dr_id] [int] NOT NULL,
   [PM] [bit] NOT NULL,
   [EHR] [bit] NOT NULL,
   [ERX] [bit] NOT NULL,
   [EPCS] [bit] NOT NULL,
   [SCHEDULER] [bit] NOT NULL

   ,CONSTRAINT [PK_doctor_app_info] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
CREATE TABLE [dbo].[doctor_grouping] (
   [grp_id] [int] NOT NULL
      IDENTITY (1,1),
   [title] [varchar](255) NOT NULL,
   [dg_id] [int] NOT NULL

   ,CONSTRAINT [PK_doctor_grouping] PRIMARY KEY CLUSTERED ([grp_id])
)


GO
CREATE TABLE [dbo].[doctor_grouping_details] (
   [grp_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [grp_details_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_doctor_grouping_details] PRIMARY KEY CLUSTERED ([grp_details_id])
)

CREATE NONCLUSTERED INDEX [IX_doctor_grouping_details] ON [dbo].[doctor_grouping_details] ([grp_id], [dr_id])

GO
CREATE TABLE [dbo].[doctor_info] (
   [dr_id] [int] NOT NULL,
   [dr_dea_address1] [varchar](100) NULL,
   [dr_dea_address2] [varchar](100) NULL,
   [dr_dea_city] [varchar](50) NULL,
   [dr_dea_state] [varchar](30) NULL,
   [dr_dea_zip] [varchar](20) NULL,
   [dr_dea_first_name] [varchar](50) NULL,
   [dr_dea_last_name] [varchar](50) NULL,
   [dr_dea_middle_initial] [varchar](20) NULL,
   [spectrum_id] [varchar](30) NULL,
   [blowusageemail] [bit] NOT NULL,
   [labcorp_id] [varchar](50) NULL,
   [securityset] [bit] NULL,
   [bduplicateuser] [bit] NULL,
   [is_coupon_enabled] [bit] NULL,
   [is_custom_tester] [int] NULL,
   [is_epcs] [bit] NULL,
   [IS_MUALERTS_ENABLED] [smallint] NULL,
   [settings] [smallint] NOT NULL,
   [system_level_cds] [int] NULL,
   [VersionURL] [varchar](200) NULL,
   [bOverrideDEA] [bit] NOT NULL,
   [encounter_version] [varchar](10) NULL,
   [vitals_unit_type] [varchar](5) NULL,
   [INLCUDE_ICD_Prescription] [bit] NULL,
   [return_to_prov_dashboard] [bit] NULL,
   [Add_Medications_To_My_Fav_Drugs] [bit] NULL,
   [EnableRulesEngine] [bit] NULL,
   [is_bannerads_enabled] [bit] NULL,
   [hide_walkme] [bit] NULL,
   [staff_preferred_prescriber] [bigint] NULL,
   [is_pain_scale_enabled] [bit] NULL,
   [dr_dea_certificate_external_id] [varchar](250) NULL,
   [dr_dea_certificate_file_name] [varchar](250) NULL,
   [dr_alternate_name_registered] [bit] NULL,
   [dr_prescribe_suboxone] [bit] NULL,
   [is_institutional_dea] [bit] NULL,
   [manual_encounter_forms_sort] [bit] NULL,
   [show_encounter_forms_sort_message] [bit] NULL,
   [dont_ignore_popup_on_patient_intake_sync] [bit] NULL,
   [hide_encounter_sign_confirmation_popup] [bit] NOT NULL,
   [dont_ignore_popup_on_doctor_sign_encounter] [bit] NOT NULL,
   [dont_ignore_popup_on_doctor_release_encounter] [bit] NULL

   ,CONSTRAINT [PK_doctor_info] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
CREATE TABLE [dbo].[doctor_info_ED_2925] (
   [dr_id] [int] NOT NULL,
   [dr_dea_address1] [varchar](100) NULL,
   [dr_dea_address2] [varchar](100) NULL,
   [dr_dea_city] [varchar](50) NULL,
   [dr_dea_state] [varchar](30) NULL,
   [dr_dea_zip] [varchar](20) NULL,
   [dr_dea_first_name] [varchar](50) NULL,
   [dr_dea_last_name] [varchar](50) NULL,
   [dr_dea_middle_initial] [varchar](20) NULL,
   [spectrum_id] [varchar](30) NULL,
   [blowusageemail] [bit] NOT NULL,
   [labcorp_id] [varchar](50) NULL,
   [securityset] [bit] NULL,
   [bduplicateuser] [bit] NULL,
   [is_coupon_enabled] [bit] NULL,
   [is_custom_tester] [int] NULL,
   [is_epcs] [bit] NULL,
   [IS_MUALERTS_ENABLED] [smallint] NULL,
   [settings] [smallint] NOT NULL,
   [system_level_cds] [int] NULL,
   [VersionURL] [varchar](200) NULL,
   [bOverrideDEA] [bit] NOT NULL,
   [encounter_version] [varchar](10) NULL,
   [vitals_unit_type] [varchar](5) NULL,
   [INLCUDE_ICD_Prescription] [bit] NULL,
   [return_to_prov_dashboard] [bit] NULL,
   [Add_Medications_To_My_Fav_Drugs] [bit] NULL,
   [EnableRulesEngine] [bit] NULL,
   [is_bannerads_enabled] [bit] NULL,
   [hide_walkme] [bit] NULL,
   [staff_preferred_prescriber] [bigint] NULL,
   [is_pain_scale_enabled] [bit] NULL
)


GO
CREATE TABLE [dbo].[doctor_patient_messages] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [from_id] [int] NOT NULL,
   [to_id] [int] NOT NULL,
   [msg_date] [datetime] NOT NULL,
   [message] [text] NOT NULL,
   [is_read] [bit] NOT NULL,
   [is_complete] [bit] NULL,
   [from_deleted_id] [int] NULL,
   [to_deleted_id] [int] NULL,
   [messagedigest] [varchar](2000) NULL,
   [PatientRepresentativeId] [bigint] NULL,
   [msg_date_utc] [datetime] NULL

   ,CONSTRAINT [PK_doctor_patient_messages] PRIMARY KEY CLUSTERED ([id])
)

CREATE NONCLUSTERED INDEX [ix_doctor_patient_messages_to_id_is_complete_to_deleted_id] ON [dbo].[doctor_patient_messages] ([to_id], [is_complete], [to_deleted_id])

GO
CREATE TABLE [dbo].[doctor_printserver_reg] (
   [dr_id] [int] NOT NULL,
   [master_id] [int] NOT NULL,
   [reg_id_rx] [int] NOT NULL,
   [reg_id_plain] [int] NOT NULL,
   [print_server] [bit] NOT NULL

   ,CONSTRAINT [PK_doctor_printserver_reg] PRIMARY KEY NONCLUSTERED ([dr_id], [master_id])
)

CREATE UNIQUE CLUSTERED INDEX [IX_MAIN] ON [dbo].[doctor_printserver_reg] ([dr_id])

GO
CREATE TABLE [dbo].[doctor_specialities] (
   [speciality_id] [int] NOT NULL
      IDENTITY (1,1),
   [speciality] [varchar](255) NULL

   ,CONSTRAINT [PK_doctor_specialities] PRIMARY KEY CLUSTERED ([speciality_id])
)


GO
CREATE TABLE [dbo].[doctor_specialities_xref] (
   [dr_sp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [speciality_id] [int] NOT NULL

   ,CONSTRAINT [PK_doctor_specialities_xref] PRIMARY KEY CLUSTERED ([dr_sp_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_doctor_specialities_xref] ON [dbo].[doctor_specialities_xref] ([dr_id], [speciality_id])

GO
CREATE TABLE [dbo].[doc_admin] (
   [dr_admin_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_partner_participant] [int] NOT NULL,
   [dr_service_level] [smallint] NOT NULL,
   [dr_partner_enabled] [bit] NOT NULL,
   [report_date] [smalldatetime] NOT NULL,
   [update_date] [smalldatetime] NOT NULL,
   [fail_lock] [bit] NULL,
   [version] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_doc_admin] PRIMARY KEY CLUSTERED ([dr_admin_id], [dr_id], [dr_partner_participant])
)

CREATE NONCLUSTERED INDEX [ix_doc_admin_dr_id_dr_partner_participant_version] ON [dbo].[doc_admin] ([dr_id], [dr_partner_participant], [version])

GO
CREATE TABLE [dbo].[doc_cds_rules] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [rule_xml] [xml] NOT NULL,
   [is_Active] [bit] NULL,
   [NAME] [varchar](100) NOT NULL,
   [Description] [varchar](1000) NOT NULL,
   [Reference] [varchar](1000) NOT NULL,
   [Information] [varchar](1000) NOT NULL
)


GO
CREATE TABLE [dbo].[doc_companies] (
   [dc_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_name] [varchar](80) NULL,
   [partner_id] [int] NOT NULL,
   [protocol_enabled] [bit] NULL,
   [SHOW_EMAIL] [smallint] NULL,
   [dc_host_id] [int] NOT NULL,
   [admin_company_id] [int] NOT NULL,
   [emr_modules] [int] NOT NULL,
   [dc_settings] [smallint] NOT NULL,
   [is_custom_tester] [bit] NULL,
   [dc_tin] [varchar](50) NULL,
   [EnableRulesEngine] [bit] NULL,
   [EnableV2EncounterTemplate] [bit] NOT NULL,
   [no_formulary] [bit] NULL,
   [EnableExternalVitals] [bit] NULL,
   [IsPatientInformationBlockingEnabled] [bit] NULL,
   [IsBannerAdsDisabled] [bit] NULL,
   [ModifiedDate] [datetime2] NULL

   ,CONSTRAINT [PK_doc_companies] PRIMARY KEY CLUSTERED ([dc_id])
)


GO
CREATE TABLE [dbo].[doc_company_hosts] (
   [dc_host_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_host_name] [varchar](255) NOT NULL,
   [dc_host_login_proto] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_doc_company_hosts] PRIMARY KEY CLUSTERED ([dc_host_id])
)


GO
CREATE TABLE [dbo].[doc_company_site_fav_pharms] (
   [dcfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_company_site_fav_pharms] PRIMARY KEY CLUSTERED ([dcfp_id])
)


GO
CREATE TABLE [dbo].[doc_company_themes] (
   [dc_id] [int] NOT NULL,
   [theme_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_company_themes] PRIMARY KEY CLUSTERED ([dc_id])
)


GO
CREATE TABLE [dbo].[doc_company_themes_xref] (
   [theme_id] [int] NOT NULL,
   [theme_name] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_doc_company_themes_xref] PRIMARY KEY CLUSTERED ([theme_id])
)


GO
CREATE TABLE [dbo].[doc_fav_cities] (
   [fc_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [fc_state] [varchar](2) NOT NULL,
   [fc_city] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_dov_fav_cities] PRIMARY KEY NONCLUSTERED ([fc_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DrCityState_NoDups] ON [dbo].[doc_fav_cities] ([dr_id], [fc_state], [fc_city])

GO
CREATE TABLE [dbo].[doc_fav_classes] (
   [dfc_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [etc_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_classes] PRIMARY KEY CLUSTERED ([dfc_id])
)


GO
CREATE TABLE [dbo].[doc_fav_drugs] (
   [dfd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_drugs_v2] PRIMARY KEY NONCLUSTERED ([dfd_id])
)

CREATE UNIQUE CLUSTERED INDEX [unique_doc_fav_drugs] ON [dbo].[doc_fav_drugs] ([dr_id], [drug_id])

GO
CREATE TABLE [dbo].[doc_fav_icd9Codes] (
   [fICD9Codes_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [icd9Code] [varchar](50) NOT NULL,
   [icd9Descriptor] [varchar](1000) NOT NULL,
   [Icd10Code] [varchar](50) NULL,
   [Icd10Descriptor] [varchar](1000) NULL

   ,CONSTRAINT [PK_doc_fav_icd9Codes] PRIMARY KEY CLUSTERED ([fICD9Codes_id])
)

CREATE NONCLUSTERED INDEX [uq_doc_fav_icd9Codes] ON [dbo].[doc_fav_icd9Codes] ([dr_id], [icd9Code])

GO
CREATE TABLE [dbo].[doc_fav_info] (
   [info_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_fullName] [varchar](100) NOT NULL,
   [appointment_duration] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_info] PRIMARY KEY CLUSTERED ([info_id])
)


GO
CREATE TABLE [dbo].[doc_fav_pages] (
   [fav_page_indx] [int] NOT NULL
      IDENTITY (1,1),
   [fav_page_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_pages] PRIMARY KEY CLUSTERED ([fav_page_indx])
)


GO
CREATE TABLE [dbo].[doc_fav_patients] (
   [dfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_patients] PRIMARY KEY NONCLUSTERED ([dfp_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DrPat_NoDups] ON [dbo].[doc_fav_patients] ([dr_id], [pa_id])

GO
CREATE TABLE [dbo].[doc_fav_patients_log] (
   [fpl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [update_code] [smallint] NOT NULL,
   [update_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_doc_fav_patients_log] PRIMARY KEY CLUSTERED ([fpl_id])
)


GO
CREATE TABLE [dbo].[doc_fav_pharms] (
   [fp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [update_code] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_pharms] PRIMARY KEY NONCLUSTERED ([fp_id])
)

CREATE CLUSTERED INDEX [doc_fav_pharms1] ON [dbo].[doc_fav_pharms] ([pharm_id])
CREATE NONCLUSTERED INDEX [doc_fav_pharms5] ON [dbo].[doc_fav_pharms] ([pharm_id], [dr_id], [update_code])
CREATE UNIQUE NONCLUSTERED INDEX [DrPh_NoDups] ON [dbo].[doc_fav_pharms] ([dr_id], [pharm_id])

GO
CREATE TABLE [dbo].[doc_fav_pharms_log] (
   [fpl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [update_code] [smallint] NOT NULL,
   [update_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_doc_fav_pharms_log] PRIMARY KEY CLUSTERED ([fpl_id])
)


GO
CREATE TABLE [dbo].[doc_fav_procedure_codes] (
   [dr_id] [int] NOT NULL,
   [cpt_code] [varchar](50) NOT NULL,
   [created_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_doc_fav_procedure_codes] PRIMARY KEY CLUSTERED ([dr_id], [cpt_code])
)


GO
CREATE TABLE [dbo].[doc_fav_scripts] (
   [script_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NULL,
   [duration_unit] [varchar](80) NULL,
   [duration_amount] [varchar](10) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [update_code] [int] NULL,
   [drug_version] [varchar](10) NOT NULL,
   [prn_description] [varchar](50) NOT NULL,
   [compound] [bit] NOT NULL,
   [days_supply] [smallint] NULL,
   [hospice_drug_relatedness_id] [int] NULL,
   [drug_indication] [varchar](100) NULL

   ,CONSTRAINT [PK_doc_fav_scripts] PRIMARY KEY NONCLUSTERED ([script_id])
)

CREATE NONCLUSTERED INDEX [_doc_fav_script2] ON [dbo].[doc_fav_scripts] ([dr_id], [ddid])
CREATE CLUSTERED INDEX [_doc_fav_scripts] ON [dbo].[doc_fav_scripts] ([script_id])

GO
CREATE TABLE [dbo].[doc_fav_scripts_sig_details] (
   [script_sig_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [script_id] [int] NOT NULL,
   [sig_sequence_number] [int] NULL,
   [sig_action] [varchar](50) NULL,
   [sig_qty] [varchar](50) NULL,
   [sig_form] [varchar](50) NULL,
   [sig_route] [varchar](50) NULL,
   [sig_time_qty] [varchar](50) NULL,
   [sig_time_option] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_fav___DB6FCF253C98117E] PRIMARY KEY CLUSTERED ([script_sig_id])
)


GO
CREATE TABLE [dbo].[doc_fav_vitals] (
   [docId] [int] NOT NULL,
   [vitalsId] [int] NOT NULL,
   [vitalsCheck] [bit] NOT NULL,
   [vitalsText] [varchar](50) NOT NULL

   ,CONSTRAINT [pk_favVitals] PRIMARY KEY CLUSTERED ([docId], [vitalsId], [vitalsCheck])
)


GO
CREATE TABLE [dbo].[doc_groups] (
   [dg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [dg_name] [varchar](80) NOT NULL,
   [beta_tester] [bit] NOT NULL,
   [sfi_group] [bit] NOT NULL,
   [sfi_patient_lookup] [bit] NULL,
   [payment_plan_id] [int] NOT NULL,
   [payment_reoccurrence] [tinyint] NOT NULL,
   [payment_month] [tinyint] NULL,
   [billing_date] [datetime] NULL,
   [reactivation_date] [varchar](50) NULL,
   [scheduled_enabled] [bit] NOT NULL,
   [default_dr_id] [int] NULL,
   [notes] [varchar](150) NULL,
   [status] [varchar](2) NULL,
   [comments] [varchar](600) NULL,
   [lab_status] [tinyint] NOT NULL,
   [emr_modules] [int] NOT NULL

   ,CONSTRAINT [PK_doc_groups] PRIMARY KEY NONCLUSTERED ([dg_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_doc_groups_23_7059161__K2_K1] ON [dbo].[doc_groups] ([dc_id], [dg_id])
CREATE NONCLUSTERED INDEX [IX_doc_groups_dc_id] ON [dbo].[doc_groups] ([dc_id])

GO
CREATE TABLE [dbo].[doc_groups_ex1] (
   [dg_id] [int] NOT NULL,
   [businessday_start] [time] NULL,
   [businessday_end] [time] NULL

   ,CONSTRAINT [PK_doc_groups_ex1] PRIMARY KEY CLUSTERED ([dg_id])
)


GO
CREATE TABLE [dbo].[doc_groups_lab_info] (
   [doc_group_lab_xref_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [dg_lab_id] [varchar](50) NOT NULL,
   [lab_participant] [bigint] NOT NULL,
   [name] [varchar](50) NULL,
   [sender_mnemonics] [varchar](255) NULL,
   [bi_support] [bit] NULL,
   [account_key] [varchar](50) NULL,
   [external_lab_id] [varchar](50) NULL,
   [external_lab_name] [varchar](50) NULL,
   [auto_read_lab_result] [bit] NULL

   ,CONSTRAINT [PK_doc_groups_lab_info] PRIMARY KEY CLUSTERED ([doc_group_lab_xref_id])
)


GO
CREATE TABLE [dbo].[doc_groups_snomed] (
   [snom_id] [int] NOT NULL
      IDENTITY (1,1),
   [Name] [nvarchar](500) NOT NULL,
   [SnomedCode] [nvarchar](50) NOT NULL,
   [Category] [varchar](100) NULL,
   [dg_id] [int] NULL

   ,CONSTRAINT [PK__doc_grou__9519E6C2002334C4] PRIMARY KEY CLUSTERED ([snom_id])
)


GO
CREATE TABLE [dbo].[doc_group_actions] (
   [dg_action_id] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_actions] PRIMARY KEY CLUSTERED ([dg_action_id])
)


GO
CREATE TABLE [dbo].[doc_group_application_map] (
   [dg_application_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL

   ,CONSTRAINT [PK_doc_group_application_map] PRIMARY KEY CLUSTERED ([dg_application_id])
)

CREATE NONCLUSTERED INDEX [ix_doc_group_application_map_dg_id_ApplicationID] ON [dbo].[doc_group_application_map] ([dg_id], [ApplicationID])

GO
CREATE TABLE [dbo].[doc_group_drug_action] (
   [dg_drug_action_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0720E50A11] PRIMARY KEY CLUSTERED ([dg_drug_action_id])
)


GO
CREATE TABLE [dbo].[doc_group_drug_formulation] (
   [dg_drug_formulation_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0724B59AF5] PRIMARY KEY CLUSTERED ([dg_drug_formulation_id])
)


GO
CREATE TABLE [dbo].[doc_group_drug_frequency] (
   [dg_drug_frequency_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC072C56BCBD] PRIMARY KEY CLUSTERED ([dg_drug_frequency_id])
)


GO
CREATE TABLE [dbo].[doc_group_drug_indication] (
   [dg_drug_indication_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL,
   [ICD10] [varchar](50) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0730274DA1] PRIMARY KEY CLUSTERED ([dg_drug_indication_id])
)


GO
CREATE TABLE [dbo].[doc_group_drug_route] (
   [dg_drug_route_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0728862BD9] PRIMARY KEY CLUSTERED ([dg_drug_route_id])
)


GO
CREATE TABLE [dbo].[doc_group_encounter_templates] (
   [enc_tmpl_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [enc_type_id] [int] NOT NULL,
   [enc_name] [varchar](75) NULL,
   [enc_text] [ntext] NULL,
   [enc_json] [varchar](max) NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
CREATE TABLE [dbo].[doc_group_enhanced_encounter_templates] (
   [enc_tmpl_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [enc_name] [varchar](75) NOT NULL,
   [enc_json] [nvarchar](max) NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_enhanced_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
CREATE TABLE [dbo].[doc_group_fav_drugs] (
   [dgfd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_drugs] PRIMARY KEY CLUSTERED ([dgfd_id])
)


GO
CREATE TABLE [dbo].[doc_group_fav_pharms] (
   [dgfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL,
   [added_by_dr_id] [bigint] NULL,
   [added_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_pharms] PRIMARY KEY CLUSTERED ([dgfp_id])
)


GO
CREATE TABLE [dbo].[doc_group_fav_ref_institutions] (
   [dgfri_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [inst_id] [int] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL,
   [added_by_dr_id] [bigint] NULL,
   [added_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_ref_institutions] PRIMARY KEY CLUSTERED ([dgfri_id])
)


GO
CREATE TABLE [dbo].[doc_group_fav_ref_providers] (
   [dgfrp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL,
   [added_by_dr_id] [bigint] NULL,
   [added_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_ref_providers] PRIMARY KEY CLUSTERED ([dgfrp_id])
)


GO
CREATE TABLE [dbo].[doc_group_fav_scripts] (
   [script_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NULL,
   [duration_unit] [varchar](80) NULL,
   [duration_amount] [varchar](10) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [update_code] [int] NULL,
   [drug_version] [varchar](10) NOT NULL,
   [prn_description] [varchar](50) NOT NULL,
   [compound] [bit] NOT NULL,
   [days_supply] [smallint] NULL,
   [hospice_drug_relatedness_id] [int] NULL,
   [drug_indication] [varchar](50) NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_scripts] PRIMARY KEY NONCLUSTERED ([script_id])
)


GO
CREATE TABLE [dbo].[doc_group_fav_scripts_sig_details] (
   [script_sig_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [script_id] [int] NOT NULL,
   [sig_sequence_number] [int] NULL,
   [sig_action] [varchar](50) NULL,
   [sig_qty] [varchar](50) NULL,
   [sig_form] [varchar](50) NULL,
   [sig_route] [varchar](50) NULL,
   [sig_time_qty] [varchar](50) NULL,
   [sig_time_option] [varchar](100) NULL

   ,CONSTRAINT [PK_doc_group_fav_scripts_sig_details] PRIMARY KEY CLUSTERED ([script_sig_id])
)


GO
CREATE TABLE [dbo].[doc_group_freetext_meds] (
   [dgfm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [drug_name] [varchar](200) NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [is_active] [bit] NOT NULL,
   [drug_category] [smallint] NOT NULL,
   [preferred_name] [bit] NULL

   ,CONSTRAINT [PK_doc_group_freetext_meds] PRIMARY KEY CLUSTERED ([dgfm_id])
)

CREATE NONCLUSTERED INDEX [ix_doc_group_freetext_meds_dg_id_drug_id_includes] ON [dbo].[doc_group_freetext_meds] ([dg_id], [drug_id]) INCLUDE ([drug_category])
CREATE NONCLUSTERED INDEX [ix_doc_group_freetext_meds_drug_id] ON [dbo].[doc_group_freetext_meds] ([drug_id])

GO
CREATE TABLE [dbo].[doc_group_freetext_med_ingredients] (
   [dgfmi_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dgfm_id] [int] NOT NULL,
   [ingredient_drug_id] [int] NULL,
   [drug_id] [int] NOT NULL,
   [drug_level] [int] NOT NULL,
   [comp_ingredient] [varchar](200) NOT NULL,
   [strength_value] [varchar](10) NULL,
   [strength_unit_id] [int] NULL,
   [strength_form_id] [int] NULL,
   [qty] [varchar](50) NOT NULL,
   [qty_unit_id] [int] NOT NULL,
   [is_active] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [last_modified_date] [datetime] NULL
)


GO
CREATE TABLE [dbo].[doc_group_hm_rules] (
   [rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [gender] [varchar](2) NULL,
   [added_by_dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [is_active] [bit] NULL,
   [name] [varchar](255) NULL,
   [supporting_url] [varchar](512) NULL,
   [min_age_days] [int] NULL,
   [max_age_days] [int] NULL,
   [description] [ntext] NOT NULL

   ,CONSTRAINT [PK_doc_group_hm_rules] PRIMARY KEY CLUSTERED ([rule_id])
)


GO
CREATE TABLE [dbo].[doc_group_hm_rules_ex1] (
   [rule_id] [bigint] NULL,
   [RuleFilterConditions] [xml] NULL,
   [RecurrenceRule] [nvarchar](1024) NULL,
   [next_recurrence_minutes] [bigint] NULL
)


GO
CREATE TABLE [dbo].[doc_group_lost_documents] (
   [lost_document_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [pa_first] [varchar](50) NULL,
   [pa_last] [varchar](50) NULL,
   [pa_sex] [varchar](1) NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_ssn] [varchar](20) NULL,
   [pa_zip] [varchar](20) NULL,
   [additional_info] [varchar](1024) NULL,
   [error_msg] [varchar](1024) NULL,
   [document_path] [varchar](1024) NULL

   ,CONSTRAINT [PK_doc_group_lost_documents] PRIMARY KEY CLUSTERED ([lost_document_id])
)


GO
CREATE TABLE [dbo].[doc_group_module_action] (
   [dg_module_action_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_page_module_info_id] [int] NOT NULL,
   [dg_action_id] [int] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_module_action] PRIMARY KEY CLUSTERED ([dg_module_action_id])
)


GO
CREATE TABLE [dbo].[doc_group_module_info] (
   [dg_module_info_id] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_module_info] PRIMARY KEY CLUSTERED ([dg_module_info_id])
)


GO
CREATE TABLE [dbo].[doc_group_page_info] (
   [dg_page_info_id] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_page_info] PRIMARY KEY CLUSTERED ([dg_page_info_id])
)


GO
CREATE TABLE [dbo].[doc_group_page_module_info] (
   [dg_page_module_info_id] [bigint] NOT NULL,
   [dg_page_info_id] [int] NOT NULL,
   [dg_module_info_id] [int] NOT NULL,
   [active] [bit] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_page_module_info] PRIMARY KEY CLUSTERED ([dg_page_module_info_id])
)


GO
CREATE TABLE [dbo].[doc_group_recent_drugs] (
   [dgrd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [drug_prescribed_count] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_recent_drugs] PRIMARY KEY CLUSTERED ([dgrd_id])
)


GO
CREATE TABLE [dbo].[doc_group_taper_sigs] (
   [dcts_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [med_id] [bigint] NOT NULL,
   [sig] [varchar](210) NOT NULL,
   [CreatedBy] [bigint] NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_doc_group_taper_sigs] PRIMARY KEY CLUSTERED ([dcts_id])
)


GO
CREATE TABLE [dbo].[doc_messages] (
   [DrMsgID] [int] NOT NULL
      IDENTITY (1,1),
   [DrMsgDate] [datetime] NULL,
   [DrMsgBy] [varchar](100) NULL,
   [DrMessage] [text] NULL,
   [DrIsComplete] [bit] NULL

   ,CONSTRAINT [PK_doc_messages] PRIMARY KEY CLUSTERED ([DrMsgID])
)


GO
CREATE TABLE [dbo].[doc_message_reads] (
   [ReadID] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [DrMsgID] [int] NULL,
   [ReadDate] [datetime] NULL

   ,CONSTRAINT [PK_doc_message_reads] PRIMARY KEY CLUSTERED ([ReadID])
)

CREATE NONCLUSTERED INDEX [IX_doc_message_reads-dr_id-DrMsgID] ON [dbo].[doc_message_reads] ([dr_id]) INCLUDE ([DrMsgID])

GO
CREATE TABLE [dbo].[doc_password_history] (
   [change_pwd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [password1] [varchar](50) NOT NULL,
   [password2] [varchar](50) NOT NULL,
   [password3] [varchar](50) NOT NULL,
   [nowactive] [smallint] NOT NULL

   ,CONSTRAINT [PK_doc_password_history] PRIMARY KEY CLUSTERED ([change_pwd_id])
)


GO
CREATE TABLE [dbo].[doc_question_answer] (
   [doc_question_answer_id] [int] NOT NULL
      IDENTITY (1,1),
   [doc_question_id] [int] NOT NULL,
   [doc_answer] [varchar](1000) NOT NULL,
   [dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_question_answer] PRIMARY KEY CLUSTERED ([doc_question_answer_id])
)

CREATE NONCLUSTERED INDEX [IDX_dq_drid] ON [dbo].[doc_question_answer] ([dr_id])

GO
CREATE TABLE [dbo].[doc_reports_log] (
   [dr_report_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [print_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_doc_reports_log] PRIMARY KEY CLUSTERED ([dr_report_id])
)


GO
CREATE TABLE [dbo].[doc_rights] (
   [dr_right_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [right_id] [int] NOT NULL

   ,CONSTRAINT [PK_dr_rights] PRIMARY KEY CLUSTERED ([dr_right_id])
)


GO
CREATE TABLE [dbo].[doc_security_groups] (
   [dsg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsg_desc] [varchar](255) NOT NULL,
   [dsg_id_required_ids] [varchar](100) NULL,
   [rights] [bigint] NULL

   ,CONSTRAINT [PK_doc_security_groups] PRIMARY KEY CLUSTERED ([dsg_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DescNoDupes] ON [dbo].[doc_security_groups] ([dsg_desc])

GO
CREATE TABLE [dbo].[doc_security_group_members] (
   [dsgm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dsg_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_security_group_members] PRIMARY KEY CLUSTERED ([dsgm_id])
)

CREATE NONCLUSTERED INDEX [IX_doc_security_group_members-dr_id] ON [dbo].[doc_security_group_members] ([dr_id])

GO
CREATE TABLE [dbo].[doc_security_group_rights] (
   [dsgr_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsg_id] [int] NOT NULL,
   [right_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_security_group_rights] PRIMARY KEY CLUSTERED ([dsgr_id])
)


GO
CREATE TABLE [dbo].[doc_security_questions] (
   [doc_sec_question_id] [int] NOT NULL,
   [doc_sec_question] [varchar](1000) NULL,
   [doc_question_index] [smallint] NULL

   ,CONSTRAINT [PK_doc_security_questions] PRIMARY KEY CLUSTERED ([doc_sec_question_id])
)


GO
CREATE TABLE [dbo].[doc_site_fav_pharms] (
   [dfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_site_fav_pharms] PRIMARY KEY CLUSTERED ([dfp_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[doc_site_fav_pharms] ([dr_id], [pharm_id])

GO
CREATE TABLE [dbo].[doc_token_info] (
   [doc_token_track_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [stage] [smallint] NOT NULL,
   [comments] [varchar](4000) NOT NULL,
   [ups_tracking_id] [varchar](500) NOT NULL,
   [ups_label_file] [varchar](50) NOT NULL,
   [shipping_fee] [float] NOT NULL,
   [shipping_address1] [varchar](255) NOT NULL,
   [shipping_city] [varchar](50) NOT NULL,
   [shipping_state] [varchar](2) NOT NULL,
   [shipping_zip] [varchar](50) NOT NULL,
   [shipping_to_name] [varchar](100) NOT NULL,
   [ship_submit_date] [datetime] NULL,
   [shipment_identification] [varchar](100) NULL,
   [email] [varchar](100) NULL,
   [idretries] [smallint] NULL,
   [maxidretries] [smallint] NULL,
   [token_serial_no] [varchar](20) NULL,
   [token_type] [int] NULL,
   [is_activated] [int] NULL,
   [IsSigRequired] [bit] NOT NULL,
   [created_by] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_edited_by] [bigint] NULL,
   [last_edited_on] [datetime] NULL,
   [shipping_address2] [varchar](255) NULL,
   [ups_file_id] [bigint] NULL

   ,CONSTRAINT [PK_doc_token_info] PRIMARY KEY CLUSTERED ([doc_token_track_id])
)


GO
CREATE TABLE [dbo].[doc_usage_flags] (
   [dr_id] [int] NOT NULL,
   [usage_flags] [tinyint] NOT NULL

   ,CONSTRAINT [PK_doc_usage_flags] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
CREATE TABLE [dbo].[doc_vitalsList] (
   [vitalsId] [int] NOT NULL,
   [vitalsText] [varchar](50) NOT NULL,
   [OrderIndex] [int] NULL

   ,CONSTRAINT [PK__doc_vita__4069263A7EEE4E12] PRIMARY KEY CLUSTERED ([vitalsId])
)


GO
CREATE TABLE [dbo].[drug_fdb_strength_units] (
   [dsu_fdb_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsu_text] [varchar](100) NOT NULL,
   [dsu_id] [int] NULL

   ,CONSTRAINT [PK_drug_fdb_strength_units] PRIMARY KEY NONCLUSTERED ([dsu_fdb_id])
   ,CONSTRAINT [UQ__drug_fdb__0EE344594A401E12] UNIQUE NONCLUSTERED ([dsu_text])
)


GO
CREATE TABLE [dbo].[drug_frequency] (
   [drug_frequency_id] [bigint] NOT NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__drug_fre__3214EC071943E849] PRIMARY KEY CLUSTERED ([drug_frequency_id])
)


GO
CREATE TABLE [dbo].[drug_indication] (
   [drug_indication_id] [bigint] NOT NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__drug_ind__3214EC071D14792D] PRIMARY KEY CLUSTERED ([drug_indication_id])
)


GO
CREATE TABLE [dbo].[drug_map] (
   [medid] [numeric](8,0) NOT NULL,
   [NDC] [varchar](11) NULL,
   [MED_ROUTE_DESC] [varchar](30) NULL,
   [MED_STRENGTH] [varchar](15) NULL,
   [MED_STRENGTH_UOM] [varchar](15) NULL

   ,CONSTRAINT [PK_drug_map] PRIMARY KEY CLUSTERED ([medid])
)

CREATE NONCLUSTERED INDEX [ix_main] ON [dbo].[drug_map] ([medid])

GO
CREATE TABLE [dbo].[drug_quantity_units] (
   [dqu_id] [int] NOT NULL
      IDENTITY (1,1),
   [dqu_text] [varchar](100) NOT NULL,
   [dqu_order] [int] NOT NULL,
   [NCIt_unit_code] [varchar](10) NULL

   ,CONSTRAINT [PK_drug_quantity_units] PRIMARY KEY NONCLUSTERED ([dqu_id])
)


GO
CREATE TABLE [dbo].[drug_strength_forms] (
   [dsf_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsf_text] [varchar](100) NOT NULL,
   [dsf_order] [int] NOT NULL,
   [NCIt_unit_code] [varchar](10) NULL

   ,CONSTRAINT [PK_drug_strength_forms] PRIMARY KEY NONCLUSTERED ([dsf_id])
)


GO
CREATE TABLE [dbo].[drug_strength_units] (
   [dsu_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsu_text] [varchar](100) NOT NULL,
   [dsu_order] [int] NOT NULL,
   [NCIt_unit_code] [varchar](10) NULL

   ,CONSTRAINT [PK_drug_strength_units] PRIMARY KEY NONCLUSTERED ([dsu_id])
)


GO
CREATE TABLE [dbo].[dr_custom_messages] (
   [dr_cst_msg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_src_id] [int] NOT NULL,
   [dr_dst_id] [int] NOT NULL,
   [msg_date] [datetime] NOT NULL,
   [message] [text] NOT NULL,
   [is_read] [bit] NOT NULL,
   [is_complete] [bit] NULL,
   [patid] [bigint] NULL,
   [message_typeid] [int] NULL,
   [message_subtypeid] [int] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [inbox_delete] [bit] NULL,
   [outbox_delete] [bit] NULL,
   [dr_src_delete_id] [bigint] NULL,
   [dr_dst_delete_id] [bigint] NULL

   ,CONSTRAINT [PK_dr_custom_messages] PRIMARY KEY CLUSTERED ([dr_cst_msg_id])
)

CREATE NONCLUSTERED INDEX [IX_dr_custom_messages-dr_dst_id-is_read-patid-message_typeid-msg_date] ON [dbo].[dr_custom_messages] ([dr_dst_id], [is_read], [patid], [message_typeid], [msg_date])

GO
CREATE TABLE [dbo].[dr_custom_message_subtypes] (
   [subtypeid] [int] NOT NULL,
   [typeid] [int] NOT NULL,
   [name] [varchar](50) NULL

   ,CONSTRAINT [PK_dr_custom_message_subtypes] PRIMARY KEY CLUSTERED ([subtypeid])
)


GO
CREATE TABLE [dbo].[dr_custom_message_types] (
   [typeid] [int] NOT NULL,
   [name] [varchar](50) NULL

   ,CONSTRAINT [PK_dr_custom_message_types] PRIMARY KEY CLUSTERED ([typeid])
)


GO
CREATE TABLE [dbo].[dr_email_alert_rec] (
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NULL,
   [dr_email] [varchar](50) NULL,
   [active] [smallint] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [frequency] [int] NOT NULL,
   [last_process_date] [datetime] NULL

   ,CONSTRAINT [PK_dr_email_alert_rec] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
CREATE TABLE [dbo].[dr_email_update_rec] (
   [dr_id] [int] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [last_refill_mail_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_dr_email_update_rec] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
CREATE TABLE [dbo].[dtproperties] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [objectid] [int] NULL,
   [property] [varchar](64) NOT NULL,
   [value] [varchar](255) NULL,
   [lvalue] [image] NULL,
   [version] [int] NOT NULL,
   [uvalue] [nvarchar](255) NULL

   ,CONSTRAINT [pk_dtproperties] PRIMARY KEY CLUSTERED ([id], [property])
)


GO
CREATE TABLE [ehr].[AccessPreference] (
   [AccessPreferenceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PreferenceCode] [varchar](5) NOT NULL,
   [PreferenceDescription] [varchar](100) NOT NULL,
   [PreferenceDataTypeId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [Module] [varchar](100) NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_AccessPreferenceId] PRIMARY KEY CLUSTERED ([AccessPreferenceId])
)


GO
CREATE TABLE [ehr].[ApplicationConfiguration] (
   [ApplicationConfigurationId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ConfigurationCode] [varchar](5) NOT NULL,
   [ConfigurationDescription] [varchar](100) NOT NULL,
   [ConfigurationValueId] [bigint] NOT NULL,
   [ConfigurationDataTypeId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [ApplicationName] [nchar](10) NULL

   ,CONSTRAINT [AK_ApplicationConfiguration_ConfigurationCode] UNIQUE NONCLUSTERED ([ConfigurationCode])
   ,CONSTRAINT [PK_ApplicationConfigurationId] PRIMARY KEY CLUSTERED ([ApplicationConfigurationId])
)


GO
CREATE TABLE [ehr].[ApplicationTableConstants] (
   [ApplicationTableConstantId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ApplicationTableId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [Description] [varchar](250) NOT NULL,
   [SortOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ApplicationTableConstants] PRIMARY KEY CLUSTERED ([ApplicationTableConstantId])
)


GO
CREATE TABLE [ehr].[ApplicationTables] (
   [ApplicationTableId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](250) NOT NULL,
   [Description] [varchar](500) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ApplicationTables] PRIMARY KEY CLUSTERED ([ApplicationTableId])
)


GO
CREATE TABLE [ehr].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_ehr_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_ehr_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [ehr].[CompanyAccessPreference] (
   [CompanyAccessPreferenceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [AccessPreferenceId] [bigint] NOT NULL,
   [PreferenceValueId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_CompanyAccessPreferenceId] PRIMARY KEY CLUSTERED ([CompanyAccessPreferenceId])
)


GO
CREATE TABLE [ehr].[CompanyApplicationConfiguration] (
   [CompanyApplicationConfigurationId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [ApplicationConfigurationId] [bigint] NOT NULL,
   [ConfigurationValueId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_CompanyApplicationConfigurationId] PRIMARY KEY CLUSTERED ([CompanyApplicationConfigurationId])
)


GO
CREATE TABLE [ehr].[DoctorManageCCDViewPreferences] (
   [DoctorManageCCDViewPreferenceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ManageCCDViewDataId] [bigint] NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [IsViewable] [bit] NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorManageCCDViewPreferences] PRIMARY KEY CLUSTERED ([DoctorManageCCDViewPreferenceId])
)


GO
CREATE TABLE [ehr].[ImplantableDevice] (
   [ImplantableDeviceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DeviceId] [varchar](50) NULL,
   [DeviceIdIssuingAgency] [varchar](200) NULL,
   [BrandName] [varchar](200) NOT NULL,
   [CompanyName] [varchar](200) NULL,
   [VersionModelNumber] [varchar](200) NULL,
   [MRISafetyStatus] [varchar](500) NULL,
   [LabeledContainsNRL] [varchar](200) NULL,
   [DeviceRecordStatus] [varchar](200) NULL,
   [CreationDate] [varchar](200) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ImplantableDevice] PRIMARY KEY CLUSTERED ([ImplantableDeviceId])
)


GO
CREATE TABLE [ehr].[ImplantableDeviceGmdnPTName] (
   [PatientImplantableGmdnPTNameId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ImplantableDeviceId] [bigint] NOT NULL,
   [GmdnPTName] [varchar](200) NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ImplantableDeviceGmdnPTName] PRIMARY KEY CLUSTERED ([PatientImplantableGmdnPTNameId])
)


GO
CREATE TABLE [ehr].[PatientEthnicityLookUpTable] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [PARENT_ETHNICITY_ID] [varchar](20) NOT NULL,
   [ETHNICITY_ID] [varchar](20) NOT NULL

   ,CONSTRAINT [PK__PatientE__3214EC271A769EC0] PRIMARY KEY CLUSTERED ([ID])
)


GO
CREATE TABLE [ehr].[PatientImplantableDevice] (
   [PatientImplantableDeviceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [ImplantableDeviceId] [bigint] NOT NULL,
   [BatchNumber] [varchar](200) NULL,
   [LotNumber] [varchar](200) NULL,
   [SerialNumber] [varchar](200) NULL,
   [ManufacturedDate] [datetime2] NULL,
   [ExpirationDate] [datetime2] NULL,
   [CreatedOn] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [Source] [varchar](100) NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientImplantableDevice] PRIMARY KEY CLUSTERED ([PatientImplantableDeviceId])
)


GO
CREATE TABLE [ehr].[PatientImplantableDeviceExternal] (
   [PatientImplantableDeviceExtId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [ImplantableDeviceId] [bigint] NOT NULL,
   [BatchNumber] [varchar](200) NULL,
   [LotNumber] [varchar](200) NULL,
   [SerialNumber] [varchar](200) NULL,
   [Source] [varchar](100) NULL,
   [ManufacturedDate] [datetime2] NULL,
   [ExpirationDate] [datetime2] NULL,
   [CreatedOn] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PatientImplantableDeviceExternal] PRIMARY KEY CLUSTERED ([PatientImplantableDeviceExtId])
)


GO
CREATE TABLE [ehr].[PatientPastHxAllergies] (
   [PatientPastHxAllergyId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [AllergyId] [bigint] NULL,
   [AllergyType] [bigint] NULL,
   [AllergyDescription] [varchar](500) NULL,
   [RecordSource] [varchar](500) NULL,
   [SourceType] [varchar](3) NULL,
   [Comments] [varchar](2000) NULL,
   [Reaction] [varchar](200) NULL,
   [CreatedOn] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [rxnorm_code] [varchar](15) NULL,
   [reaction_snomed] [varchar](15) NULL,
   [allergy_snomed] [varchar](15) NULL,
   [snomed_term] [varchar](500) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_PatientPastHxAllergies] PRIMARY KEY CLUSTERED ([PatientPastHxAllergyId])
)


GO
CREATE TABLE [ehr].[PatientPastHxAllergiesExternal] (
   [PatientPastHxAllergyExtId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [AllergyId] [bigint] NULL,
   [AllergyType] [bigint] NULL,
   [AllergyDescription] [varchar](500) NULL,
   [RecordSource] [varchar](500) NULL,
   [SourceType] [varchar](3) NULL,
   [Comments] [varchar](2000) NULL,
   [Reaction] [varchar](200) NULL,
   [CreatedOn] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [rxnorm_code] [varchar](15) NULL,
   [reaction_snomed] [varchar](15) NULL,
   [allergy_snomed] [varchar](15) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_PatientPastHxAllergiesExternal] PRIMARY KEY CLUSTERED ([PatientPastHxAllergyExtId])
)


GO
CREATE TABLE [ehr].[PatientPastHxMedication] (
   [PatientPastHxMedicationId] [int] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [DrugId] [bigint] NOT NULL,
   [Comments] [varchar](255) NULL,
   [Reason] [varchar](150) NULL,
   [DrugName] [varchar](200) NULL,
   [Dosage] [varchar](255) NULL,
   [DurationAmount] [varchar](15) NULL,
   [DurationUnit] [varchar](80) NULL,
   [DrugComments] [varchar](255) NULL,
   [UseGeneric] [int] NULL,
   [DaysSupply] [smallint] NULL,
   [PrescriptionDetailId] [bigint] NULL,
   [Prn] [bit] NULL,
   [PrnDescription] [varchar](50) NULL,
   [DateStart] [datetime] NULL,
   [DateEnd] [datetime] NULL,
   [SourceType] [varchar](3) NULL,
   [RecordSource] [varchar](500) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [numb_refills] [int] NULL,
   [RxNormCode] [varchar](20) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds] PRIMARY KEY CLUSTERED ([PatientPastHxMedicationId])
)


GO
CREATE TABLE [ehr].[PatientPastHxMedicationExternal] (
   [PatientPastHxMedicationExtId] [int] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [DrugId] [bigint] NOT NULL,
   [Comments] [varchar](255) NULL,
   [Reason] [varchar](150) NULL,
   [DrugName] [varchar](200) NULL,
   [Dosage] [varchar](255) NULL,
   [DurationAmount] [varchar](15) NULL,
   [DurationUnit] [varchar](80) NULL,
   [DrugComments] [varchar](255) NULL,
   [UseGeneric] [int] NULL,
   [DaysSupply] [smallint] NULL,
   [PrescriptionDetailId] [bigint] NULL,
   [Prn] [bit] NULL,
   [PrnDescription] [varchar](50) NULL,
   [DateStart] [datetime] NULL,
   [DateEnd] [datetime] NULL,
   [SourceType] [varchar](3) NULL,
   [RecordSource] [varchar](500) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [numb_refills] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds_external] PRIMARY KEY CLUSTERED ([PatientPastHxMedicationExtId])
)


GO
CREATE TABLE [ehr].[PatientRaceLookUpTable] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [PARENT_RACE_ID] [varchar](20) NOT NULL,
   [RACE_ID] [varchar](20) NOT NULL

   ,CONSTRAINT [PK__PatientR__3214EC2714BDC56A] PRIMARY KEY CLUSTERED ([ID])
)


GO
CREATE TABLE [ehr].[PatientSmokingStatusDetail] (
   [PatientSmokingStatusDetailId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Pa_Flag_Id] [bigint] NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [StartDate] [datetime2] NULL,
   [EndDate] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PatientSmokingStatusDetail] PRIMARY KEY CLUSTERED ([PatientSmokingStatusDetailId])
)


GO
CREATE TABLE [ehr].[PatientSmokingStatusDetailExternal] (
   [PatientSmokingStatusDetailExtId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Pa_Flag_Id] [bigint] NOT NULL,
   [SmokingStatusCode] [varchar](50) NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [StartDate] [datetime2] NULL,
   [EndDate] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PatientSmokingStatusDetailExternal] PRIMARY KEY CLUSTERED ([PatientSmokingStatusDetailExtId])
)


GO
CREATE TABLE [ehr].[SysLookupCodes] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystemId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NOT NULL,
   [Active] [bit] NOT NULL,
   [ApplicationTableConstantCode] [varchar](200) NULL,
   [ApplicationTableConstantId] [bigint] NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C155805C432] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
CREATE TABLE [ehr].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystem] [varchar](200) NOT NULL,
   [Active] [bit] NOT NULL,
   [ApplicationTableCode] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A85158C6A3] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
CREATE TABLE [enc].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_enc_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_enc_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [enc].[EncounterNoteType] (
   [Id] [int] NOT NULL,
   [Code] [varchar](10) NOT NULL,
   [Name] [varchar](50) NOT NULL,
   [LOINC] [varchar](10) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_enc_EncounterNoteType] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[enchanced_encounter] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](500) NULL,
   [type_of_visit] [char](10) NULL,
   [clinical_summary_first_date] [datetime] NULL,
   [active] [bit] NULL,
   [encounter_version] [varchar](10) NULL,
   [is_released] [bit] NULL,
   [external_encounter_id] [varchar](250) NULL,
   [is_amended] [bit] NULL,
   [enc_name] [nvarchar](1024) NULL,
   [is_multisignature] [bit] NOT NULL,
   [is_inreview] [bit] NOT NULL,
   [smart_form_id] [varchar](50) NULL,
   [InformationBlockingReasonId] [int] NULL,
   [EncounterNoteTypeId] [int] NULL,
   [EncounterReasonSnomedCode] [varchar](10) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_enchanced_encounter] PRIMARY KEY CLUSTERED ([enc_id])
)

CREATE NONCLUSTERED INDEX [IX_enchanced_encounter] ON [dbo].[enchanced_encounter] ([dr_id], [enc_date] DESC, [patient_id], [added_by_dr_id])
CREATE NONCLUSTERED INDEX [ix_enchanced_encounter_dr_id_issigned_includes] ON [dbo].[enchanced_encounter] ([dr_id], [issigned]) INCLUDE ([added_by_dr_id], [chief_complaint], [enc_date], [enc_id], [last_modified_by], [patient_id], [type])
CREATE NONCLUSTERED INDEX [IX_enchanced_encounter-patient_id] ON [dbo].[enchanced_encounter] ([patient_id])

GO
CREATE TABLE [dbo].[enchanced_encounter_additional_info] (
   [enc_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [JSON] [nvarchar](max) NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](50) NULL,
   [type_of_visit] [char](5) NULL,
   [clinical_summary_first_date] [datetime] NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_enchanced_encounter_additional_info] PRIMARY KEY CLUSTERED ([enc_info_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [encounteridunique] ON [dbo].[enchanced_encounter_additional_info] ([enc_id])
CREATE NONCLUSTERED INDEX [IDX_enchanced_encounter_additional_info_patient_id] ON [dbo].[enchanced_encounter_additional_info] ([patient_id])

GO
CREATE TABLE [dbo].[enchanced_encounter_info] (
   [enc_id] [bigint] NULL,
   [pa_id] [bigint] NULL,
   [enc_date] [datetime] NULL,
   [dr_id] [bigint] NULL,
   [has_preview_and_save] [bit] NULL,
   [no_of_tabs] [int] NULL,
   [logged_date] [datetime] NULL,
   [logged_by] [bigint] NULL
)


GO
CREATE TABLE [dbo].[enchanced_encounter_log] (
   [transaction_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [enc_id] [bigint] NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [patient_id] [bigint] NOT NULL,
   [enc_xml] [ntext] NULL,
   [enc_json] [nvarchar](max) NULL,
   [created_on] [datetime] NULL,
   [created_by] [bigint] NULL,
   [enc_date] [datetime] NULL,
   [action_dr_id] [bigint] NULL,
   [action_id] [bigint] NULL,
   [action_date] [datetime] NULL,
   [comments] [varchar](100) NULL,
   [external_encounter_id] [varchar](250) NULL,
   [is_signed] [bit] NULL,
   [smart_form_id] [varchar](50) NULL

   ,CONSTRAINT [PK_enchanced_encounter_log] PRIMARY KEY CLUSTERED ([transaction_id])
)


GO
CREATE TABLE [dbo].[enchanced_encounter_new] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [xml] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_enchanced_encounter1] PRIMARY KEY CLUSTERED ([enc_id])
)

CREATE NONCLUSTERED INDEX [IX_enchanced_encounter] ON [dbo].[enchanced_encounter_new] ([dr_id], [enc_date] DESC, [patient_id], [added_by_dr_id])
CREATE NONCLUSTERED INDEX [IX_enchanced_encounter-patient_id] ON [dbo].[enchanced_encounter_new] ([patient_id])

GO
CREATE TABLE [dbo].[enchanced_encounter_templates] (
   [enc_tmpl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [enc_name] [varchar](75) NOT NULL,
   [enc_json] [nvarchar](max) NULL

   ,CONSTRAINT [PK_enchanced_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
CREATE TABLE [dbo].[encounter_datasets] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [displayName] [varchar](500) NOT NULL,
   [enable] [bit] NULL

   ,CONSTRAINT [PK_encounter_datasets] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[encounter_form_settings] (
   [enc_type_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [type] [varchar](125) NOT NULL,
   [date_added] [smalldatetime] NOT NULL,
   [name] [varchar](125) NOT NULL,
   [sort_order] [int] NULL

   ,CONSTRAINT [PK_encounter_form_settings] PRIMARY KEY CLUSTERED ([enc_type_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_UNIQUE] ON [dbo].[encounter_form_settings] ([dr_id], [type])

GO
CREATE TABLE [dbo].[encounter_model_definitions] (
   [model_defn_id] [int] NOT NULL
      IDENTITY (1,1),
   [type] [varchar](225) NOT NULL,
   [definition] [xml] NULL,
   [json_definition] [nvarchar](max) NULL,
   [json_modified] [bit] NULL

   ,CONSTRAINT [PK_encounter_model_definitions] PRIMARY KEY CLUSTERED ([model_defn_id])
)


GO
CREATE TABLE [dbo].[encounter_smart_form_settings] (
   [smart_form_set_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [form_id] [varchar](125) NOT NULL,
   [form_name] [varchar](500) NOT NULL,
   [date_added] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_encounter_smart_form_settings] PRIMARY KEY CLUSTERED ([smart_form_set_id])
)


GO
CREATE TABLE [dbo].[encounter_templates] (
   [enc_tmpl_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [enc_type_id] [int] NOT NULL,
   [enc_name] [varchar](75) NULL,
   [enc_text] [ntext] NULL,
   [enc_json] [varchar](max) NULL

   ,CONSTRAINT [PK_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
CREATE TABLE [dbo].[encounter_types] (
   [enc_lst_id] [int] NOT NULL,
   [enc_name] [varchar](125) NOT NULL,
   [enc_type] [varchar](125) NOT NULL,
   [speciality] [varchar](125) NOT NULL,
   [encounter_version] [varchar](10) NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_encounter_types] PRIMARY KEY CLUSTERED ([enc_lst_id])
)


GO
CREATE TABLE [dbo].[encounter_visit_types] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [code] [char](10) NOT NULL,
   [description] [nvarchar](500) NULL,
   [enable] [bit] NOT NULL

   ,CONSTRAINT [PK_encounter_visit_types] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[Envoii_Client] (
   [GUID] [uniqueidentifier] NOT NULL,
   [Name] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_Envoii_Client] PRIMARY KEY CLUSTERED ([GUID])
)


GO
CREATE TABLE [dbo].[Envoii_User_Client] (
   [Envoii_GUID] [uniqueidentifier] NOT NULL,
   [DrId] [int] NOT NULL

   ,CONSTRAINT [PK_Envoii_User_Client] PRIMARY KEY CLUSTERED ([Envoii_GUID])
)


GO
CREATE TABLE [epa].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_epa_AppLoginTokens] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_epa_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [epa].[epa_token_log] (
   [epa_token_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [provider_spi] [varchar](100) NOT NULL,
   [end_user_id] [int] NOT NULL,
   [pa_auth_request_json] [varchar](max) NOT NULL,
   [pa_auth_response_json] [varchar](max) NULL,
   [pa_auth_api_response_json] [varchar](max) NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL

   ,CONSTRAINT [PK_epa_token_log] PRIMARY KEY CLUSTERED ([epa_token_log_id])
)


GO
CREATE TABLE [epa].[epa_transaction_log] (
   [epa_transaction_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [pa_reference_id] [varchar](100) NOT NULL,
   [epa_response_status_code] [varchar](10) NULL,
   [epa_response_description_code] [varchar](10) NULL,
   [epa_response_description] [varchar](1000) NULL,
   [pa_init_request_xml] [varchar](max) NOT NULL,
   [pa_init_request_json] [varchar](max) NOT NULL,
   [pa_init_response_xml] [varchar](max) NULL,
   [pa_init_api_response_json] [varchar](max) NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL

   ,CONSTRAINT [PK_epa_transaction_log] PRIMARY KEY CLUSTERED ([epa_transaction_log_id])
)


GO
CREATE TABLE [dbo].[epcs_state_map] (
   [state] [varchar](2) NOT NULL,
   [min_drug_schedule] [tinyint] NOT NULL

   ,CONSTRAINT [PK_epcs_state_map] PRIMARY KEY CLUSTERED ([state])
)


GO
CREATE TABLE [dbo].[ErrorNotificationConfig] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [Severity] [varchar](100) NOT NULL,
   [EnableEmailLog] [varchar](1) NOT NULL
)


GO
CREATE TABLE [dbo].[Error_Log] (
   [err_id] [int] NOT NULL
      IDENTITY (1,1),
   [error_code] [int] NOT NULL,
   [error_desc] [varchar](1024) NULL,
   [error_time] [smalldatetime] NOT NULL,
   [application] [varchar](50) NOT NULL,
   [method] [varchar](255) NULL,
   [COMMENTS] [text] NULL

   ,CONSTRAINT [PK_Error_Log] PRIMARY KEY CLUSTERED ([err_id])
)


GO
CREATE TABLE [erx].[RxChangeRequests] (
   [ChgReqId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorGroupId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [RequestDate] [datetime] NOT NULL,
   [PrescriberOrderNumber] [varchar](100) NULL,
   [MessageId] [varchar](100) NULL,
   [PresId] [int] NULL,
   [ChgType] [int] NULL,
   [InitDate] [datetime] NULL,
   [MsgDate] [datetime] NULL,
   [Status] [varchar](max) NULL,
   [DeliveryMethod] [bigint] NULL,
   [DocInfoText] [varchar](5000) NULL,
   [HasMissMatch] [bit] NULL,
   [MissMatchReason] [varchar](max) NULL,
   [DrugName] [varchar](125) NULL,
   [DrugNDC] [varchar](11) NULL,
   [DrugForm] [varchar](3) NULL,
   [DrugStrength] [varchar](70) NULL,
   [DrugStrengthUnits] [varchar](3) NULL,
   [Qty1] [varchar](35) NULL,
   [Qty1Units] [varchar](50) NULL,
   [Qty1Enum] [tinyint] NULL,
   [Qty2] [varchar](35) NULL,
   [Qty2Units] [varchar](50) NULL,
   [Qty2Enum] [tinyint] NULL,
   [Dosage1] [varchar](1000) NULL,
   [Dosage2] [varchar](70) NULL,
   [DaysSupply] [int] NULL,
   [Date1] [smalldatetime] NULL,
   [Date1Enum] [tinyint] NULL,
   [Date2] [smalldatetime] NULL,
   [Date2Enum] [tinyint] NULL,
   [Date3] [smalldatetime] NULL,
   [Date3Enum] [tinyint] NULL,
   [SubstitutionCode] [tinyint] NULL,
   [VoidComments] [varchar](255) NULL,
   [VoidCode] [smallint] NULL,
   [Comments1] [varchar](210) NULL,
   [Comments2] [varchar](70) NULL,
   [Comments3] [varchar](70) NULL,
   [DrugStrengthCode] [varchar](15) NULL,
   [DrugStrengthSourceCode] [varchar](3) NULL,
   [DrugFormCode] [varchar](15) NULL,
   [DrugFormSourceCode] [varchar](3) NULL,
   [Qty1UnitsPotencyCode] [varchar](15) NULL,
   [Qty2UnitsPotencyCode] [varchar](15) NULL,
   [DispDrugInfo] [bit] NULL,
   [Refills] [varchar](35) NULL,
   [RefillsType] [tinyint] NULL,
   [PharmSeg] [varchar](7999) NULL,
   [DoctorSeg] [varchar](7999) NULL,
   [SupervisorSeg] [varchar](7999) NULL,
   [PatientSeg] [varchar](5000) NULL,
   [ReqDrug] [varchar](max) NULL,
   [PrescDrug] [varchar](max) NULL,
   [FullReqMessage] [xml] NULL,
   [ResponseType] [int] NULL,
   [RequestSeg] [varchar](max) NULL,
   [PriorAuthNum] [varchar](100) NULL,
   [IsApproved] [bit] NULL,
   [IsVoided] [bit] NULL,
   [pharm_id] [int] NULL,
   [pharm_ncpdp] [varchar](15) NULL,
   [recverVector] [varchar](50) NULL,
   [senderVector] [varchar](50) NULL,
   [versionType] [varchar](5) NULL,
   [msg_ref_number] [varchar](35) NULL,
   [NoOfMedicationsRequested] [int] NULL,
   [ApprovedChgReqInfoId] [bigint] NULL

   ,CONSTRAINT [PK_RxChangeRequests] PRIMARY KEY CLUSTERED ([ChgReqId])
)


GO
CREATE TABLE [erx].[RxChangeRequestsInfo] (
   [ChgReqInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ChgReqId] [int] NOT NULL,
   [Type] [varchar](7) NOT NULL,
   [DrugName] [varchar](125) NULL,
   [DrugNDC] [varchar](11) NULL,
   [DrugForm] [varchar](3) NULL,
   [DrugStrength] [varchar](70) NULL,
   [DrugStrengthUnits] [varchar](3) NULL,
   [Qty1] [varchar](35) NULL,
   [Qty1Units] [varchar](50) NULL,
   [Qty1Enum] [tinyint] NULL,
   [Qty2] [varchar](35) NULL,
   [Qty2Units] [varchar](50) NULL,
   [Qty2Enum] [tinyint] NULL,
   [Dosage1] [varchar](1000) NULL,
   [Dosage2] [varchar](70) NULL,
   [DaysSupply] [int] NULL,
   [Date1] [smalldatetime] NULL,
   [Date1Enum] [tinyint] NULL,
   [Date2] [smalldatetime] NULL,
   [Date2Enum] [tinyint] NULL,
   [Date3] [smalldatetime] NULL,
   [Date3Enum] [tinyint] NULL,
   [SubstitutionCode] [tinyint] NULL,
   [VoidComments] [varchar](255) NULL,
   [VoidCode] [smallint] NULL,
   [Comments1] [varchar](210) NULL,
   [Comments2] [varchar](70) NULL,
   [Comments3] [varchar](70) NULL,
   [DrugStrengthCode] [varchar](15) NULL,
   [DrugStrengthSourceCode] [varchar](3) NULL,
   [DrugFormCode] [varchar](15) NULL,
   [DrugFormSourceCode] [varchar](3) NULL,
   [Qty1UnitsPotencyCode] [varchar](15) NULL,
   [Qty2UnitsPotencyCode] [varchar](15) NULL,
   [DocInfoText] [varchar](5000) NULL,
   [Refills] [varchar](35) NULL,
   [RefillsType] [tinyint] NULL,
   [Qty1UnitCode] [varchar](10) NULL,
   [RequestSeg] [varchar](max) NULL

   ,CONSTRAINT [PK_RxChangeRequestsInfo] PRIMARY KEY CLUSTERED ([ChgReqInfoId])
)


GO
CREATE TABLE [erx].[RxChangeVoidTransmittals] (
   [ChgVoidId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ChgReqId] [int] NOT NULL,
   [Type] [tinyint] NULL,
   [PresId] [bigint] NULL,
   [PdId] [bigint] NULL,
   [DeliveryMethod] [bigint] NULL,
   [SendDate] [datetime] NULL,
   [QueuedDate] [datetime] NULL,
   [ResponseDate] [datetime] NULL,
   [ResponseType] [tinyint] NULL,
   [ResponseText] [varchar](250) NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_RxChangeVoidTransmittals] PRIMARY KEY CLUSTERED ([ChgVoidId])
)


GO
CREATE TABLE [erx].[RxFillRequests] (
   [FillReqId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorGroupId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [RequestDate] [datetime] NOT NULL,
   [PrescriberOrderNumber] [varchar](100) NULL,
   [MessageId] [varchar](100) NULL,
   [PresId] [int] NULL,
   [InitDate] [datetime] NULL,
   [MsgDate] [datetime] NULL,
   [FillStatus] [varchar](max) NULL,
   [FillStatusType] [int] NULL,
   [DeliveryMethod] [bigint] NULL,
   [DocInfoText] [varchar](5000) NULL,
   [HasMissMatch] [bit] NULL,
   [MissMatchReason] [varchar](max) NULL,
   [DrugName] [varchar](125) NULL,
   [DrugNDC] [varchar](11) NULL,
   [DrugForm] [varchar](3) NULL,
   [DrugStrength] [varchar](70) NULL,
   [DrugStrengthUnits] [varchar](3) NULL,
   [Qty1] [varchar](35) NULL,
   [Qty1Units] [varchar](50) NULL,
   [Qty1Enum] [tinyint] NULL,
   [Qty2] [varchar](35) NULL,
   [Qty2Units] [varchar](50) NULL,
   [Qty2Enum] [tinyint] NULL,
   [Dosage1] [varchar](140) NULL,
   [Dosage2] [varchar](70) NULL,
   [DaysSupply] [int] NULL,
   [Date1] [smalldatetime] NULL,
   [Date1Enum] [tinyint] NULL,
   [Date2] [smalldatetime] NULL,
   [Date2Enum] [tinyint] NULL,
   [Date3] [smalldatetime] NULL,
   [Date3Enum] [tinyint] NULL,
   [SubstitutionCode] [tinyint] NULL,
   [VoidComments] [varchar](255) NULL,
   [VoidCode] [smallint] NULL,
   [Comments1] [varchar](210) NULL,
   [Comments2] [varchar](70) NULL,
   [Comments3] [varchar](70) NULL,
   [DrugStrengthCode] [varchar](15) NULL,
   [DrugStrengthSourceCode] [varchar](3) NULL,
   [DrugFormCode] [varchar](15) NULL,
   [DrugFormSourceCode] [varchar](3) NULL,
   [Qty1UnitsPotencyCode] [varchar](15) NULL,
   [Qty2UnitsPotencyCode] [varchar](15) NULL,
   [DispDrugInfo] [bit] NULL,
   [Refills] [varchar](35) NULL,
   [RefillsType] [tinyint] NULL,
   [FullReqMessage] [xml] NULL,
   [ResponseType] [int] NULL,
   [PharmId] [bigint] NULL,
   [Reason] [varchar](250) NULL,
   [Note] [varchar](max) NULL

   ,CONSTRAINT [PK_RxFillRequests] PRIMARY KEY CLUSTERED ([FillReqId])
)


GO
CREATE TABLE [erx].[RxFillRequestsInfo] (
   [FillReqInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [FillReqId] [int] NOT NULL,
   [Type] [varchar](7) NOT NULL,
   [DrugName] [varchar](125) NULL,
   [DrugNDC] [varchar](11) NULL,
   [DrugForm] [varchar](3) NULL,
   [DrugStrength] [varchar](70) NULL,
   [DrugStrengthUnits] [varchar](3) NULL,
   [Qty1] [varchar](35) NULL,
   [Qty1Units] [varchar](50) NULL,
   [Qty1Enum] [tinyint] NULL,
   [Qty2] [varchar](35) NULL,
   [Qty2Units] [varchar](50) NULL,
   [Qty2Enum] [tinyint] NULL,
   [Dosage1] [varchar](140) NULL,
   [Dosage2] [varchar](70) NULL,
   [DaysSupply] [int] NULL,
   [Date1] [smalldatetime] NULL,
   [Date1Enum] [tinyint] NULL,
   [Date2] [smalldatetime] NULL,
   [Date2Enum] [tinyint] NULL,
   [Date3] [smalldatetime] NULL,
   [Date3Enum] [tinyint] NULL,
   [SubstitutionCode] [tinyint] NULL,
   [VoidComments] [varchar](255) NULL,
   [VoidCode] [smallint] NULL,
   [Comments1] [varchar](210) NULL,
   [Comments2] [varchar](70) NULL,
   [Comments3] [varchar](70) NULL,
   [DrugStrengthCode] [varchar](15) NULL,
   [DrugStrengthSourceCode] [varchar](3) NULL,
   [DrugFormCode] [varchar](15) NULL,
   [DrugFormSourceCode] [varchar](3) NULL,
   [Qty1UnitsPotencyCode] [varchar](15) NULL,
   [Qty2UnitsPotencyCode] [varchar](15) NULL,
   [DocInfoText] [varchar](5000) NULL,
   [Refills] [varchar](35) NULL,
   [RefillsType] [tinyint] NULL,
   [PharmId] [bigint] NULL,
   [FullReqMessage] [xml] NULL

   ,CONSTRAINT [PK_RxFillRequestsInfo] PRIMARY KEY CLUSTERED ([FillReqInfoId])
)


GO
CREATE TABLE [erx].[RxTransmittalMessages] (
   [RtmId] [bigint] NOT NULL
      IDENTITY (1,1),
   [RxType] [int] NULL,
   [DoctorId] [bigint] NULL,
   [PatientId] [bigint] NULL,
   [RequestId] [varchar](50) NULL,
   [ResponseId] [varchar](50) NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [RequestMessage] [xml] NULL,
   [ResponseMessage] [xml] NULL,
   [CreatedDate] [date] NOT NULL,
   [DeliveryMethod] [bigint] NULL

   ,CONSTRAINT [PK_RxTransmittalMessages] PRIMARY KEY CLUSTERED ([RtmId])
)


GO
CREATE TABLE [dbo].[erx_patients] (
   [erx_pa_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NOT NULL,
   [pa_sex] [char](1) NOT NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [pa_ext] [varchar](10) NULL,
   [pa_email] [varchar](50) NULL,
   [ins_code] [varchar](20) NULL

   ,CONSTRAINT [PK_erx_patients] PRIMARY KEY CLUSTERED ([erx_pa_id])
)


GO
CREATE TABLE [dbo].[erx_senders] (
   [sender_id] [int] NOT NULL,
   [sender_name] [varchar](80) NOT NULL,
   [sender_website] [varchar](255) NULL,
   [sender_url] [varchar](255) NOT NULL,
   [plan_code] [varchar](20) NOT NULL,
   [generate_tracking_numb] [bit] NOT NULL,
   [account_number] [varchar](6) NULL

   ,CONSTRAINT [PK_erx_senders] PRIMARY KEY CLUSTERED ([sender_id])
)


GO
CREATE TABLE [dbo].[event_generated_prescriptions] (
   [egp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [parent_pd_id] [int] NOT NULL,
   [fire_date] [datetime] NOT NULL,
   [se_id] [int] NOT NULL

   ,CONSTRAINT [PK_event_generated_prescriptions] PRIMARY KEY CLUSTERED ([egp_id])
)


GO
CREATE TABLE [ext].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_ext_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_ext_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [dbo].[ExternalWebRequestLogs] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [RequestUrl] [varchar](100) NOT NULL,
   [ReferralUrl] [varchar](100) NULL,
   [CreatedOn] [datetime] NOT NULL,
   [dc_id] [bigint] NOT NULL,
   [dr_id] [int] NULL

   ,CONSTRAINT [PK_ExternalWebRequestLogs] PRIMARY KEY CLUSTERED ([RequestId])
)


GO
CREATE TABLE [dbo].[fav_patients] (
   [dfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [update_code] [int] NOT NULL,
   [notes_update_code] [int] NOT NULL,
   [drugs_update_code] [int] NOT NULL,
   [pharm_update_code] [int] NOT NULL

   ,CONSTRAINT [PK_fav_patients] PRIMARY KEY NONCLUSTERED ([dfp_id])
)

CREATE CLUSTERED INDEX [fav_patients1] ON [dbo].[fav_patients] ([pa_id])
CREATE NONCLUSTERED INDEX [fav_patients3] ON [dbo].[fav_patients] ([dr_id], [pa_id], [update_code])

GO
CREATE TABLE [fhir].[authorization_tokens] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [relates_to_message_id] [varchar](30) NULL,
   [authorization_token] [varchar](200) NULL,
   [response] [varchar](2000) NULL,
   [created_on] [datetime] NULL,
   [expires_on] [datetime] NULL

   ,CONSTRAINT [PK_authorization_tokens] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[FileInfo] (
   [FileId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Name] [varchar](100) NULL,
   [Base64Content] [varchar](max) NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastModifiedBy] [bigint] NULL,
   [LastModifiedOn] [datetime] NULL

   ,CONSTRAINT [PK_FileInfo] PRIMARY KEY CLUSTERED ([FileId])
)


GO
CREATE TABLE [dbo].[formulary_drug_change_log] (
   [fm_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [orig_drug_id] [int] NOT NULL,
   [new_drug_id] [int] NOT NULL,
   [new_drug_form_stat] [int] NOT NULL,
   [date] [datetime] NOT NULL,
   [pa_id] [int] NOT NULL,
   [orig_drug_form_stat] [int] NOT NULL

   ,CONSTRAINT [PK_formulary_drug_change_log] PRIMARY KEY CLUSTERED ([fm_log_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_formulary_drug_change_log_7_359060415__K6_K2_3_4] ON [dbo].[formulary_drug_change_log] ([date], [dr_id]) INCLUDE ([orig_drug_id], [new_drug_id])

GO
CREATE TABLE [dbo].[form_cross_reference] (
   [fcr_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [formulary_id] [varchar](10) NOT NULL,
   [formulary_name] [varchar](35) NULL,
   [otc_default] [int] NULL,
   [generic_default] [int] NULL,
   [nonlist_brand] [int] NULL,
   [nonlist_generic] [int] NULL,
   [rel_value_limit] [int] NOT NULL

   ,CONSTRAINT [PK_form_cross_reference] PRIMARY KEY CLUSTERED ([fcr_id])
)


GO
CREATE TABLE [dbo].[form_fill_options] (
   [dg_id] [int] NOT NULL,
   [type] [smallint] NOT NULL,
   [value] [varchar](512) NOT NULL,
   [sort_order] [int] NOT NULL,
   [form_fill_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_form_fill_options] PRIMARY KEY CLUSTERED ([form_fill_id])
)

CREATE NONCLUSTERED INDEX [IX_form_fill_options] ON [dbo].[form_fill_options] ([dg_id], [type])

GO
CREATE TABLE [dbo].[form_reference] (
   [ref_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [plan_numb] [varchar](15) NULL,
   [plan_name] [varchar](35) NOT NULL,
   [grp_numb] [varchar](15) NULL,
   [grp_name] [varchar](35) NULL,
   [formulary_id] [varchar](10) NOT NULL,
   [alternative_id] [varchar](10) NULL

   ,CONSTRAINT [PK_form_reference] PRIMARY KEY CLUSTERED ([ref_id])
)


GO
CREATE TABLE [dbo].[FreeSample] (
   [SampleId] [int] NOT NULL,
   [DrugName] [varchar](80) NOT NULL,
   [DrugId] [int] NOT NULL,
   [DrugNameMatchType] [smallint] NOT NULL,
   [StartDate] [datetime] NOT NULL,
   [EndDate] [datetime] NOT NULL,
   [filename_1] [varchar](100) NULL,
   [filename_2] [varchar](100) NULL,
   [xref_tbname] [varchar](125) NULL,
   [ptype] [smallint] NOT NULL

   ,CONSTRAINT [PK__FreeSample__53A33203] PRIMARY KEY CLUSTERED ([SampleId])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[FreeSample] ([DrugName], [DrugId], [DrugNameMatchType], [StartDate], [EndDate])

GO
CREATE TABLE [dbo].[FreeSample_Breeze2_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleIdXref] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_Breeze2_ids] PRIMARY KEY CLUSTERED ([ID])
)


GO
CREATE TABLE [dbo].[FreeSample_byetta_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleId] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_byetta_ids] PRIMARY KEY CLUSTERED ([ID])
)

CREATE NONCLUSTERED INDEX [IX_FreeSample_byetta_ids] ON [dbo].[FreeSample_byetta_ids] ([is_valid])

GO
CREATE TABLE [dbo].[FreeSample_Contour_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleIdXref] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_Contour_ids] PRIMARY KEY CLUSTERED ([ID])
)


GO
CREATE TABLE [dbo].[FreeSample_Lipofen_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleId] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_Lipofen_ids] PRIMARY KEY CLUSTERED ([ID])
)


GO
CREATE TABLE [dbo].[FreeSample_restasis_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleIdXref] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_restasis_ids] PRIMARY KEY NONCLUSTERED ([ID])
)


GO
CREATE TABLE [dbo].[FreeSample_trutrack_ids] (
   [ID] [varchar](100) NOT NULL,
   [is_valid] [bit] NULL,
   [SampleIdXref] [int] NOT NULL

   ,CONSTRAINT [PK_FreeSample_trutrack_ids] PRIMARY KEY NONCLUSTERED ([ID])
)

CREATE CLUSTERED INDEX [IX_MAIN] ON [dbo].[FreeSample_trutrack_ids] ([ID], [is_valid])

GO
CREATE TABLE [dbo].[gender_identity_snomed] (
   [gender_identity_snomed_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_gender_identity_id] [int] NOT NULL,
   [pa_gender_identity] [varchar](25) NULL,
   [snomed_code] [varchar](25) NULL,
   [is_null_flavour] [bit] NULL

   ,CONSTRAINT [PK_patient_menu] PRIMARY KEY CLUSTERED ([gender_identity_snomed_id])
)


GO
CREATE TABLE [dbo].[GeoIPCountryWhois] (
   [IPStart] [varchar](50) NOT NULL,
   [IPEnd] [varchar](50) NOT NULL,
   [IntStart] [bigint] NOT NULL,
   [IntEnd] [bigint] NOT NULL,
   [CountryCode] [varchar](50) NOT NULL,
   [CountryName] [varchar](50) NOT NULL
)


GO
CREATE TABLE [dbo].[globalStateSettings] (
   [SSID] [int] NOT NULL
      IDENTITY (1,1),
   [StateCode] [varchar](2) NULL,
   [SET_FullStateName] [varchar](50) NULL,
   [SET_TemplateReady] [varchar](10) NULL,
   [SET_PrescMaxDosageLen] [varchar](3) NULL,
   [SET_PrescMaxCommentsLen] [varchar](3) NULL,
   [SET_PrnPresPaperCopyVertPix] [varchar](4) NULL

   ,CONSTRAINT [PK_globalStateSettings] PRIMARY KEY CLUSTERED ([SSID])
)


GO
CREATE TABLE [dbo].[group_sponsors] (
   [dg_id] [int] NOT NULL,
   [sponsor_id] [int] NOT NULL

   ,CONSTRAINT [PK_group_sponsors] PRIMARY KEY CLUSTERED ([dg_id], [sponsor_id])
)


GO
CREATE TABLE [dbo].[hl7_cross_reference] (
   [hl7_cr_id] [int] NOT NULL
      IDENTITY (1,1),
   [application] [varchar](50) NOT NULL,
   [hl7_prac_id] [varchar](255) NOT NULL,
   [dc_id] [int] NOT NULL,
   [uid] [varchar](10) NOT NULL,
   [pwd] [varchar](10) NOT NULL,
   [allergy_upload] [bit] NOT NULL,
   [enabled] [bit] NOT NULL,
   [diagnosis_upload] [bit] NOT NULL,
   [sched_upload] [bit] NOT NULL,
   [chart_no] [bit] NOT NULL,
   [recvFacility] [varchar](50) NULL,
   [recvApp] [varchar](50) NULL,
   [IsAlternativeID] [bit] NULL

   ,CONSTRAINT [PK_hl7_cross_reference] PRIMARY KEY NONCLUSTERED ([hl7_cr_id])
)

CREATE UNIQUE CLUSTERED INDEX [UniqueApplicationHL7Id] ON [dbo].[hl7_cross_reference] ([application], [hl7_prac_id])
CREATE UNIQUE NONCLUSTERED INDEX [UniquePracIDs] ON [dbo].[hl7_cross_reference] ([dc_id], [application], [hl7_prac_id])

GO
CREATE TABLE [dbo].[HMriskfactors] (
   [RF_ID] [int] NOT NULL,
   [RF_Name] [nvarchar](255) NULL,
   [RF_Description] [nvarchar](255) NULL,
   [RF_Type] [nvarchar](255) NULL,
   [ApplicableICDs] [nvarchar](255) NULL

   ,CONSTRAINT [PK_HMriskfactors] PRIMARY KEY CLUSTERED ([RF_ID])
)


GO
CREATE TABLE [dbo].[HMrules] (
   [rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [HmRuleID] [int] NULL,
   [RuleName] [nvarchar](255) NOT NULL,
   [RecommendedAge] [nvarchar](10) NULL,
   [MinAge] [nvarchar](10) NULL,
   [MaxAge] [nvarchar](10) NULL,
   [RecommendedInterval] [nvarchar](10) NULL,
   [MinInterval] [nvarchar](10) NULL,
   [MaxInterval] [nvarchar](10) NULL,
   [RuleText] [ntext] NULL,
   [FrequencyOfService] [ntext] NULL,
   [RuleRationale] [ntext] NULL,
   [Footnote] [nvarchar](255) NULL,
   [Source] [nvarchar](255) NULL,
   [Type] [nvarchar](6) NULL,
   [Grade] [nvarchar](1) NULL,
   [DoseNumber] [int] NULL,
   [ApplicableGender] [nvarchar](1) NULL,
   [ApplicableICDs] [nvarchar](255) NULL,
   [RestrictedICDs] [nvarchar](255) NULL,
   [LiveVaccine] [bit] NULL,
   [EggComponent] [bit] NULL,
   [GelatinComponent] [bit] NULL,
   [RiskCategory] [nvarchar](10) NULL,
   [RiskFactors] [nvarchar](255) NULL,
   [ApplicableAgeGroup] [nvarchar](12) NULL,
   [CPT] [nvarchar](255) NULL,
   [VaccineID] [int] NULL,
   [Comment] [nvarchar](255) NULL,
   [Inactive] [bit] NOT NULL,
   [DateLastTouched] [datetime] NULL,
   [LastTouchedBy] [nchar](50) NULL,
   [DateRowAdded] [datetime] NULL,
   [AgeSpecific] [bit] NOT NULL

   ,CONSTRAINT [PK_HMrules] PRIMARY KEY CLUSTERED ([rule_id])
)


GO
CREATE TABLE [dbo].[Holidays] (
   [Dg_Id] [bigint] NOT NULL,
   [Date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_Holidays] PRIMARY KEY CLUSTERED ([Dg_Id], [Date])
)


GO
CREATE TABLE [hospice].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PartnerId] [bigint] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_hospice_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_hospice_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [dbo].[hospice_drug_relatedness] (
   [hospice_drug_relatedness_id] [int] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [Description] [varchar](255) NOT NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_hospice_drug_relatedness] PRIMARY KEY CLUSTERED ([hospice_drug_relatedness_id])
)


GO
CREATE TABLE [dbo].[ht_gchart] (
   [Sex] [float] NULL,
   [Agemos] [float] NULL,
   [L] [float] NULL,
   [M] [float] NULL,
   [S] [float] NULL,
   [P3] [float] NULL,
   [P5] [float] NULL,
   [P10] [float] NULL,
   [P25] [float] NULL,
   [P50] [float] NULL,
   [P75] [float] NULL,
   [P90] [float] NULL,
   [P95] [float] NULL,
   [P97] [float] NULL,
   [ht_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_ht_gchart] PRIMARY KEY CLUSTERED ([ht_id])
)


GO
CREATE TABLE [dbo].[hx_migrated_encounters] (
   [encid] [bigint] NOT NULL,
   [error] [bit] NOT NULL

   ,CONSTRAINT [PK_hx_migrated_encounters] PRIMARY KEY CLUSTERED ([encid])
)


GO
CREATE TABLE [dbo].[ICWTransmitter_transactions] (
   [icwtransmit_id] [int] NOT NULL
      IDENTITY (1,1),
   [pt_id] [int] NULL,
   [request_date] [datetime] NOT NULL,
   [prescription_type] [tinyint] NOT NULL,
   [response_date] [datetime] NULL,
   [response_type] [smallint] NOT NULL,
   [icw_message_id] [varchar](128) NULL,
   [response_text] [varchar](255) NULL,
   [PD_ID] [int] NOT NULL,
   [pres_void_transmit] [bit] NOT NULL

   ,CONSTRAINT [PK_ICWTransmitter_transactions] PRIMARY KEY CLUSTERED ([icwtransmit_id])
)


GO
CREATE TABLE [dbo].[immunization_registry_settings] (
   [reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [sending_facilityid] [varchar](25) NULL,
   [dg_id] [int] NULL,
   [entered_on] [datetime] NULL,
   [added_by] [bigint] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [Receving_FacilityId] [varchar](50) NULL,
   [Sending_Facility_Name] [varchar](50) NULL,
   [Receiving_Facility_Name] [varchar](50) NULL

   ,CONSTRAINT [PK__immuniza__740387725D591B74] PRIMARY KEY CLUSTERED ([reg_id])
)


GO
CREATE TABLE [dbo].[incoming_rx_messages] (
   [incoming_rx_messages_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [refreq_id] [bigint] NULL,
   [dr_id] [bigint] NULL,
   [message] [varchar](max) NOT NULL,
   [delivery_method] [int] NULL,
   [type] [varchar](50) NULL,
   [is_success] [bit] NULL,
   [exception] [varchar](500) NULL,
   [created_date] [datetime] NULL

   ,CONSTRAINT [PK_incoming_rx_messages] PRIMARY KEY CLUSTERED ([incoming_rx_messages_id])
)


GO
CREATE TABLE [dbo].[InformationBlockingReason] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [Reason] [varchar](255) NOT NULL

   ,CONSTRAINT [PkInformationBlockingReasonId] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[inmediata_rxnt_xref] (
   [rxnt_im_xref_id] [int] NOT NULL
      IDENTITY (1,1),
   [inmediata_entity_id] [varchar](35) NOT NULL,
   [dg_id] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_inmediata_rxnt_xref] PRIMARY KEY CLUSTERED ([rxnt_im_xref_id])
)


GO
CREATE TABLE [dbo].[insert_update_log] (
   [Table_Name] [varchar](200) NOT NULL,
   [DrID] [int] NOT NULL,
   [UpdatedDate] [datetime] NOT NULL
)


GO
CREATE TABLE [dbo].[InsuranceServiceTypes] (
   [InsuranceServiceTypeId] [int] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](10) NOT NULL,
   [Definition] [varchar](50) NOT NULL,
   [CreatedDate] [datetime] NOT NULL,
   [UpdatedDate] [datetime] NULL

   ,CONSTRAINT [PK_InsuranceServiceTypes] PRIMARY KEY CLUSTERED ([InsuranceServiceTypeId])
)


GO
CREATE TABLE [dbo].[ins_carriers] (
   [ic_id] [int] NOT NULL
      IDENTITY (1,1),
   [ic_name] [varchar](80) NOT NULL

   ,CONSTRAINT [PK_ins_carriers] PRIMARY KEY NONCLUSTERED ([ic_id])
)


GO
CREATE TABLE [dbo].[ins_formularies] (
   [if_id] [int] NOT NULL
      IDENTITY (1,1),
   [ic_id] [int] NOT NULL,
   [ddid] [int] NOT NULL

   ,CONSTRAINT [PK_ins_formularies] PRIMARY KEY NONCLUSTERED ([if_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DDID_IC_No_Dups] ON [dbo].[ins_formularies] ([ic_id], [ddid])

GO
CREATE TABLE [dbo].[ins_formulary_codes] (
   [ifc_id] [int] NOT NULL
      IDENTITY (1,1),
   [ifc_code] [varchar](30) NOT NULL,
   [ifc_desc] [varchar](100) NULL

   ,CONSTRAINT [PK_ins_formulary_codes] PRIMARY KEY NONCLUSTERED ([ifc_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [NoDups] ON [dbo].[ins_formulary_codes] ([ifc_code])

GO
CREATE TABLE [dbo].[ins_formulary_code_links] (
   [ifcl_id] [int] NOT NULL
      IDENTITY (1,1),
   [if_id] [int] NOT NULL,
   [ifc_id] [int] NOT NULL

   ,CONSTRAINT [PK_ins_formulary_code_links] PRIMARY KEY NONCLUSTERED ([ifcl_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IF_IFC_No_Dups] ON [dbo].[ins_formulary_code_links] ([if_id], [ifc_id])

GO
CREATE TABLE [dbo].[interaction_warning_log] (
   [int_warn_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [response] [tinyint] NOT NULL,
   [date] [smalldatetime] NOT NULL,
   [warning_source] [smallint] NULL,
   [reason] [varchar](255) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_interaction_warning_log] PRIMARY KEY CLUSTERED ([int_warn_id])
)

CREATE NONCLUSTERED INDEX [IDX_interaction_warning_log_pa_id] ON [dbo].[interaction_warning_log] ([pa_id])

GO
CREATE TABLE [dbo].[lab_case_payer_info] (
   [case_payer_id] [int] NOT NULL,
   [insurance_type] [int] NULL,
   [workers_comp] [bit] NULL,
   [pa_id] [bigint] NOT NULL,
   [ApplicationId] [int] NOT NULL

   ,CONSTRAINT [PK_lab_case_payer_info] PRIMARY KEY CLUSTERED ([case_payer_id])
)


GO
CREATE TABLE [dbo].[lab_embedded_data] (
   [emb_id] [int] NOT NULL
      IDENTITY (1,1),
   [embedded_data] [varchar](max) NULL,
   [lab_result_id] [int] NOT NULL

   ,CONSTRAINT [PK_lab_embedded_data] PRIMARY KEY CLUSTERED ([emb_id])
)


GO
CREATE TABLE [dbo].[lab_main] (
   [lab_id] [int] NOT NULL
      IDENTITY (1,1),
   [send_appl] [varchar](1000) NOT NULL,
   [send_facility] [varchar](1000) NULL,
   [rcv_appl] [varchar](1000) NOT NULL,
   [rcv_facility] [varchar](1000) NOT NULL,
   [message_date] [datetime] NOT NULL,
   [message_type] [varchar](50) NOT NULL,
   [message_ctrl_id] [varchar](100) NULL,
   [version] [varchar](10) NOT NULL,
   [component_sep] [varchar](1) NOT NULL,
   [subcomponent_sep] [varchar](1) NOT NULL,
   [escape_delim] [varchar](1) NOT NULL,
   [filename] [varchar](500) NULL,
   [dr_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [is_read] [bit] NOT NULL,
   [read_by] [int] NULL,
   [PROV_NAME] [varchar](500) NOT NULL,
   [comments] [varchar](7000) NULL,
   [result_file_path] [varchar](255) NULL,
   [type] [varchar](10) NOT NULL,
   [lab_order_master_id] [bigint] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [InformationBlockingReasonId] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_lab_main] PRIMARY KEY CLUSTERED ([lab_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_main_7_59251366__K6_K17_K16_K1_2_3_4_5_7_8_9_10_11_12_13_14_15_18_19_20] ON [dbo].[lab_main] ([message_date], [is_read], [dg_id], [lab_id]) INCLUDE ([comments], [component_sep], [dr_id], [escape_delim], [filename], [message_ctrl_id], [message_type], [pat_id], [PROV_NAME], [rcv_appl], [rcv_facility], [read_by], [send_appl], [send_facility], [subcomponent_sep], [version])
CREATE NONCLUSTERED INDEX [IX_lab_main] ON [dbo].[lab_main] ([pat_id], [dg_id], [dr_id], [message_date] DESC)
CREATE NONCLUSTERED INDEX [ix_lab_main_dg_id_is_read] ON [dbo].[lab_main] ([dg_id], [is_read])
CREATE NONCLUSTERED INDEX [ix_lab_main_dr_id_is_read] ON [dbo].[lab_main] ([dr_id], [is_read])

GO
CREATE TABLE [dbo].[lab_order_info] (
   [lab_report_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_id] [int] NOT NULL,
   [spm_id] [varchar](1000) NOT NULL,
   [filler_acc_id] [varchar](1000) NOT NULL,
   [order_date] [datetime] NOT NULL,
   [ord_prv_id] [varchar](1000) NOT NULL,
   [ord_prv_first] [varchar](100) NULL,
   [ord_prv_last] [varchar](100) NULL,
   [ord_prv_mi] [varchar](100) NULL,
   [ord_prv_id_src] [varchar](100) NULL,
   [ord_prv_id_typ] [varchar](100) NULL,
   [priority] [varchar](100) NULL,
   [callback_no] [varchar](100) NULL,
   [pon_namespace_id] [varchar](200) NULL,
   [pon_uid] [varchar](200) NULL,
   [pon_uid_type] [varchar](200) NULL,
   [placer_group_number] [varchar](300) NULL,
   [pgn_namespace_id] [varchar](300) NULL,
   [pgn_uid] [varchar](200) NULL,
   [pgn_uid_type] [varchar](200) NULL

   ,CONSTRAINT [PK_lab_order_info] PRIMARY KEY CLUSTERED ([lab_report_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_order_info_7_139251651__K2_K1_3_4_5_6_7_8_9_10_11_12_13] ON [dbo].[lab_order_info] ([lab_id], [lab_report_id]) INCLUDE ([callback_no], [filler_acc_id], [ord_prv_first], [ord_prv_id], [ord_prv_id_src], [ord_prv_id_typ], [ord_prv_last], [ord_prv_mi], [order_date], [priority], [spm_id])

GO
CREATE TABLE [dbo].[lab_partners] (
   [lab_partner_id] [int] NOT NULL,
   [partner_name] [varchar](100) NOT NULL,
   [partner_address] [varchar](100) NOT NULL,
   [partner_city] [varchar](50) NOT NULL,
   [partner_state] [varchar](2) NOT NULL,
   [partner_zip] [varchar](10) NOT NULL,
   [partner_phone] [varchar](20) NOT NULL,
   [partner_fax] [varchar](20) NOT NULL,
   [partner_participant] [bigint] NOT NULL,
   [partner_enabled] [bit] NOT NULL,
   [partner_sendapp_text] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_lab_partners] PRIMARY KEY CLUSTERED ([lab_partner_id])
)


GO
CREATE TABLE [dbo].[lab_partner_aoes] (
   [lab_partner_aoes_id] [int] NOT NULL
      IDENTITY (1,1),
   [external_lab_id] [varchar](100) NOT NULL,
   [partner_aoe_id] [varchar](100) NOT NULL,
   [partner_aoe_type] [varchar](100) NOT NULL,
   [partner_aoe_label] [varchar](1000) NOT NULL,
   [partner_aoe_menu] [varchar](4000) NOT NULL,
   [partner_aoe_radios] [varchar](4000) NOT NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NOT NULL,
   [last_modified_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL

   ,CONSTRAINT [PK_lab_partner_aoes] PRIMARY KEY CLUSTERED ([lab_partner_aoes_id])
)


GO
CREATE TABLE [dbo].[lab_partner_aoes_testlevel] (
   [lab_partner_aoes_testlevel_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_partner_aoes_id] [int] NOT NULL,
   [external_lab_id] [varchar](100) NOT NULL,
   [partner_aoe_id] [varchar](100) NOT NULL,
   [partner_test_id] [varchar](100) NOT NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NOT NULL,
   [last_modified_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL

   ,CONSTRAINT [PK_lab_partner_aoes_testlevel] PRIMARY KEY CLUSTERED ([lab_partner_aoes_testlevel_id])
)


GO
CREATE TABLE [dbo].[lab_partner_aoe_questions] (
   [aoe_question_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [partner_id] [int] NULL,
   [lab_partner_test_xrefid] [int] NULL,
   [partner_test_id] [varchar](50) NULL,
   [partner_aoe_id] [varchar](50) NULL,
   [partner_aoe_type] [varchar](50) NULL,
   [aoe_label] [varchar](255) NULL,
   [menu] [varchar](4000) NULL,
   [radios] [varchar](4000) NULL

   ,CONSTRAINT [PK_lab_partner_aoe_questions] PRIMARY KEY CLUSTERED ([aoe_question_id])
)


GO
CREATE TABLE [dbo].[lab_partner_tests] (
   [lab_partner_tests_id] [int] NOT NULL
      IDENTITY (1,1),
   [external_lab_id] [varchar](100) NOT NULL,
   [partner_test_id] [varchar](140) NOT NULL,
   [partner_test_short_name] [varchar](1000) NOT NULL,
   [partner_test_long_name] [varchar](1000) NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NULL,
   [last_modified_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL,
   [partner_local_test_id] [varchar](140) NULL

   ,CONSTRAINT [PK_lab_partner_test] PRIMARY KEY CLUSTERED ([lab_partner_tests_id])
)


GO
CREATE TABLE [dbo].[lab_partner_tests_xref] (
   [lab_partner_test_xrefid] [int] NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [partner_id] [int] NOT NULL,
   [partner_test_id] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_lab_partner_tests_xref] PRIMARY KEY CLUSTERED ([lab_partner_test_xrefid])
)


GO
CREATE TABLE [dbo].[lab_partner_test_info] (
   [test_info_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [property_name] [varchar](100) NULL,
   [external_lab_id] [varchar](100) NULL,
   [partner_test_id] [varchar](100) NULL,
   [comments] [varchar](max) NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NOT NULL,
   [last_modified_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL

   ,CONSTRAINT [PK_lab_partner_test_info] PRIMARY KEY CLUSTERED ([test_info_id])
)


GO
CREATE TABLE [dbo].[lab_pat_details] (
   [lab_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [ext_pat_id] [varchar](1000) NULL,
   [lab_pat_id] [varchar](1000) NOT NULL,
   [alt_pat_id] [varchar](1000) NULL,
   [pa_first] [varchar](200) NOT NULL,
   [pa_last] [varchar](200) NOT NULL,
   [pa_middle] [varchar](200) NOT NULL,
   [pa_dob] [datetime] NOT NULL,
   [pa_sex] [varchar](3) NOT NULL,
   [pa_address1] [varchar](200) NOT NULL,
   [pa_city] [varchar](200) NOT NULL,
   [pa_state] [varchar](5) NOT NULL,
   [pa_zip] [varchar](200) NOT NULL,
   [pa_acctno] [varchar](200) NOT NULL,
   [spm_status] [varchar](200) NULL,
   [fasting] [varchar](200) NOT NULL,
   [notes] [varchar](max) NULL,
   [pa_suffix] [varchar](10) NULL,
   [pa_race] [varchar](35) NULL,
   [pa_alternate_race] [varchar](35) NULL,
   [lab_patid_namespace_id] [varchar](25) NULL,
   [lab_patid_type_code] [varchar](25) NULL,
   [lab_pat_id_uid] [varchar](20) NULL,
   [lab_pat_id_uid_type] [varchar](20) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_lab_pat_details] PRIMARY KEY CLUSTERED ([lab_id], [pat_id])
)


GO
CREATE TABLE [dbo].[lab_result_details] (
   [lab_result_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_result_info_id] [int] NOT NULL,
   [value_type] [tinyint] NOT NULL,
   [obs_ident] [varchar](3000) NOT NULL,
   [obs_text] [varchar](1000) NOT NULL,
   [obs_cod_sys] [varchar](100) NOT NULL,
   [alt_obs_ident] [varchar](100) NULL,
   [alt_obs_text] [varchar](1000) NULL,
   [alt_cod_sys] [varchar](100) NULL,
   [obs_sub_id] [varchar](100) NULL,
   [obs_value] [varchar](max) NULL,
   [coding_unit_ident] [varchar](100) NULL,
   [coding_unit_text] [varchar](1000) NULL,
   [coding_unit_sys] [varchar](100) NULL,
   [ref_range] [varchar](500) NULL,
   [abnormal_flags] [smallint] NOT NULL,
   [obs_result_status] [smallint] NOT NULL,
   [dt_last_change] [datetime] NOT NULL,
   [obs_date_time] [datetime] NOT NULL,
   [prod_id] [varchar](500) NULL,
   [notes] [varchar](max) NULL,
   [has_embedded_data] [bit] NOT NULL,
   [org_name] [varchar](500) NULL,
   [org_id] [varchar](500) NULL,
   [org_addr1] [varchar](500) NULL,
   [org_city] [varchar](500) NULL,
   [org_state] [varchar](500) NULL,
   [org_zip] [varchar](500) NULL,
   [org_dr_first] [varchar](500) NULL,
   [org_dr_last] [varchar](500) NULL,
   [org_dr_mi] [varchar](500) NULL,
   [org_dr_title] [varchar](500) NULL,
   [file_name] [varchar](500) NULL,
   [file_uploaded_dt] [datetime] NULL,
   [file_uploaded_category_id] [int] NULL,
   [org_country] [varchar](20) NULL,
   [org_dr_prefix] [varchar](10) NULL,
   [org_dr_suffix] [varchar](10) NULL,
   [org_dr_id] [varchar](20) NULL,
   [org_dr_id_namespace_id] [varchar](35) NULL,
   [org_dr_id_uid] [varchar](20) NULL,
   [org_dr_id_uid_type] [varchar](20) NULL,
   [org_dr_type_code] [varchar](10) NULL,
   [org_type] [varchar](20) NULL

   ,CONSTRAINT [PK_lab_result_details] PRIMARY KEY CLUSTERED ([lab_result_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_result_details_7_283252164__K2] ON [dbo].[lab_result_details] ([lab_result_info_id])

GO
CREATE TABLE [dbo].[lab_result_info] (
   [lab_result_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_id] [int] NOT NULL,
   [lab_order_id] [int] NOT NULL,
   [spm_id] [varchar](500) NOT NULL,
   [filler_acc_id] [varchar](500) NOT NULL,
   [obs_bat_ident] [varchar](500) NOT NULL,
   [obs_ba_test] [varchar](500) NOT NULL,
   [obs_cod_sys] [varchar](500) NOT NULL,
   [obs_date] [datetime] NOT NULL,
   [coll_vol] [varchar](500) NULL,
   [act_code] [tinyint] NOT NULL,
   [rel_cl_info] [varchar](500) NULL,
   [dt_spm_rcv] [datetime] NOT NULL,
   [spm_src] [varchar](500) NULL,
   [ord_prv_id] [varchar](500) NULL,
   [ord_prv_first] [varchar](500) NULL,
   [ord_prv_last] [varchar](500) NULL,
   [ord_prv_mi] [varchar](500) NULL,
   [ord_prv_id_src] [varchar](500) NULL,
   [ord_prv_id_typ] [varchar](500) NULL,
   [prod_fld] [varchar](500) NULL,
   [obs_rel_dt] [datetime] NOT NULL,
   [prod_sec_id] [varchar](500) NULL,
   [ord_result_status] [tinyint] NULL,
   [parent_result] [varchar](500) NULL,
   [parent_result_sub_id] [varchar](500) NULL,
   [priority] [nchar](10) NULL,
   [parent_ord_numb] [varchar](500) NULL,
   [notes] [varchar](max) NULL,
   [callbackno] [varchar](500) NULL,
   [fon_namespace_id] [varchar](20) NULL,
   [fon_uid] [varchar](20) NULL,
   [fon_uid_type] [varchar](20) NULL,
   [ord_prv_prefix] [varchar](10) NULL,
   [ord_prv_suffix] [varchar](10) NULL,
   [ord_prv_id_namespace_id] [varchar](35) NULL,
   [ord_prv_id_uid] [varchar](20) NULL,
   [ord_prv_id_uid_type] [varchar](20) NULL,
   [ord_prv_name_type] [varchar](10) NULL

   ,CONSTRAINT [PK_lab_result_info] PRIMARY KEY CLUSTERED ([lab_result_info_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_result_info_7_2139258776__K3_K1_2_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_30] ON [dbo].[lab_result_info] ([lab_order_id], [lab_result_info_id]) INCLUDE ([act_code], [callbackno], [coll_vol], [dt_spm_rcv], [filler_acc_id], [lab_id], [obs_ba_test], [obs_bat_ident], [obs_cod_sys], [obs_date], [obs_rel_dt], [ord_prv_first], [ord_prv_id], [ord_prv_id_src], [ord_prv_id_typ], [ord_prv_last], [ord_prv_mi], [ord_result_status], [parent_ord_numb], [parent_result], [parent_result_sub_id], [priority], [prod_fld], [prod_sec_id], [rel_cl_info], [spm_id], [spm_src])
CREATE NONCLUSTERED INDEX [IX_lab_result_info-lab_id-lab_result_info_id] ON [dbo].[lab_result_info] ([lab_id]) INCLUDE ([lab_result_info_id])

GO
CREATE TABLE [dbo].[lab_result_place_srv] (
   [labsrv_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_result_info_id] [int] NOT NULL,
   [fac_mnem] [varchar](500) NOT NULL,
   [fac_name] [varchar](500) NOT NULL,
   [fac_addr] [varchar](500) NOT NULL,
   [fac_city] [varchar](500) NOT NULL,
   [fac_state] [varchar](500) NOT NULL,
   [fac_zip] [varchar](500) NOT NULL,
   [fac_phone] [varchar](500) NOT NULL,
   [fac_dr] [varchar](500) NOT NULL,
   [fac_lab_id] [varchar](500) NULL,
   [fac_clia] [varchar](500) NOT NULL

   ,CONSTRAINT [PK_lab_result_place_srv] PRIMARY KEY CLUSTERED ([labsrv_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_result_place_srv_7_1476304419__K2_1_3_4_5_6_7_8_9_10_11_12] ON [dbo].[lab_result_place_srv] ([lab_result_info_id]) INCLUDE ([fac_addr], [fac_city], [fac_clia], [fac_dr], [fac_lab_id], [fac_mnem], [fac_name], [fac_phone], [fac_state], [fac_zip], [labsrv_id])

GO
CREATE TABLE [dbo].[lab_result_specimen] (
   [spm_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_id] [int] NOT NULL,
   [lab_order_id] [int] NOT NULL,
   [spm_id] [varchar](500) NOT NULL,
   [spm_text] [varchar](500) NOT NULL,
   [spm_rcv_dt] [datetime] NULL,
   [spm_src] [varchar](500) NOT NULL,
   [srp_reject_reason] [varchar](1000) NOT NULL,
   [spm_condition] [varchar](1000) NULL,
   [spm_collection_time_start] [datetime] NULL

   ,CONSTRAINT [PK__lab_result_speci__5B451F22] PRIMARY KEY CLUSTERED ([spm_info_id])
)


GO
CREATE TABLE [dbo].[lab_test_lists] (
   [lab_test_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_test_name] [varchar](500) NOT NULL,
   [active] [bit] NOT NULL,
   [test_type] [smallint] NULL,
   [loinc_code] [varchar](10) NULL,
   [CODE_TYPE] [varchar](20) NOT NULL,
   [lab_test_name_long] [varchar](500) NULL

   ,CONSTRAINT [PK_lab_test_lists] PRIMARY KEY CLUSTERED ([lab_test_id])
)


GO
CREATE TABLE [dbo].[lab_test_lists_favourites] (
   [lab_test_id] [int] NOT NULL,
   [dr_id] [bigint] NOT NULL
)


GO
CREATE TABLE [dbo].[language_resource] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [displaytext] [ntext] NOT NULL,
   [language] [smallint] NOT NULL,
   [POSITION] [int] NOT NULL

   ,CONSTRAINT [PK__language_resourc__5E218BCD] PRIMARY KEY CLUSTERED ([id])
)

CREATE UNIQUE NONCLUSTERED INDEX [NoDuplicateEntries] ON [dbo].[language_resource] ([language], [POSITION])

GO
CREATE TABLE [dbo].[LOINC] (
   [LN_ID] [int] NOT NULL
      IDENTITY (1,1),
   [LOINC_NUM] [nvarchar](7) NOT NULL,
   [COMPONENT] [nvarchar](255) NOT NULL,
   [PROPERTY] [nvarchar](30) NULL,
   [TIME_ASPCT] [nvarchar](15) NULL,
   [SYSTEM] [nvarchar](100) NULL,
   [SCALE_TYP] [nvarchar](30) NULL,
   [METHOD_TYP] [nvarchar](50) NULL,
   [RELAT_NMS] [nvarchar](254) NULL,
   [CLASS] [nvarchar](20) NULL,
   [SOURCE] [nvarchar](8) NULL,
   [DT_LAST_CH] [nvarchar](8) NULL,
   [CHNG_TYPE] [nvarchar](3) NULL,
   [COMMENTS] [ntext] NULL,
   [ANSWERLIST] [ntext] NULL,
   [STATUS] [nvarchar](3) NULL,
   [MAP_TO] [nvarchar](7) NULL,
   [SCOPE] [nvarchar](20) NULL,
   [NORM_RANGE] [nvarchar](30) NULL,
   [IPCC_UNITS] [nvarchar](30) NULL,
   [REFERENCE] [ntext] NULL,
   [EXACT_CMP_SY] [nvarchar](50) NULL,
   [MOLAR_MASS] [nvarchar](13) NULL,
   [CLASSTYPE] [int] NULL,
   [FORMULA] [nvarchar](255) NULL,
   [SPECIES] [nvarchar](20) NULL,
   [EXMPL_ANSWERS] [ntext] NULL,
   [ACSSYM] [ntext] NULL,
   [BASE_NAME] [nvarchar](50) NULL,
   [FINAL] [nvarchar](1) NOT NULL,
   [NAACCR_ID] [nvarchar](20) NULL,
   [CODE_TABLE] [nvarchar](10) NULL,
   [SetRoot] [bit] NOT NULL,
   [PanelElements] [ntext] NULL,
   [SURVEY_QUEST_TEXT] [nvarchar](255) NULL,
   [SURVEY_QUEST_SRC] [nvarchar](50) NULL,
   [UnitsRequired] [nvarchar](1) NULL,
   [SUBMITTED_UNITS] [nvarchar](30) NULL,
   [RelatedNames2] [ntext] NULL,
   [SHORTNAME] [nvarchar](40) NULL,
   [ORDER_OBS] [nvarchar](15) NULL,
   [CDISC_COMMON_TESTS] [nvarchar](1) NULL,
   [HL7_FIELD_SUBFIELD_ID] [nvarchar](50) NULL,
   [EXTERNAL_COPYRIGHT_NOTICE] [ntext] NULL

   ,CONSTRAINT [PK_LOINC] PRIMARY KEY CLUSTERED ([LN_ID])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[LOINC] ([LOINC_NUM], [COMPONENT])
CREATE NONCLUSTERED INDEX [IX_SUB] ON [dbo].[LOINC] ([SYSTEM], [METHOD_TYP], [CLASS], [CLASSTYPE])

GO
CREATE TABLE [dbo].[ManualMergedPatients] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [PrimaryPatientId] [bigint] NULL,
   [SecondaryPatientId] [bigint] NULL

   ,CONSTRAINT [PK_ManualMergedPatients] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[manufacturedDrug] (
   [rxnt_mdid] [int] NOT NULL
      IDENTITY (1,1),
   [labelname] [varchar](35) NULL,
   [ndcs] [varchar](200) NULL,
   [labelerid] [varchar](6) NULL,
   [federallegendcode] [varchar](1) NULL,
   [genmfgcode] [varchar](1) NULL,
   [dispdrugid] [int] NULL,
   [dnid] [int] NULL,
   [rtid] [int] NULL,
   [dfid] [int] NULL,
   [strength] [varchar](15) NULL,
   [strengthunits] [varchar](15) NULL,
   [gpi] [varchar](14) NULL,
   [kdc] [varchar](10) NULL,
   [gcnseqno] [int] NULL,
   [rtgenid] [varchar](8) NULL,
   [hicl] [int] NULL,
   [genderspecificdrugcode] [varchar](1) NULL,
   [medicaldeviceind] [smallint] NULL

   ,CONSTRAINT [PK_manufacturedDrug] PRIMARY KEY CLUSTERED ([rxnt_mdid])
)


GO
CREATE TABLE [dbo].[Master_Fee_Settings] (
   [Master_Fee_Setting_Id] [int] NOT NULL
      IDENTITY (1,1),
   [Fee_Type] [char](1) NOT NULL,
   [Fee] [decimal](18,2) NOT NULL,
   [Updated_DateTime] [datetime] NOT NULL,
   [Updated_User] [nvarchar](50) NOT NULL

   ,CONSTRAINT [PK_Master_Fee_Settings] PRIMARY KEY CLUSTERED ([Master_Fee_Setting_Id])
)


GO
CREATE TABLE [dbo].[master_patient_menu] (
   [master_patient_menu_id] [int] NOT NULL
      IDENTITY (1,1),
   [code] [varchar](5) NOT NULL,
   [description] [varchar](max) NOT NULL,
   [sort_order] [int] NOT NULL,
   [is_ehr] [bit] NULL,
   [is_erx] [bit] NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL,
   [active] [bit] NULL

   ,CONSTRAINT [AK_master_patient_menu_Column] UNIQUE NONCLUSTERED ([code])
   ,CONSTRAINT [PK_master_patient_menu] PRIMARY KEY CLUSTERED ([master_patient_menu_id])
)


GO
CREATE TABLE [mda].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_mda_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_mda_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [dbo].[MergePatientsPresIds] (
   [mergepatpresid] [int] NOT NULL
      IDENTITY (1,1),
   [deleted_pa_id] [int] NOT NULL,
   [pres_id] [int] NOT NULL,
   [merge_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_MergePatientsPresIds] PRIMARY KEY CLUSTERED ([mergepatpresid])
)


GO
CREATE TABLE [dbo].[MergePatientsXRef] (
   [mergepatxref_id] [int] NOT NULL
      IDENTITY (1,1),
   [deleted_pa_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [merge_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_MergePatientsXRef] PRIMARY KEY CLUSTERED ([mergepatxref_id])
)


GO
CREATE TABLE [dbo].[merge_patients_cache] (
   [mg_pat_cache_id] [int] NOT NULL
      IDENTITY (1,1),
   [original_pa_id] [int] NOT NULL,
   [deleted_pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_merge_patients_cache] PRIMARY KEY CLUSTERED ([mg_pat_cache_id])
)


GO
CREATE TABLE [dbo].[merge_patients_search_cache] (
   [mg_pat_search_cache_id] [int] NOT NULL
      IDENTITY (1,1),
   [deleted_pa_id] [int] NOT NULL,
   [ultimate_pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_merge_patients_search_cache] PRIMARY KEY NONCLUSTERED ([mg_pat_search_cache_id])
)

CREATE CLUSTERED INDEX [merge_patients_search_cache1] ON [dbo].[merge_patients_search_cache] ([deleted_pa_id])
CREATE NONCLUSTERED INDEX [merge_patients_search_cache2] ON [dbo].[merge_patients_search_cache] ([ultimate_pa_id])

GO
CREATE TABLE [dbo].[messaging_folders] (
   [folder_id] [int] NOT NULL
      IDENTITY (1,1),
   [parent_folder_id] [int] NOT NULL,
   [folder_type_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [folder_name] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_messaging_folders] PRIMARY KEY CLUSTERED ([folder_id])
)


GO
CREATE TABLE [dbo].[messaging_folder_types] (
   [folder_type_id] [int] NOT NULL
      IDENTITY (1,1),
   [folder_type] [varchar](50) NOT NULL,
   [icon_image] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_messaging_folder_types] PRIMARY KEY CLUSTERED ([folder_type_id])
)


GO
CREATE TABLE [dbo].[messaging_messages] (
   [message_id] [int] NOT NULL
      IDENTITY (1,1),
   [sender_dr_id] [int] NOT NULL,
   [mm_subject] [varchar](255) NOT NULL,
   [mm_create_date] [datetime] NOT NULL,
   [mm_body_text] [text] NOT NULL

   ,CONSTRAINT [PK_messaging_messages] PRIMARY KEY CLUSTERED ([message_id])
)


GO
CREATE TABLE [dbo].[messaging_message_folders] (
   [message_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [folder_id] [int] NOT NULL,
   [is_read] [bit] NOT NULL

   ,CONSTRAINT [PK_messaging_message_folders] PRIMARY KEY CLUSTERED ([message_id], [dr_id], [folder_id])
)


GO
CREATE TABLE [dbo].[messaging_message_recipients] (
   [message_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_messaging_message_recipients] PRIMARY KEY CLUSTERED ([message_id], [dr_id])
)


GO
CREATE TABLE [dbo].[MichiganTargetPhysicians] (
   [DEA] [varchar](30) NOT NULL,
   [Last Name] [varchar](255) NULL,
   [First Name] [varchar](255) NULL,
   [Address1] [varchar](255) NULL,
   [Address2] [varchar](255) NULL,
   [City] [varchar](50) NULL,
   [State] [varchar](5) NULL,
   [Zip] [varchar](20) NULL,
   [Phone] [varchar](20) NULL,
   [Fax] [varchar](20) NULL,
   [faxed] [bit] NOT NULL,
   [not_interested] [bit] NOT NULL,
   [fax_date] [datetime] NULL,
   [comments] [varchar](255) NULL

   ,CONSTRAINT [PK_MichiganTargetPhysicians] PRIMARY KEY CLUSTERED ([DEA])
)


GO
CREATE TABLE [dbo].[MIPSMeasures] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [MeasureCode] [varchar](3) NOT NULL,
   [MeasureGroup] [varchar](3) NOT NULL,
   [MeasureName] [varchar](100) NOT NULL,
   [MeasureStage] [varchar](10) NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [MeasureDescription] [varchar](500) NULL,
   [PassingCriteria] [varchar](50) NULL,
   [IsActive] [bit] NOT NULL,
   [MeasureGroupName] [varchar](50) NULL,
   [PassingCriteriaMIPS2017] [varchar](50) NULL,
   [MeasureDescription2017] [varchar](50) NULL,
   [MeasureClass] [varchar](100) NULL,
   [Performace_points_per_10_percent] [int] NULL,
   [MeasureCalculation] [varchar](100) NULL

   ,CONSTRAINT [PK_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[misc] (
   [db_ver] [int] NOT NULL,
   [city_ver] [int] NULL,
   [app_ver] [varchar](50) NOT NULL,
   [url] [varchar](250) NOT NULL,
   [fileName] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_misc] PRIMARY KEY CLUSTERED ([db_ver])
)


GO
CREATE TABLE [dbo].[MSchange_tracking_history] (
   [internal_table_name] [nvarchar](128) NOT NULL,
   [table_name] [nvarchar](128) NOT NULL,
   [start_time] [datetime] NOT NULL,
   [end_time] [datetime] NOT NULL,
   [rows_cleaned_up] [bigint] NOT NULL,
   [cleanup_version] [bigint] NOT NULL,
   [comments] [nvarchar](max) NOT NULL

)

CREATE NONCLUSTERED INDEX [IX_MSchange_tracking_history_start_time] ON [dbo].[MSchange_tracking_history] ([start_time])

GO
CREATE TABLE [dbo].[MU2021Measures] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [MeasureCode] [varchar](3) NOT NULL,
   [MeasureGroup] [varchar](3) NOT NULL,
   [MeasureName] [varchar](100) NOT NULL,
   [MeasureStage] [varchar](10) NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [MeasureDescription] [varchar](500) NULL,
   [PassingCriteria] [varchar](50) NULL,
   [IsActive] [bit] NOT NULL,
   [MeasureGroupName] [varchar](50) NULL
)


GO
CREATE TABLE [dbo].[MU3Measures] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [MeasureCode] [varchar](3) NOT NULL,
   [MeasureGroup] [varchar](3) NOT NULL,
   [MeasureName] [varchar](100) NOT NULL,
   [MeasureStage] [varchar](10) NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [MeasureDescription] [varchar](500) NULL,
   [PassingCriteria] [varchar](50) NULL,
   [IsActive] [bit] NOT NULL,
   [MeasureGroupName] [varchar](50) NULL,
   [PassingCriteriaMU2017] [varchar](50) NULL,
   [MeasureDescriptionMU2017] [varchar](max) NULL

   ,CONSTRAINT [PK_MU3Measures_Id] PRIMARY KEY CLUSTERED ([Id])
   ,CONSTRAINT [UQ__MU3Measu__A0429051181EE463] UNIQUE NONCLUSTERED ([MeasureCode])
)


GO
CREATE TABLE [dbo].[MU4Measures] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [MeasureCode] [varchar](3) NOT NULL,
   [MeasureGroup] [varchar](3) NOT NULL,
   [MeasureName] [varchar](100) NOT NULL,
   [MeasureStage] [varchar](10) NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [MeasureDescription] [varchar](500) NULL,
   [PassingCriteria] [varchar](50) NULL,
   [IsActive] [bit] NOT NULL,
   [MeasureGroupName] [varchar](50) NULL,
   [PassingCriteriaMU2017] [varchar](50) NULL,
   [MeasureDescriptionMU2017] [varchar](max) NULL
)


GO
CREATE TABLE [dbo].[MUMeasureCounts] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [MUMeasuresId] [int] NOT NULL,
   [MeasureCode] [varchar](3) NOT NULL,
   [dc_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [enc_id] [int] NULL,
   [enc_date] [datetime] NULL,
   [DateAdded] [datetime] NOT NULL,
   [IsNumerator] [bit] NOT NULL,
   [IsDenominator] [bit] NOT NULL,
   [RecordCreateUserId] [int] NULL,
   [RecordCreateDateTime] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_MUMeasureCounts] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [_dta_index_MUMeasureCounts_7_1584880863__K7_K3_K10_K12_K11] ON [dbo].[MUMeasureCounts] ([pa_id], [MeasureCode], [DateAdded], [IsDenominator], [IsNumerator])
CREATE NONCLUSTERED INDEX [idx_MUMeasureCounts_MeasureCode_dr_id_DateAdded] ON [dbo].[MUMeasureCounts] ([MeasureCode], [dr_id], [DateAdded])
CREATE NONCLUSTERED INDEX [IDX_MUMeasureCounts_pa_id] ON [dbo].[MUMeasureCounts] ([pa_id]) INCLUDE ([active], [DateAdded], [dc_id], [dg_id], [dr_id], [enc_date], [enc_id], [Id], [IsDenominator], [IsNumerator], [last_modified_by], [last_modified_date], [MeasureCode], [MUMeasuresId], [RecordCreateDateTime], [RecordCreateUserId])
CREATE NONCLUSTERED INDEX [ix_MUMeasureCounts_enc_id_IsNumerator_includes] ON [dbo].[MUMeasureCounts] ([enc_id], [IsNumerator]) INCLUDE ([Id], [MeasureCode])

GO
CREATE TABLE [dbo].[MUMeasures] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [MeasureCode] [varchar](3) NOT NULL,
   [MeasureGroup] [varchar](3) NOT NULL,
   [MeasureName] [varchar](100) NOT NULL,
   [MeasureStage] [varchar](10) NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [MeasureDescription] [varchar](500) NULL,
   [PassingCriteria] [varchar](50) NULL,
   [IsActive] [bit] NOT NULL,
   [MeasureGroupName] [varchar](50) NULL,
   [PassingCriteriaMU2016] [varchar](50) NULL,
   [MeasureDescriptionMU2016] [varchar](max) NULL

   ,CONSTRAINT [PK_MUMeasures_Id] PRIMARY KEY CLUSTERED ([Id])
   ,CONSTRAINT [UQ__MUMeasur__A0429051633C11FC] UNIQUE NONCLUSTERED ([MeasureCode])
)


GO
CREATE TABLE [dbo].[NCPDPUnitCodes] (
   [Code] [varchar](3) NOT NULL,
   [Definition] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_NCPDPUnitCodes] PRIMARY KEY CLUSTERED ([Code])
)


GO
CREATE TABLE [dbo].[NonFormularyPrescriptionsLog] (
   [PresLogId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorGroupId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [DoctorLastName] [varchar](50) NULL,
   [DoctorFirstName] [varchar](50) NULL,
   [PrimDoctorId] [bigint] NULL,
   [MainDoctorId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [PatientLastName] [varchar](50) NULL,
   [PatientFirstName] [varchar](50) NULL,
   [MedId] [bigint] NULL,
   [DrugName] [varchar](500) NULL,
   [PatientExtCoverageId] [bigint] NULL,
   [FormularyId] [varchar](100) NULL,
   [NDC] [varchar](50) NULL,
   [EntryDate] [datetime] NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL

   ,CONSTRAINT [PK_NonFormularyPrescriptionsLog] PRIMARY KEY CLUSTERED ([PresLogId])
)


GO
CREATE TABLE [dbo].[NQF_Codes] (
   [NQF_Code_Id] [int] NOT NULL,
   [code] [varchar](100) NOT NULL,
   [code_type] [varchar](10) NOT NULL,
   [NQF_id] [varchar](10) NOT NULL,
   [IsActive] [bit] NOT NULL,
   [IsExclude] [bit] NOT NULL,
   [criteria] [smallint] NOT NULL,
   [criteriatype] [varchar](10) NOT NULL

   ,CONSTRAINT [PK_NQF_Codes] PRIMARY KEY CLUSTERED ([NQF_Code_Id])
)


GO
CREATE TABLE [dbo].[output] (
   [Column 0] [varchar](8000) NULL,
   [Column 1] [varchar](8000) NULL,
   [Column 2] [varchar](8000) NULL
)


GO
CREATE TABLE [dbo].[page_exec_log] (
   [pg_exec_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [page_name] [varchar](125) NULL,
   [dg_id] [int] NULL,
   [exec_time] [int] NULL,
   [date_log] [smalldatetime] NULL

   ,CONSTRAINT [PK_page_exec_log] PRIMARY KEY CLUSTERED ([pg_exec_log_id])
)


GO
CREATE TABLE [dbo].[palm_doc_sync] (
   [dr_id] [int] NOT NULL,
   [sync_val] [smallint] NOT NULL

   ,CONSTRAINT [PK_palm_doc_sync] PRIMARY KEY CLUSTERED ([dr_id])
)


GO
CREATE TABLE [dbo].[PARTNER_ACCOUNTS] (
   [PARTNER_ID] [int] NOT NULL
      IDENTITY (1,1),
   [PARTNER_NAME] [varchar](50) NOT NULL,
   [PARTNER_USERNAME] [varchar](20) NOT NULL,
   [PARTNER_PASSWORD] [varchar](100) NULL,
   [SALT] [varchar](20) NOT NULL,
   [ENABLED] [bit] NOT NULL,
   [admin_company_id] [int] NOT NULL,
   [isSingleSignOn] [bit] NULL

   ,CONSTRAINT [PK_PARTNER_ACCOUNTS] PRIMARY KEY CLUSTERED ([PARTNER_ID])
)


GO
CREATE TABLE [dbo].[partner_allergy_transmittals] (
   [at_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NOT NULL,
   [allergy_type] [int] NOT NULL,
   [operation] [char](2) NOT NULL,
   [partner_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL

   ,CONSTRAINT [PK_partner_allergy_transmittals] PRIMARY KEY CLUSTERED ([at_id])
)


GO
CREATE TABLE [dbo].[passwords_change_log] (
   [pcl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_password] [varchar](50) NOT NULL,
   [password_create_date] [smalldatetime] NOT NULL,
   [password_ascii_strength] [int] NOT NULL,
   [user_type] [int] NOT NULL

   ,CONSTRAINT [PK_passwords_change_log] PRIMARY KEY CLUSTERED ([pcl_id])
)


GO
CREATE TABLE [dbo].[PatientCarePlan] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [EffectiveDate] [datetime] NULL,
   [Text] [text] NULL,
   [CreatedUserId] [int] NULL,
   [CreatedTimestamp] [datetime] NULL,
   [LastModifiedUserId] [int] NULL,
   [LastModifiedTimestamp] [datetime] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientCarePlan] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [Index_PatientCarePlan_EncounterId] ON [dbo].[PatientCarePlan] ([EncounterId])
CREATE NONCLUSTERED INDEX [Index_PatientCarePlan_PatientId] ON [dbo].[PatientCarePlan] ([PatientId])

GO
CREATE TABLE [dbo].[PatientCareTeamMember] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [FirstName] [varchar](100) NOT NULL,
   [License] [varchar](30) NULL,
   [RoleDescription] [varchar](150) NULL,
   [PhoneNumber] [varchar](20) NULL,
   [Email] [varchar](100) NULL,
   [AddressId] [bigint] NULL,
   [StatusId] [int] NULL,
   [RoleCode] [varchar](20) NULL,
   [LastName] [varchar](100) NOT NULL,
   [Name] [varchar](100) NULL,
   [CreatedDate] [datetime] NOT NULL,
   [CreatedBy] [int] NOT NULL,
   [LastModifiedDate] [datetime] NULL,
   [LastModifiedBy] [int] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientCareTeamMember_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[PatientCareTeamMemberStatus] (
   [Id] [int] NOT NULL,
   [Description] [varchar](150) NOT NULL

   ,CONSTRAINT [PK_CareTeamMemberStatus_Id] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[PatientFullExportRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NULL,
   [DoctorGroupId] [bigint] NULL,
   [DoctorCompanyId] [bigint] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL,
   [FileName] [varchar](100) NULL,
   [FilePassword] [varchar](100) NULL,
   [ProcessedDate] [datetime] NULL
)


GO
CREATE TABLE [dbo].[PatientGoals] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [EffectiveDate] [datetime] NULL,
   [Text] [text] NULL,
   [CreatedUserId] [int] NULL,
   [CreatedTimestamp] [datetime] NULL,
   [LastModifiedUserId] [int] NULL,
   [LastModifiedTimestamp] [datetime] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientGoals] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [Index_PatientGoals_EncounterId] ON [dbo].[PatientGoals] ([EncounterId])
CREATE NONCLUSTERED INDEX [Index_PatientGoals_PatientId] ON [dbo].[PatientGoals] ([PatientId])

GO
CREATE TABLE [dbo].[PatientHealthConcerns] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [EffectiveDate] [datetime] NULL,
   [Text] [text] NULL,
   [CreatedUserId] [int] NULL,
   [CreatedTimestamp] [datetime] NULL,
   [LastModifiedUserId] [int] NULL,
   [LastModifiedTimestamp] [datetime] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientHealthConcerns] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [Index_PatientHealthConcerns_EncounterId] ON [dbo].[PatientHealthConcerns] ([EncounterId])
CREATE NONCLUSTERED INDEX [Index_PatientHealthConcerns_PatientId] ON [dbo].[PatientHealthConcerns] ([PatientId])

GO
CREATE TABLE [dbo].[PatientImportFiles] (
   [PIFileID] [int] NOT NULL
      IDENTITY (1,1),
   [PIFileExtension] [varchar](10) NOT NULL,
   [PIFileDelimiter] [varchar](10) NOT NULL,
   [PIFileUserID] [varchar](50) NOT NULL,
   [PIFileImportComplete] [bit] NOT NULL,
   [PIFileUploadDateTime] [datetime] NOT NULL,
   [PIFileImportDateTime] [datetime] NULL,
   [PIFileFirstRowIsFieldNames] [bit] NOT NULL,
   [PIFileUserFieldMapIndexes] [varchar](200) NOT NULL

   ,CONSTRAINT [PK_PatientImportFiles] PRIMARY KEY CLUSTERED ([PIFileID])
)


GO
CREATE TABLE [dbo].[PatientImportPatientFields] (
   [PIFieldID] [int] NOT NULL
      IDENTITY (1,1),
   [PIFieldNameInPatientsTable] [varchar](100) NULL,
   [PIFieldSortOrder] [int] NULL,
   [PIFieldFriendlyName] [varchar](200) NULL,
   [PIFieldRequired] [bit] NULL

   ,CONSTRAINT [PK_PatientImportPatientFields] PRIMARY KEY CLUSTERED ([PIFieldID])
)


GO
CREATE TABLE [dbo].[patients] (
   [pa_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_field_not_used1] [int] NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](61) NULL,
   [pa_ssn] [varchar](50) NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](80) NOT NULL,
   [pa_wgt] [int] NOT NULL,
   [pa_sex] [varchar](1) NOT NULL,
   [ic_id] [int] NOT NULL,
   [ic_group_numb] [varchar](30) NOT NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](50) NOT NULL,
   [card_holder_mi] [varchar](1) NOT NULL,
   [card_holder_last] [varchar](50) NOT NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](30) NOT NULL,
   [primary_pharm_id] [int] NULL,
   [pa_notes] [varchar](255) NULL,
   [ph_drugs] [varchar](100) NULL,
   [pa_email] [varchar](80) NULL,
   [pa_ext] [varchar](10) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [last_check_date] [smalldatetime] NOT NULL,
   [check_eligibility] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_patid] [varchar](50) NULL,
   [pa_ht] [int] NOT NULL,
   [pa_upd_stat] [smallint] NULL,
   [pa_flag] [tinyint] NULL,
   [pa_ext_id] [varchar](20) NULL,
   [access_date] [datetime] NULL,
   [access_user] [int] NULL,
   [pa_ins_type] [tinyint] NULL,
   [pa_race_type] [tinyint] NULL,
   [pa_ethn_type] [tinyint] NULL,
   [pref_lang] [smallint] NULL,
   [add_date] [smalldatetime] NULL,
   [add_by_user] [int] NULL,
   [record_modified_date] [datetime] NULL,
   [pa_ext_ssn_no] [varchar](25) NULL,
   [pa_prefix] [varchar](10) NULL,
   [pa_suffix] [varchar](10) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [OwnerType] [varchar](5) NULL,
   [pa_birthName] [varchar](50) NULL,
   [InformationBlockingReasonId] [int] NULL,
   [FhirDataEnabled] [bit] NULL,
   [FhirDataEnabledAt] [datetime] NULL

   ,CONSTRAINT [PK_patients] PRIMARY KEY NONCLUSTERED ([pa_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patients_23_1234207547__K1_K7_5_8_9_10_12_13_14_17] ON [dbo].[patients] ([pa_id], [pa_last]) INCLUDE ([pa_address1], [pa_city], [pa_dob], [pa_first], [pa_sex], [pa_ssn], [pa_state], [pa_zip])
CREATE NONCLUSTERED INDEX [_dta_index_patients_7_207391858__K3_K5_1_2_4_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33_] ON [dbo].[patients] ([dg_id], [pa_first]) INCLUDE ([alternative_id], [card_holder_first], [card_holder_id], [card_holder_last], [card_holder_mi], [check_eligibility], [def_ins_id], [dr_id], [formulary_id], [ic_group_numb], [ic_id], [ic_plan_numb], [ins_person_code], [ins_relate_code], [last_check_date], [pa_address1], [pa_address2], [pa_bin], [pa_city], [pa_dob], [pa_email], [pa_ext], [pa_field_not_used1], [pa_ht], [pa_id], [pa_last], [pa_middle], [pa_notes], [pa_phone], [pa_sex], [pa_ssn], [pa_state], [pa_upd_stat], [pa_wgt], [pa_zip], [pbm_member_id], [ph_drugs], [primary_pharm_id], [rxhub_pbm_id], [sfi_is_sfi], [sfi_patid])
CREATE UNIQUE NONCLUSTERED INDEX [IX_Patient_Last_check_date] ON [dbo].[patients] ([pa_id], [last_check_date])
CREATE NONCLUSTERED INDEX [IX_patients-pa_dob-incld] ON [dbo].[patients] ([pa_dob]) INCLUDE ([dg_id], [pa_address1], [pa_address2], [pa_city], [pa_email], [pa_ethn_type], [pa_ext_ssn_no], [pa_first], [pa_flag], [pa_id], [pa_ins_type], [pa_last], [pa_middle], [pa_phone], [pa_race_type], [pa_sex], [pa_ssn], [pa_state], [pa_zip], [pref_lang])
CREATE CLUSTERED INDEX [IX_Patients-Pa_Last-Pa_Id] ON [dbo].[patients] ([pa_last], [pa_id])

GO
CREATE TABLE [dbo].[patients_20447] (
   [pa_id] [int] NULL,
   [pa_field_not_used1] [int] NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](61) NULL,
   [pa_ssn] [varchar](50) NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [pa_wgt] [int] NOT NULL,
   [pa_sex] [varchar](1) NOT NULL,
   [ic_id] [int] NOT NULL,
   [ic_group_numb] [varchar](30) NOT NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](50) NOT NULL,
   [card_holder_mi] [varchar](1) NOT NULL,
   [card_holder_last] [varchar](50) NOT NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](30) NOT NULL,
   [primary_pharm_id] [int] NULL,
   [pa_notes] [varchar](255) NULL,
   [ph_drugs] [varchar](100) NULL,
   [pa_email] [varchar](80) NULL,
   [pa_ext] [varchar](10) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [last_check_date] [smalldatetime] NOT NULL,
   [check_eligibility] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_patid] [varchar](50) NULL,
   [pa_ht] [int] NOT NULL,
   [pa_upd_stat] [smallint] NULL,
   [pa_flag] [tinyint] NULL,
   [pa_ext_id] [varchar](20) NULL,
   [access_date] [datetime] NULL,
   [access_user] [int] NULL,
   [pa_ins_type] [tinyint] NULL,
   [pa_race_type] [tinyint] NULL,
   [pa_ethn_type] [tinyint] NULL,
   [pref_lang] [smallint] NULL,
   [add_date] [smalldatetime] NULL,
   [add_by_user] [int] NULL,
   [record_modified_date] [datetime] NULL,
   [pa_ext_ssn_no] [varchar](25) NULL,
   [pa_prefix] [varchar](10) NULL,
   [pa_suffix] [varchar](10) NULL
)


GO
CREATE TABLE [dbo].[patients_coverage_info] (
   [pci_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ic_group_numb] [varchar](60) NULL,
   [card_holder_id] [varchar](60) NULL,
   [card_holder_first] [varchar](100) NULL,
   [card_holder_mi] [varchar](50) NULL,
   [card_holder_last] [varchar](100) NULL,
   [ic_plan_numb] [varchar](60) NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](60) NULL,
   [pa_notes] [varchar](255) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [mail_order_coverage] [varchar](5) NULL,
   [retail_pharmacy_coverage] [varchar](5) NULL,
   [formulary_type] [tinyint] NOT NULL,
   [add_date] [smalldatetime] NULL,
   [copay_id] [varchar](40) NOT NULL,
   [coverage_id] [varchar](40) NOT NULL,
   [ic_plan_name] [varchar](100) NULL,
   [PA_ADDRESS1] [varchar](100) NULL,
   [PA_ADDRESS2] [varchar](100) NULL,
   [PA_CITY] [varchar](50) NULL,
   [PA_STATE] [varchar](50) NULL,
   [PA_ZIP] [varchar](50) NULL,
   [PA_DOB] [smalldatetime] NULL,
   [PA_SEX] [varchar](1) NULL,
   [card_suffix] [varchar](10) NULL,
   [pa_diff_info] [bit] NULL,
   [longterm_pharmacy_coverage] [varchar](5) NULL,
   [specialty_pharmacy_coverage] [varchar](5) NULL,
   [prim_payer] [varchar](50) NULL,
   [sec_payer] [varchar](50) NULL,
   [ter_payer] [varchar](50) NULL,
   [ss_pbm_name] [varchar](100) NULL,
   [transaction_message_id] [varchar](50) NULL,
   [PCN] [varchar](80) NULL,
   [ic_group_name] [varchar](100) NULL

   ,CONSTRAINT [PK_patients_coverage_info] PRIMARY KEY CLUSTERED ([pci_id])
)

CREATE NONCLUSTERED INDEX [_dta_coverage1] ON [dbo].[patients_coverage_info] ([pa_id], [formulary_type])

GO
CREATE TABLE [dbo].[patients_coverage_info_external] (
   [pci_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ic_group_numb] [varchar](60) NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](100) NULL,
   [card_holder_mi] [varchar](50) NULL,
   [card_holder_last] [varchar](100) NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](60) NULL,
   [pa_notes] [varchar](255) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [mail_order_coverage] [varchar](5) NULL,
   [retail_pharmacy_coverage] [varchar](5) NULL,
   [formulary_type] [tinyint] NOT NULL,
   [add_date] [smalldatetime] NULL,
   [copay_id] [varchar](40) NOT NULL,
   [coverage_id] [varchar](40) NOT NULL,
   [ic_plan_name] [varchar](100) NULL,
   [PA_ADDRESS1] [varchar](100) NULL,
   [PA_ADDRESS2] [varchar](100) NULL,
   [PA_CITY] [varchar](50) NULL,
   [PA_STATE] [varchar](50) NULL,
   [PA_ZIP] [varchar](50) NULL,
   [PA_DOB] [smalldatetime] NULL,
   [PA_SEX] [varchar](1) NULL,
   [card_suffix] [varchar](10) NULL,
   [pa_diff_info] [bit] NULL,
   [longterm_pharmacy_coverage] [varchar](5) NULL,
   [specialty_pharmacy_coverage] [varchar](5) NULL,
   [prim_payer] [varchar](50) NULL,
   [sec_payer] [varchar](50) NULL,
   [ter_payer] [varchar](50) NULL,
   [ss_pbm_name] [varchar](100) NULL,
   [transaction_message_id] [varchar](50) NULL,
   [ic_group_name] [varchar](100) NULL

   ,CONSTRAINT [PK_patients_coverage_info_external] PRIMARY KEY CLUSTERED ([pci_id])
)

CREATE NONCLUSTERED INDEX [ix_patients_coverage_info_external_pa_id] ON [dbo].[patients_coverage_info_external] ([pa_id])

GO
CREATE TABLE [dbo].[patients_fav_pharms] (
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_use_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patients_fav_pharms] PRIMARY KEY NONCLUSTERED ([pa_id], [pharm_id])
   ,CONSTRAINT [uq_patients_fav_pharms] UNIQUE NONCLUSTERED ([pa_id], [pharm_id])
)

CREATE CLUSTERED INDEX [patients_fav_pharms2] ON [dbo].[patients_fav_pharms] ([pharm_use_date])

GO
CREATE TABLE [dbo].[patients_medcare_coverage] (
   [pa_medcare_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [CONTRACT_ID] [varchar](10) NOT NULL,
   [PLAN_ID] [varchar](5) NOT NULL,
   [SEGMENT_ID] [varchar](5) NOT NULL,
   [PLAN_NAME] [varchar](50) NOT NULL,
   [FORMULARY_ID] [varchar](10) NOT NULL,
   [MA_REGION_CODE] [varchar](5) NOT NULL,
   [PDP_REGION_CODE] [varchar](5) NOT NULL,
   [State] [varchar](2) NOT NULL

   ,CONSTRAINT [PK_patients_medcare_coverage] PRIMARY KEY NONCLUSTERED ([pa_id])
)


GO
CREATE TABLE [dbo].[patients_member_info] (
   [pmi_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pbm_member_id] [varchar](80) NULL,
   [add_date] [smalldatetime] NULL,
   [pharm_id] [int] NOT NULL

   ,CONSTRAINT [PK_patients_member_info] PRIMARY KEY CLUSTERED ([pmi_id])
)


GO
CREATE TABLE [dbo].[patients_merge_back] (
   [pa_id] [int] NOT NULL,
   [pa_field_not_used1] [int] NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_ssn] [varchar](20) NOT NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [pa_wgt] [int] NOT NULL,
   [pa_sex] [varchar](1) NOT NULL,
   [ic_id] [int] NOT NULL,
   [ic_group_numb] [varchar](30) NOT NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](50) NOT NULL,
   [card_holder_mi] [varchar](1) NOT NULL,
   [card_holder_last] [varchar](50) NOT NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [ins_relate_code] [varchar](4) NOT NULL,
   [ins_person_code] [varchar](4) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [alternative_id] [varchar](30) NOT NULL,
   [pa_bin] [varchar](30) NOT NULL,
   [primary_pharm_id] [int] NULL,
   [pa_notes] [varchar](255) NULL,
   [ph_drugs] [varchar](100) NULL,
   [pa_email] [varchar](80) NULL,
   [pa_ext] [varchar](10) NULL,
   [rxhub_pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [def_ins_id] [int] NOT NULL,
   [last_check_date] [smalldatetime] NOT NULL,
   [check_eligibility] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_patid] [varchar](50) NULL,
   [pa_ht] [int] NOT NULL,
   [pa_upd_stat] [smallint] NULL,
   [pa_flag] [tinyint] NULL,
   [pa_ext_id] [varchar](20) NULL,
   [access_date] [datetime] NULL,
   [access_user] [int] NULL,
   [pa_ins_type] [tinyint] NULL,
   [pa_race_type] [tinyint] NULL,
   [pa_ethn_type] [tinyint] NULL,
   [pref_lang] [smallint] NULL,
   [add_date] [smalldatetime] NULL,
   [add_by_user] [int] NULL,
   [record_modified_date] [datetime] NULL,
   [pa_ext_ssn_no] [varchar](25) NULL,
   [pa_prefix] [varchar](10) NULL,
   [pa_suffix] [varchar](10) NULL

   ,CONSTRAINT [PK_patients_merge] PRIMARY KEY NONCLUSTERED ([pa_id])
)


GO
CREATE TABLE [dbo].[patients_queue_to_external_application] (
   [pa_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL,
   [rxnt_status_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [completed_date] [datetime] NULL

   ,CONSTRAINT [PK_patients_queue_to_external_application] PRIMARY KEY CLUSTERED ([pa_id])
)


GO
CREATE TABLE [dbo].[PatientTokens] (
   [PatientTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_PatientTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_PatientTokens] PRIMARY KEY CLUSTERED ([PatientTokenId])
)


GO
CREATE TABLE [dbo].[PatientUnmergeRequests] (
   [PatientUnmergeRequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_merge_batchid] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [StatusId] [int] NOT NULL,
   [CheckBatchId] [bit] NULL,
   [Comments] [varchar](max) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL

   ,CONSTRAINT [PK_PatientUnmergeRequests] PRIMARY KEY CLUSTERED ([PatientUnmergeRequestId])
)


GO
CREATE TABLE [dbo].[patient_activemeds_deleted] (
   [pam_delete_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [delete_date] [smalldatetime] NOT NULL,
   [deleted_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_activemeds_deleted] PRIMARY KEY CLUSTERED ([pam_delete_id])
)


GO
CREATE TABLE [dbo].[patient_active_diagnosis] (
   [pad] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [icd9] [varchar](100) NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [icd9_description] [varchar](255) NULL,
   [enabled] [tinyint] NOT NULL,
   [onset] [datetime] NULL,
   [severity] [varchar](50) NULL,
   [status] [varchar](10) NULL,
   [type] [smallint] NULL,
   [record_modified_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [status_date] [datetime] NULL,
   [code_type] [varchar](50) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [icd9_desc] [varchar](255) NULL,
   [icd10_desc] [varchar](255) NULL,
   [icd10] [varchar](100) NULL,
   [snomed_code] [varchar](100) NULL,
   [snomed_desc] [varchar](255) NULL,
   [diagnosis_sequence] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_diagnosis] PRIMARY KEY CLUSTERED ([pad], [pa_id])
)

CREATE NONCLUSTERED INDEX [idx_PatientActiveDiagnosis_AddedBy_DateAdded] ON [dbo].[patient_active_diagnosis] ([added_by_dr_id], [date_added]) INCLUDE ([icd10], [icd9], [pa_id], [pad], [snomed_code])
CREATE NONCLUSTERED INDEX [IX_patient_active_diagnosis_icd9] ON [dbo].[patient_active_diagnosis] ([pa_id], [icd9])
CREATE NONCLUSTERED INDEX [IX_patient_active_diagnosis-icd9_description-enabled] ON [dbo].[patient_active_diagnosis] ([icd9_description], [enabled]) INCLUDE ([pa_id])

GO
CREATE TABLE [dbo].[patient_active_diagnosis_external] (
   [pde_id] [int] NOT NULL
      IDENTITY (1,1),
   [pde_pa_id] [int] NOT NULL,
   [pde_source_name] [varchar](200) NOT NULL,
   [pde_icd9] [varchar](100) NOT NULL,
   [pde_added_by_dr_id] [int] NULL,
   [pde_date_added] [datetime] NOT NULL,
   [pde_icd9_description] [varchar](200) NOT NULL,
   [pde_enabled] [tinyint] NOT NULL,
   [pde_onset] [datetime] NULL,
   [pde_severity] [varchar](50) NULL,
   [pde_status] [varchar](10) NULL,
   [pde_type] [smallint] NULL,
   [pde_record_modified_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pde_icd10] [varchar](100) NULL,
   [pde_snomed] [varchar](100) NULL,
   [pde_icd10_description] [varchar](500) NULL,
   [pde_snomed_description] [varchar](500) NULL,
   [is_from_ccd] [bit] NULL

   ,CONSTRAINT [PK_patient_active_diagnosis_external] PRIMARY KEY CLUSTERED ([pde_id])
)


GO
CREATE TABLE [dbo].[patient_active_meds] (
   [pam_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [from_pd_id] [int] NOT NULL,
   [compound] [bit] NOT NULL,
   [comments] [varchar](255) NULL,
   [status] [tinyint] NULL,
   [dt_status_change] [datetime] NULL,
   [change_dr_id] [int] NULL,
   [reason] [varchar](150) NULL,
   [drug_name] [varchar](200) NULL,
   [dosage] [varchar](255) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [drug_comments] [varchar](255) NULL,
   [numb_refills] [int] NULL,
   [use_generic] [int] NULL,
   [days_supply] [smallint] NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [date_start] [datetime] NULL,
   [date_end] [datetime] NULL,
   [for_dr_id] [int] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [order_reason] [varchar](500) NULL,
   [rxnorm_code] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds] PRIMARY KEY CLUSTERED ([pam_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patient_active_meds_7_1790017508__K2_K1_K3_K5_4_7] ON [dbo].[patient_active_meds] ([pa_id], [pam_id], [drug_id], [added_by_dr_id]) INCLUDE ([date_added], [compound])
CREATE NONCLUSTERED INDEX [_dta_index_patient_active_meds_7_1790017508__K2_K3_K1_K5_4_6_7_8_13_14_15_16_17_18_19_20_21_22_23_24_27] ON [dbo].[patient_active_meds] ([pa_id], [drug_id], [pam_id], [added_by_dr_id]) INCLUDE ([comments], [compound], [date_added], [date_end], [date_start], [days_supply], [dosage], [drug_comments], [drug_name], [duration_amount], [duration_unit], [from_pd_id], [numb_refills], [prn], [prn_description], [record_source], [use_generic])
CREATE NONCLUSTERED INDEX [idx_Patient_active_med] ON [dbo].[patient_active_meds] ([added_by_dr_id], [date_added]) INCLUDE ([drug_id], [pa_id], [pam_id])
CREATE UNIQUE NONCLUSTERED INDEX [NoDupeMeds] ON [dbo].[patient_active_meds] ([pa_id], [drug_id], [compound], [drug_name])

GO
CREATE TABLE [dbo].[patient_active_meds_external] (
   [pame_id] [int] NOT NULL
      IDENTITY (1,1),
   [pame_pa_id] [int] NOT NULL,
   [pame_drug_id] [int] NOT NULL,
   [pame_date_added] [datetime] NOT NULL,
   [pame_compound] [bit] NOT NULL,
   [pame_comments] [varchar](255) NULL,
   [pame_status] [tinyint] NULL,
   [pame_drug_name] [varchar](200) NULL,
   [pame_dosage] [varchar](255) NULL,
   [pame_duration_amount] [varchar](15) NULL,
   [pame_duration_unit] [varchar](80) NULL,
   [pame_drug_comments] [varchar](255) NULL,
   [pame_numb_refills] [int] NULL,
   [pame_use_generic] [int] NULL,
   [pame_days_supply] [smallint] NULL,
   [pame_prn] [bit] NULL,
   [pame_prn_description] [varchar](50) NULL,
   [pame_date_start] [datetime] NULL,
   [pame_date_end] [datetime] NULL,
   [pame_source_name] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [external_id] [varchar](100) NULL,
   [rxnorm_code] [varchar](100) NULL,
   [is_from_ccd] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds_external] PRIMARY KEY CLUSTERED ([pame_id])
)

CREATE NONCLUSTERED INDEX [ix_patient_active_meds_external_pame_pa_id_pame_source_name_external_id] ON [dbo].[patient_active_meds_external] ([pame_pa_id], [pame_source_name], [external_id])

GO
CREATE TABLE [dbo].[patient_alerts] (
   [rule_prf_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [rule_id] [int] NOT NULL,
   [dt_performed] [smalldatetime] NULL,
   [dr_performed_by] [int] NULL,
   [alert_response] [smallint] NULL,
   [notes] [varchar](max) NULL,
   [Status] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_alerts] PRIMARY KEY CLUSTERED ([rule_prf_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patient_alerts_7_756301854__K4_K1_K2] ON [dbo].[patient_alerts] ([dt_performed], [rule_prf_id], [pa_id])
CREATE NONCLUSTERED INDEX [IX_patient_alerts] ON [dbo].[patient_alerts] ([pa_id])
CREATE NONCLUSTERED INDEX [IX_Patient_Alerts-Rule_id] ON [dbo].[patient_alerts] ([rule_id]) INCLUDE ([dt_performed], [pa_id])

GO
CREATE TABLE [dbo].[patient_allergies] (
   [pa_allergy_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NOT NULL,
   [allergy_type] [smallint] NOT NULL,
   [reaction_string] [varchar](100) NULL,
   [comments] [varchar](100) NULL,
   [add_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_patient_allergies] PRIMARY KEY CLUSTERED ([pa_allergy_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [UniqueAllergies] ON [dbo].[patient_allergies] ([pa_id], [allergy_id], [allergy_type])

GO
CREATE TABLE [dbo].[patient_allergy_type] (
   [patient_allergy_type_id] [int] NULL,
   [allergy_type] [int] NULL,
   [allergy_type_desc] [varchar](50) NULL
)


GO
CREATE TABLE [dbo].[patient_appointment_request] (
   [pat_appt_req_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [req_appt_date] [varchar](20) NOT NULL,
   [req_appt_time] [varchar](20) NOT NULL,
   [primary_reason] [varchar](max) NOT NULL,
   [is_completed] [bit] NOT NULL,
   [created_datetime] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_appointment_request] PRIMARY KEY CLUSTERED ([pat_appt_req_id])
)


GO
CREATE TABLE [dbo].[patient_assessment] (
   [ass_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [diagnosis] [varchar](15) NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_assessment] PRIMARY KEY CLUSTERED ([ass_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_assessment] ON [dbo].[patient_assessment] ([enc_id])

GO
CREATE TABLE [dbo].[patient_assessment_template] (
   [ass_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [diagnosis] [varchar](15) NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_assessment_template] PRIMARY KEY CLUSTERED ([ass_id])
)


GO
CREATE TABLE [dbo].[patient_bglucose] (
   [pa_glc_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_glucose] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_bglucose] PRIMARY KEY CLUSTERED ([pa_glc_id])
)


GO
CREATE TABLE [dbo].[patient_bp] (
   [pa_bp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_sys] [float] NOT NULL,
   [pa_dys] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_bp] PRIMARY KEY CLUSTERED ([pa_bp_id])
)


GO
CREATE TABLE [dbo].[patient_care_providers] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [prv_fav_id] [int] NOT NULL,
   [enable] [bit] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_care_providers] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[Patient_CCD_import_requests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [updated_on] [datetime] NOT NULL,
   [ccd_file_location] [varchar](max) NULL,
   [max_retry_count] [int] NOT NULL,
   [status] [int] NOT NULL,
   [requested_by] [bigint] NOT NULL,
   [requested_on] [datetime] NOT NULL,
   [comments] [varchar](max) NULL

   ,CONSTRAINT [PK_Patient_CCD_imoprt_requests] PRIMARY KEY CLUSTERED ([request_id])
)


GO
CREATE TABLE [dbo].[Patient_CCD_import_request_details] (
   [request_detail_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [ccd_file_name] [varchar](max) NULL,
   [pa_id] [int] NULL,
   [request_id] [bigint] NOT NULL,
   [status] [int] NOT NULL,
   [max_retry_count] [int] NOT NULL,
   [created_on] [datetime] NOT NULL,
   [updated_on] [datetime] NULL,
   [status_message] [varchar](max) NULL

   ,CONSTRAINT [PK_Patient_CCD_imoprt_request_details] PRIMARY KEY CLUSTERED ([request_detail_id])
)


GO
CREATE TABLE [dbo].[Patient_CCD_request_batch] (
   [batchid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [batch_name] [varchar](500) NULL,
   [active] [bit] NULL,
   [status] [int] NULL,
   [file_name] [varchar](50) NULL,
   [file_pass] [varchar](50) NULL

   ,CONSTRAINT [PK_Patient_CCD_request_batch] PRIMARY KEY CLUSTERED ([batchid])
)


GO
CREATE TABLE [dbo].[Patient_CCD_request_batch_filter] (
   [batchid] [bigint] NOT NULL,
   [enc_start_date] [datetime] NULL,
   [enc_end_date] [datetime] NULL,
   [enc_dr_id] [bigint] NULL,
   [pat_last_name] [varchar](50) NULL,
   [pat_first_name] [varchar](50) NULL,
   [pat_zip] [varchar](10) NULL,
   [pat_dob] [datetime] NULL,
   [reffered_to_dr_id] [bigint] NULL,
   [reffered_by_name] [varchar](50) NULL,
   [created_by] [bigint] NULL,
   [created_on] [datetime] NULL,
   [is_processed] [bit] NULL,
   [processed_on] [datetime] NULL

   ,CONSTRAINT [PK_Patient_CCD_request_batch_filter] PRIMARY KEY CLUSTERED ([batchid])
)


GO
CREATE TABLE [dbo].[Patient_CCD_request_queue] (
   [reqid] [bigint] NOT NULL
      IDENTITY (1,1),
   [batchid] [bigint] NOT NULL,
   [pa_id] [bigint] NOT NULL,
   [created_date] [datetime] NULL,
   [created_by] [bigint] NULL,
   [modified_date] [datetime] NULL,
   [modified_by] [bigint] NULL,
   [active] [bit] NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_CCD_request_queue] PRIMARY KEY CLUSTERED ([reqid])
)


GO
CREATE TABLE [dbo].[patient_chart_restricted_users] (
   [pcru_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [isRestricted] [bit] NULL

   ,CONSTRAINT [PK_patient_chart_restricted_users] PRIMARY KEY NONCLUSTERED ([pcru_id])
)


GO
CREATE TABLE [dbo].[patient_claims_history] (
   [claims_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [claim_download_date] [datetime] NOT NULL,
   [dr_last_name] [varchar](100) NULL,
   [dr_first_name] [varchar](100) NULL,
   [dr_address1] [varchar](100) NULL,
   [dr_city] [varchar](50) NULL,
   [dr_state] [varchar](2) NULL,
   [dr_zip] [varchar](15) NULL,
   [dr_dea] [varchar](50) NULL,
   [dr_npi] [varchar](50) NULL,
   [dr_phone] [varchar](20) NULL,
   [pharm_name] [varchar](50) NULL,
   [pharm_address1] [varchar](150) NULL,
   [pharm_city] [varchar](50) NULL,
   [pharm_state] [varchar](2) NULL,
   [pharm_zip] [varchar](15) NULL,
   [pharm_ncpdp] [varchar](50) NULL,
   [pharm_fax] [varchar](20) NULL,
   [pharm_phone] [varchar](20) NULL,
   [ddid] [int] NOT NULL,
   [ndc] [varchar](20) NOT NULL,
   [rxnorm] [varchar](50) NULL,
   [drug_name] [varchar](210) NULL,
   [dosage] [varchar](200) NULL,
   [numb_refills] [smallint] NULL,
   [entry_date] [datetime] NULL,
   [start_date] [datetime] NULL,
   [end_date] [datetime] NULL,
   [last_fill_date] [datetime] NULL,
   [days_supply] [smallint] NULL,
   [quantity] [varchar](50) NULL,
   [quantity_units] [varchar](50) NULL,
   [remaining_amount] [varchar](50) NULL,
   [received_amount] [varchar](50) NULL,
   [use_generic] [bit] NULL,
   [comments] [varchar](255) NULL

   ,CONSTRAINT [PK_patient_claims_history] PRIMARY KEY CLUSTERED ([claims_id])
)


GO
CREATE TABLE [dbo].[patient_comm_pref] (
   [pa_id] [int] NOT NULL,
   [comm_pref] [int] NOT NULL,
   [cell_phone] [varchar](20) NULL,
   [email] [varchar](20) NULL

   ,CONSTRAINT [PK_patient_comm_pref] PRIMARY KEY CLUSTERED ([pa_id])
)


GO
CREATE TABLE [dbo].[patient_consent] (
   [consent_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_consent] PRIMARY KEY CLUSTERED ([consent_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [PA_DR_INDX] ON [dbo].[patient_consent] ([pa_id], [dr_id])

GO
CREATE TABLE [dbo].[patient_documents] (
   [document_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [description] [varchar](225) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [cat_id] [smallint] NOT NULL,
   [owner_id] [bigint] NULL,
   [owner_type] [varchar](3) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [comment] [varchar](500) NULL,
   [document_date] [datetime] NULL,
   [enc_id] [bigint] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_patient_documents] PRIMARY KEY CLUSTERED ([document_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_documents] ON [dbo].[patient_documents] ([pat_id], [upload_date] DESC)
CREATE NONCLUSTERED INDEX [IX_patient_documents_1] ON [dbo].[patient_documents] ([cat_id])

GO
CREATE TABLE [dbo].[patient_documents_26224] (
   [document_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [description] [varchar](225) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [cat_id] [smallint] NOT NULL,
   [owner_id] [bigint] NULL,
   [owner_type] [varchar](3) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [comment] [varchar](500) NULL,
   [document_date] [datetime] NULL

   ,CONSTRAINT [PK_patient_documents_26224] PRIMARY KEY CLUSTERED ([document_id])
)


GO
CREATE TABLE [dbo].[patient_documents_26224_doc] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [pat_id] [bigint] NULL,
   [FileName] [varchar](255) NULL

   ,CONSTRAINT [PK_patient_documents_26224_doc] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[patient_documents_category] (
   [cat_id] [int] NOT NULL
      IDENTITY (1,1),
   [title] [varchar](255) NOT NULL,
   [dg_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_documents_category] PRIMARY KEY CLUSTERED ([cat_id])
)


GO
CREATE TABLE [dbo].[patient_electronic_forms] (
   [electronic_form_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [description] [varchar](255) NULL,
   [type] [int] NULL,
   [is_reviewed_by_prescriber] [bit] NOT NULL

   ,CONSTRAINT [PK_patient_consent_forms] PRIMARY KEY CLUSTERED ([electronic_form_id])
)


GO
CREATE TABLE [dbo].[patient_encounters] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [encounter_date] [datetime] NOT NULL,
   [chief_complaint] [varchar](2000) NOT NULL,
   [enc_reason] [varchar](30) NOT NULL,
   [added_by_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_encounters] PRIMARY KEY CLUSTERED ([enc_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_encounters] ON [dbo].[patient_encounters] ([pa_id], [dr_id])

GO
CREATE TABLE [dbo].[Patient_Encounter_request_batch] (
   [batchid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [active] [bit] NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_Encounter_request_batch] PRIMARY KEY CLUSTERED ([batchid])
)


GO
CREATE TABLE [dbo].[Patient_Encounter_request_queue] (
   [reqid] [bigint] NOT NULL
      IDENTITY (1,1),
   [batchid] [bigint] NOT NULL,
   [enc_id] [bigint] NOT NULL,
   [created_date] [datetime] NULL,
   [created_by] [bigint] NULL,
   [modified_date] [datetime] NULL,
   [modified_by] [bigint] NULL,
   [active] [bit] NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_Encounter_request_queue] PRIMARY KEY CLUSTERED ([reqid])
)


GO
CREATE TABLE [dbo].[patient_encounter_template] (
   [template_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [enc_reason] [varchar](30) NOT NULL,
   [chief_complaint] [varchar](2000) NOT NULL,
   [template_name] [varchar](100) NOT NULL,
   [last_update_dr_id] [int] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [doc_grp_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_encounter_template] PRIMARY KEY CLUSTERED ([template_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_encounter_template] ON [dbo].[patient_encounter_template] ([dr_id])
CREATE NONCLUSTERED INDEX [IX_patient_encounter_template_1] ON [dbo].[patient_encounter_template] ([doc_grp_id])

GO
CREATE TABLE [dbo].[patient_enc_plan_of_care] (
   [poc_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_plan_of_care] PRIMARY KEY CLUSTERED ([poc_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_enc_plan_of_care] ON [dbo].[patient_enc_plan_of_care] ([enc_id])

GO
CREATE TABLE [dbo].[patient_enc_plan_of_care_template] (
   [poc_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_plan_of_care_template] PRIMARY KEY CLUSTERED ([poc_id])
)


GO
CREATE TABLE [dbo].[patient_ethnicity_details] (
   [pa_ethnicity_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ethnicity_id] [int] NOT NULL,
   [ethnicity_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_ethnicity_details] PRIMARY KEY CLUSTERED ([pa_ethnicity_id])
)


GO
CREATE TABLE [dbo].[patient_extended_details] (
   [pa_id] [int] NOT NULL,
   [pa_ext_ref] [bit] NOT NULL,
   [pa_ref_name_details] [varchar](255) NULL,
   [pa_ref_date] [smalldatetime] NULL,
   [prim_dr_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [cell_phone] [varchar](50) NULL,
   [marital_status] [tinyint] NULL,
   [empl_status] [tinyint] NULL,
   [work_phone] [varchar](50) NULL,
   [other_phone] [varchar](50) NULL,
   [comm_pref] [tinyint] NULL,
   [pref_phone] [tinyint] NULL,
   [time_zone] [varchar](6) NULL,
   [pref_start_time] [time] NULL,
   [pref_end_time] [time] NULL,
   [mother_first] [varchar](35) NULL,
   [mother_middle] [varchar](35) NULL,
   [mother_last] [varchar](35) NULL,
   [pa_death_date] [smalldatetime] NULL,
   [emergency_contact_first] [varchar](35) NULL,
   [emergency_contact_last] [varchar](35) NULL,
   [emergency_contact_address1] [varchar](100) NULL,
   [emergency_contact_address2] [varchar](100) NULL,
   [emergency_contact_city] [varchar](50) NULL,
   [emergency_contact_state] [varchar](2) NULL,
   [emergency_contact_zip] [varchar](20) NULL,
   [emergency_contact_phone] [varchar](20) NULL,
   [emergency_contact_relationship] [varchar](3) NULL,
   [emergency_contact_release_documents] [bit] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [created_by_system] [varchar](50) NULL,
   [pa_phone_ctry_code] [varchar](5) NULL,
   [cell_phone_ctry_code] [varchar](5) NULL,
   [work_phone_ctry_code] [varchar](5) NULL,
   [other_phone_ctry_code] [varchar](5) NULL,
   [pa_phone_dial_code] [varchar](5) NULL,
   [cell_phone_dial_code] [varchar](5) NULL,
   [work_phone_dial_code] [varchar](5) NULL,
   [other_phone_dial_code] [varchar](5) NULL,
   [pa_phone_full] [varchar](30) NULL,
   [cell_phone_full] [varchar](30) NULL,
   [work_phone_full] [varchar](30) NULL,
   [other_phone_full] [varchar](30) NULL,
   [restricted_access] [int] NULL,
   [pa_sexual_orientation] [tinyint] NULL,
   [pa_sexual_orientation_detail] [varchar](200) NULL,
   [pa_gender_identity_detail] [varchar](200) NULL,
   [pa_gender_identity] [tinyint] NULL,
   [pa_death_cause] [varchar](100) NULL,
   [pa_nick_name] [varchar](50) NULL,
   [is_patient_intake_sync_review_pending] [bit] NULL,
   [pa_previous_name] [varchar](50) NULL,
   [pa_previous_address_1] [varchar](100) NULL,
   [pa_previous_address_2] [varchar](100) NULL,
   [pa_previous_address_state] [varchar](2) NULL,
   [pa_previous_address_city] [varchar](50) NULL,
   [pa_previous_address_zip] [varchar](20) NULL

   ,CONSTRAINT [PK_patient_extended_details] PRIMARY KEY CLUSTERED ([pa_id])
)


GO
CREATE TABLE [dbo].[patient_external_ccd_reconciliation_info] (
   [reconciliation_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [is_medication_reconciled] [bit] NULL,
   [is_allergy_reconciled] [bit] NULL,
   [is_problem_reconciled] [bit] NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_external_ccd_reconciliation_info] PRIMARY KEY CLUSTERED ([reconciliation_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_external_ccd_reconciliation_info] ON [dbo].[patient_external_ccd_reconciliation_info] ([pa_id])

GO
CREATE TABLE [dbo].[patient_family_history] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_family_history] PRIMARY KEY CLUSTERED ([history_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_family_history] ON [dbo].[patient_family_history] ([dr_id], [pa_id], [added_by_dr_id])

GO
CREATE TABLE [dbo].[patient_family_history_template] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_family_history_template] PRIMARY KEY CLUSTERED ([history_id])
)


GO
CREATE TABLE [dbo].[patient_family_hx] (
   [fhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NOT NULL,
   [member_relation_id] [int] NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [icd10] [varchar](max) NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [LivingStatus] [varchar](50) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_family_hx] PRIMARY KEY CLUSTERED ([fhxid])
)

CREATE NONCLUSTERED INDEX [ix_patient_family_hx_pat_id] ON [dbo].[patient_family_hx] ([pat_id])
CREATE NONCLUSTERED INDEX [ix_patient_family_hx_pat_id_enable] ON [dbo].[patient_family_hx] ([pat_id], [enable])
CREATE NONCLUSTERED INDEX [patient_family_hx_paid] ON [dbo].[patient_family_hx] ([fhxid], [pat_id])

GO
CREATE TABLE [dbo].[patient_family_hx_external] (
   [pfhe_fhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pfhe_pat_id] [bigint] NOT NULL,
   [pfhe_member_relation_id] [int] NULL,
   [pfhe_problem] [varchar](max) NULL,
   [pfhe_icd9] [varchar](50) NULL,
   [pfhe_dr_id] [bigint] NULL,
   [pfhe_added_by_dr_id] [bigint] NULL,
   [pfhe_created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [pfhe_comments] [varchar](max) NULL,
   [pfhe_enable] [bit] NOT NULL,
   [pfhe_active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pfhe_icd10] [varchar](max) NULL,
   [pfhe_icd9_description] [varchar](max) NULL,
   [pfhe_icd10_description] [varchar](max) NULL,
   [pfhe_snomed] [varchar](max) NULL,
   [pfhe_snomed_description] [varchar](max) NULL

   ,CONSTRAINT [PK_patient_family_hx_external] PRIMARY KEY CLUSTERED ([pfhe_fhxid])
)


GO
CREATE TABLE [dbo].[patient_flags] (
   [flag_id] [int] NOT NULL
      IDENTITY (1,1),
   [flag_title] [varchar](50) NOT NULL,
   [is_enabled] [bit] NOT NULL,
   [dc_id] [int] NOT NULL,
   [hide_on_search] [bit] NULL,
   [parent_flag_id] [int] NULL

   ,CONSTRAINT [PK_patient_flags] PRIMARY KEY CLUSTERED ([flag_id])
)


GO
CREATE TABLE [dbo].[patient_flag_details] (
   [pa_flag_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [flag_id] [int] NOT NULL,
   [flag_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_flag_details] PRIMARY KEY CLUSTERED ([pa_flag_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_flag_details-pa_id-flag_id] ON [dbo].[patient_flag_details] ([pa_id], [flag_id])

GO
CREATE TABLE [dbo].[patient_flag_details_backup] (
   [pa_flag_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [flag_id] [int] NOT NULL,
   [flag_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL
)


GO
CREATE TABLE [dbo].[patient_flag_inactiveindicator] (
   [flag_id] [int] NOT NULL
      IDENTITY (1,1),
   [is_enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_patient_flag_inactiveindicator] PRIMARY KEY CLUSTERED ([flag_id])
)


GO
CREATE TABLE [dbo].[patient_gender_identity_snomed] (
   [gender_identity_snomed_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_gender_identity_id] [int] NOT NULL,
   [pa_gender_identity] [varchar](75) NULL,
   [snomed_code] [varchar](25) NULL,
   [is_null_flavour] [bit] NULL

   ,CONSTRAINT [PK_patient_gender_identity_snomed] PRIMARY KEY CLUSTERED ([gender_identity_snomed_id])
)


GO
CREATE TABLE [dbo].[patient_height] (
   [pa_ht_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_ht] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_height] PRIMARY KEY CLUSTERED ([pa_ht_id])
)


GO
CREATE TABLE [dbo].[patient_hm_alerts] (
   [rule_prf_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [rule_id] [int] NOT NULL,
   [dt_performed] [smalldatetime] NULL,
   [dr_performed_by] [int] NULL,
   [notes] [varchar](max) NULL,
   [due_date] [datetime] NULL,
   [rxnt_status_id] [int] NULL,
   [date_added] [datetime] NULL,
   [last_edited_on] [datetime] NULL,
   [last_edited_by] [int] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_hm_alerts] PRIMARY KEY CLUSTERED ([rule_prf_id])
)


GO
CREATE TABLE [dbo].[patient_hospitalization_hx] (
   [hosphxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NOT NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_hosp_hx] PRIMARY KEY CLUSTERED ([hosphxid])
)


GO
CREATE TABLE [dbo].[patient_hospitalization_hx_external] (
   [phe_hosphxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [phe_pat_id] [bigint] NOT NULL,
   [phe_problem] [varchar](max) NULL,
   [phe_icd9] [varchar](50) NULL,
   [phe_dr_id] [bigint] NULL,
   [phe_added_by_dr_id] [bigint] NULL,
   [phe_created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [phe_comments] [varchar](max) NULL,
   [phe_enable] [bit] NOT NULL,
   [phe_icd9_description] [varchar](max) NULL,
   [phe_icd10] [varchar](max) NULL,
   [phe_icd10_description] [varchar](max) NULL,
   [phe_snomed] [varchar](max) NULL,
   [phe_snomed_description] [varchar](max) NULL,
   [phe_source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_hospitalization_hx_external] PRIMARY KEY CLUSTERED ([phe_hosphxid])
)


GO
CREATE TABLE [dbo].[patient_hpi] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [location] [varchar](255) NOT NULL,
   [severity] [tinyint] NOT NULL,
   [duration] [varchar](50) NOT NULL,
   [signs] [varchar](1000) NOT NULL,
   [symptoms] [varchar](1000) NOT NULL,
   [note] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_patient_hpi] PRIMARY KEY CLUSTERED ([history_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_hpi] ON [dbo].[patient_hpi] ([enc_id])

GO
CREATE TABLE [dbo].[patient_hpi_template] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [location] [varchar](255) NOT NULL,
   [severity] [tinyint] NOT NULL,
   [duration] [varchar](50) NOT NULL,
   [signs] [varchar](1000) NOT NULL,
   [symptoms] [varchar](1000) NOT NULL,
   [note] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_patient_hpi_template] PRIMARY KEY CLUSTERED ([history_id])
)


GO
CREATE TABLE [dbo].[patient_hx] (
   [pat_hx_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [has_nofhx] [bit] NULL,
   [has_nomedx] [bit] NULL,
   [has_nosurghx] [bit] NULL,
   [fhx_dr_id] [int] NULL,
   [fhx_last_updated_on] [datetime] NULL,
   [fhx_last_updated_by] [int] NULL,
   [medhx_dr_id] [int] NULL,
   [medhx_last_updated_on] [datetime] NULL,
   [medhx_last_updated_by] [int] NULL,
   [surghx_dr_id] [int] NULL,
   [surghx_last_updated_on] [datetime] NULL,
   [surghx_last_updated_by] [int] NULL,
   [has_nohosphx] [bit] NULL,
   [hosphx_dr_id] [int] NULL,
   [hosphx_last_updated_on] [datetime] NULL,
   [hosphx_last_updated_by] [int] NULL
)


GO
CREATE TABLE [dbo].[patient_identifiers] (
   [pa_id] [bigint] NOT NULL,
   [pik_id] [bigint] NOT NULL,
   [value] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_identifiers_1] PRIMARY KEY CLUSTERED ([pa_id], [pik_id])
)


GO
CREATE TABLE [dbo].[patient_identifier_keys] (
   [pik_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [keyname] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_identifier_keys] PRIMARY KEY CLUSTERED ([pik_id])
)


GO
CREATE TABLE [dbo].[patient_immunization_registry_settings] (
   [pa_id] [bigint] NOT NULL,
   [publicity_code] [varchar](2) NULL,
   [publicity_code_effective_date] [datetime] NULL,
   [registry_status] [varchar](2) NULL,
   [registry_status_effective_date] [datetime] NULL,
   [entered_by] [bigint] NULL,
   [dr_id] [bigint] NULL,
   [entered_on] [datetime] NULL,
   [modified_on] [datetime] NULL,
   [protection_indicator] [varchar](1) NULL,
   [protection_indicator_effective_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_immunization_registry_settings] PRIMARY KEY CLUSTERED ([pa_id])
)


GO
CREATE TABLE [dbo].[patient_lab_orders] (
   [pa_lab_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [lab_test_id] [int] NOT NULL,
   [lab_test_name] [varchar](500) NOT NULL,
   [added_date] [datetime] NOT NULL,
   [added_by] [bigint] NOT NULL,
   [order_date] [datetime] NOT NULL,
   [order_status] [smallint] NOT NULL,
   [comments] [varchar](500) NOT NULL,
   [last_edit_by] [bigint] NOT NULL,
   [last_edit_date] [datetime] NOT NULL,
   [from_main_lab_id] [bigint] NOT NULL,
   [recurringinformation] [varchar](500) NULL,
   [diagnosis] [varchar](5000) NULL,
   [urgency] [smallint] NOT NULL,
   [dr_id] [bigint] NULL,
   [isActive] [bit] NULL,
   [sendElectronically] [bit] NULL,
   [external_lab_order_id] [varchar](50) NULL,
   [doc_group_lab_xref_id] [int] NULL,
   [abn_file_path] [varchar](255) NULL,
   [requisition_file_path] [varchar](255) NULL,
   [label_file_path] [varchar](255) NULL,
   [enc_id] [bigint] NULL,
   [lab_master_id] [bigint] NULL,
   [lab_id] [int] NULL,
   [lab_result_info_id] [int] NULL,
   [specimen_time] [datetime] NULL,
   [test_type] [smallint] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [ScalabullLogId] [bigint] NULL,
   [loinc_code] [varchar](10) NULL,
   [snomed_codes] [varchar](255) NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_patient_lab_orders] PRIMARY KEY CLUSTERED ([pa_lab_id])
)

CREATE NONCLUSTERED INDEX [ix_patient_lab_orders_lab_master_id] ON [dbo].[patient_lab_orders] ([lab_master_id])
CREATE NONCLUSTERED INDEX [ix_patient_lab_orders_pa_id_isActive] ON [dbo].[patient_lab_orders] ([pa_id], [isActive])

GO
CREATE TABLE [dbo].[patient_lab_orders_diagnosis] (
   [Id] [bigint] NULL,
   [pa_lab_id] [bigint] NULL
)


GO
CREATE TABLE [dbo].[patient_lab_orders_master] (
   [lab_master_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [added_by] [bigint] NOT NULL,
   [order_date] [datetime] NOT NULL,
   [order_status] [smallint] NOT NULL,
   [comments] [varchar](500) NOT NULL,
   [last_edit_by] [bigint] NOT NULL,
   [last_edit_date] [datetime] NOT NULL,
   [dr_id] [bigint] NULL,
   [isActive] [bit] NULL,
   [external_lab_order_id] [varchar](50) NULL,
   [doc_group_lab_xref_id] [int] NULL,
   [abn_file_path] [varchar](255) NULL,
   [requisition_file_path] [varchar](255) NULL,
   [label_file_path] [varchar](255) NULL,
   [lab_id] [int] NULL,
   [order_sent_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [ScalabullLogId] [int] NULL

   ,CONSTRAINT [PK_patient_lab_orders_master] PRIMARY KEY CLUSTERED ([lab_master_id])
)


GO
CREATE TABLE [dbo].[patient_login] (
   [pa_id] [int] NOT NULL,
   [pa_username] [varchar](30) NOT NULL,
   [pa_password] [varchar](100) NOT NULL,
   [pa_email] [varchar](100) NOT NULL,
   [pa_phone] [varchar](20) NOT NULL,
   [salt] [varchar](20) NOT NULL,
   [enabled] [bit] NOT NULL,
   [cellphone] [varchar](20) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [signature] [varchar](500) NOT NULL,
   [passwordversion] [varchar](10) NOT NULL,
   [pa_login_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [WeavyId] [int] NULL,
   [accepted_terms_date] [datetime] NULL,
   [inactivated_by] [int] NULL,
   [inactivated_date] [datetime] NULL

   ,CONSTRAINT [PK_patient_login] PRIMARY KEY CLUSTERED ([pa_username])
)

CREATE NONCLUSTERED INDEX [IX_patient_login] ON [dbo].[patient_login] ([pa_id], [pa_username], [pa_password])

GO
CREATE TABLE [dbo].[patient_measure_compliance] (
   [rec_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [rec_type] [smallint] NOT NULL,
   [rec_date] [smalldatetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_measure_compliance] PRIMARY KEY CLUSTERED ([rec_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_patient_measure_compliance_7_1714925281__K2_K5_K6_1] ON [dbo].[patient_measure_compliance] ([pa_id], [rec_type], [rec_date]) INCLUDE ([rec_id])
CREATE NONCLUSTERED INDEX [IX_patient_measure_compliance] ON [dbo].[patient_measure_compliance] ([pa_id], [dr_id], [rec_date])
CREATE NONCLUSTERED INDEX [IX_patient_measure_compliance-dr_id-rec_type-rec_date] ON [dbo].[patient_measure_compliance] ([dr_id], [rec_type], [rec_date]) INCLUDE ([pa_id])

GO
CREATE TABLE [dbo].[patient_medical_hx] (
   [medhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NOT NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_medical_hx] PRIMARY KEY CLUSTERED ([medhxid])
)

CREATE NONCLUSTERED INDEX [patient_medical_hx_paid] ON [dbo].[patient_medical_hx] ([medhxid], [pat_id])

GO
CREATE TABLE [dbo].[patient_medical_hx_external] (
   [pme_medhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pme_pat_id] [bigint] NOT NULL,
   [pme_problem] [varchar](max) NULL,
   [pme_icd9] [varchar](50) NULL,
   [pme_dr_id] [bigint] NULL,
   [pme_added_by_dr_id] [bigint] NULL,
   [pme_created_on] [datetime] NULL,
   [pme_last_modified_on] [datetime] NULL,
   [pme_last_modified_by] [bigint] NULL,
   [pme_comments] [varchar](max) NULL,
   [pme_enable] [bit] NOT NULL,
   [pme_active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pme_icd9_description] [varchar](max) NULL,
   [pme_icd10] [varchar](max) NULL,
   [pme_icd10_description] [varchar](max) NULL,
   [pme_snomed] [varchar](max) NULL,
   [pme_snomed_description] [varchar](max) NULL,
   [pme_source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_medical_hx_external] PRIMARY KEY CLUSTERED ([pme_medhxid])
)


GO
CREATE TABLE [dbo].[patient_medications_hx] (
   [pam_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [from_pd_id] [int] NULL,
   [compound] [bit] NULL,
   [comments] [varchar](255) NULL,
   [status] [tinyint] NULL,
   [dt_status_change] [datetime] NULL,
   [change_dr_id] [int] NULL,
   [reason] [varchar](150) NULL,
   [drug_name] [varchar](200) NULL,
   [dosage] [varchar](255) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [drug_comments] [varchar](255) NULL,
   [numb_refills] [int] NULL,
   [use_generic] [int] NULL,
   [days_supply] [smallint] NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [date_start] [datetime] NULL,
   [date_end] [datetime] NULL,
   [for_dr_id] [int] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [order_reason] [varchar](500) NULL,
   [externalId] [varchar](50) NULL

   ,CONSTRAINT [PK_patient_medications_hx] PRIMARY KEY CLUSTERED ([pam_id])
)


GO
CREATE TABLE [dbo].[patient_med_claims_hx_log] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [prim_dr_id] [bigint] NOT NULL,
   [RequestType] [int] NULL,
   [SelectedCoverageSource] [int] NULL,
   [SelectedRxCardConsentType] [varchar](1) NULL,
   [SelectedClaimsPeriod] [tinyint] NULL,
   [IsSuccess] [bit] NOT NULL,
   [Comments] [varchar](500) NULL,
   [HasPatientConsent] [bit] NULL,
   [MakeLiveTransaction] [bit] NULL,
   [IsDemoCompany] [bit] NULL,
   [IsDemoPatient] [bit] NULL,
   [TotalRxClaimsHxRecords] [bigint] NULL,
   [FilteredRxClaimsHxRecords] [int] NULL,
   [StartDate] [datetime] NULL,
   [EndDate] [datetime] NULL,
   [CreatedOn] [datetime] NULL

   ,CONSTRAINT [PK_patient_med_claims_hx_log] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[patient_menu] (
   [patient_menu_id] [int] NOT NULL
      IDENTITY (1,1),
   [master_patient_menu_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [is_show] [bit] NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL,
   [sort_order] [int] NULL,
   [active] [bit] NULL
)


GO
CREATE TABLE [dbo].[patient_menu_doctor_level] (
   [patient_menu_doctor_level_id] [int] NOT NULL
      IDENTITY (1,1),
   [master_patient_menu_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [is_show] [bit] NULL,
   [created_date] [datetime2] NOT NULL,
   [created_by] [int] NULL,
   [modified_date] [datetime2] NULL,
   [modified_by] [int] NULL,
   [inactivated_date] [datetime2] NULL,
   [inactivated_by] [int] NULL,
   [sort_order] [int] NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_patient_menu_doctor_level] PRIMARY KEY CLUSTERED ([patient_menu_doctor_level_id])
)


GO
CREATE TABLE [dbo].[Patient_Merge_Backup] (
   [Primary_PatientId] [varchar](50) NULL,
   [Primary_Patient_Chart] [varchar](50) NULL,
   [Primary_Patient_FirstName] [varchar](50) NULL,
   [Primary_Patient_LastName] [varchar](50) NULL,
   [Primary_Patient_Dob] [varchar](50) NULL,
   [Primary_Patient_Gender] [varchar](50) NULL,
   [Primary_Patient_Address] [varchar](100) NULL,
   [Primary_Patient_City] [varchar](50) NULL,
   [Primary_Patient_State] [varchar](50) NULL,
   [Primary_Patient_Zip] [varchar](20) NULL,
   [Primary_Patient_Active] [int] NULL,
   [Secondary_PatientId] [varchar](50) NULL,
   [Secondary_Patient_Chart] [varchar](50) NULL,
   [Secondary_Patient_FirstName] [varchar](50) NULL,
   [Secondary_Patient_LastName] [varchar](50) NULL,
   [Secondary_Patient_Dob] [varchar](50) NULL,
   [Secondary_Patient_Gender] [varchar](50) NULL,
   [Secondary_Patient_Address] [varchar](100) NULL,
   [Secondary_Patient_City] [varchar](50) NULL,
   [Secondary_Patient_State] [varchar](50) NULL,
   [Secondary_Patient_Zip] [varchar](20) NULL,
   [Secondary_Patient_Active] [int] NULL
)


GO
CREATE TABLE [dbo].[Patient_merge_request_batch] (
   [pa_merge_batchid] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NOT NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [active] [bit] NOT NULL,
   [batch_name] [varchar](100) NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_merge_request_batch] PRIMARY KEY CLUSTERED ([pa_merge_batchid])
)


GO
CREATE TABLE [dbo].[Patient_merge_request_queue] (
   [pa_merge_reqid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_merge_batchid] [bigint] NOT NULL,
   [primary_pa_id] [int] NULL,
   [secondary_pa_id] [int] NULL,
   [comments] [varchar](500) NULL,
   [created_date] [datetime] NULL,
   [created_by] [int] NULL,
   [modified_by] [int] NULL,
   [modified_date] [datetime] NULL,
   [active] [bit] NOT NULL,
   [status] [int] NULL

   ,CONSTRAINT [PK_Patient_merge_request_queue] PRIMARY KEY CLUSTERED ([pa_merge_reqid])
)

CREATE NONCLUSTERED INDEX [ix_Patient_merge_request_queue_primary_pa_id_includes] ON [dbo].[Patient_merge_request_queue] ([primary_pa_id]) INCLUDE ([pa_merge_batchid])
CREATE NONCLUSTERED INDEX [ix_Patient_merge_request_queue_secondary_pa_id_status] ON [dbo].[Patient_merge_request_queue] ([secondary_pa_id], [status])

GO
CREATE TABLE [dbo].[Patient_Merge_Stage] (
   [Primary_PatientId] [varchar](50) NULL,
   [Primary_Patient_Chart] [varchar](50) NULL,
   [Primary_Patient_FirstName] [varchar](50) NULL,
   [Primary_Patient_LastName] [varchar](50) NULL,
   [Primary_Patient_Dob] [varchar](50) NULL,
   [Primary_Patient_Gender] [varchar](50) NULL,
   [Primary_Patient_Address] [varchar](100) NULL,
   [Primary_Patient_City] [varchar](50) NULL,
   [Primary_Patient_State] [varchar](50) NULL,
   [Primary_Patient_Zip] [varchar](20) NULL,
   [Primary_Patient_Active] [int] NULL,
   [Secondary_PatientId] [varchar](50) NULL,
   [Secondary_Patient_Chart] [varchar](50) NULL,
   [Secondary_Patient_FirstName] [varchar](50) NULL,
   [Secondary_Patient_LastName] [varchar](50) NULL,
   [Secondary_Patient_Dob] [varchar](50) NULL,
   [Secondary_Patient_Gender] [varchar](50) NULL,
   [Secondary_Patient_Address] [varchar](100) NULL,
   [Secondary_Patient_City] [varchar](50) NULL,
   [Secondary_Patient_State] [varchar](50) NULL,
   [Secondary_Patient_Zip] [varchar](20) NULL,
   [Secondary_Patient_Active] [int] NULL
)


GO
CREATE TABLE [dbo].[Patient_merge_status] (
   [StatusId] [int] NOT NULL
      IDENTITY (1,1),
   [Status] [varchar](20) NOT NULL,
   [Description] [varchar](50) NULL

   ,CONSTRAINT [PK_Patient_merge_status] PRIMARY KEY CLUSTERED ([StatusId])
)


GO
CREATE TABLE [dbo].[Patient_merge_transaction] (
   [pa_merge_transaction_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_merge_reqid] [bigint] NOT NULL,
   [status] [varchar](20) NULL,
   [created_date] [datetime] NULL,
   [last_modified] [datetime] NULL

   ,CONSTRAINT [PK_Patient_merge_transaction] PRIMARY KEY CLUSTERED ([pa_merge_transaction_id])
)


GO
CREATE TABLE [dbo].[patient_new_allergies] (
   [pa_allergy_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NULL,
   [allergy_type] [smallint] NOT NULL,
   [add_date] [datetime] NOT NULL,
   [comments] [varchar](2000) NULL,
   [reaction_string] [varchar](225) NULL,
   [status] [tinyint] NULL,
   [dr_modified_user] [int] NULL,
   [disable_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [allergy_description] [varchar](500) NULL,
   [record_source] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [severity_id] [bigint] NULL,
   [rxnorm_code] [varchar](200) NULL,
   [reaction_snomed] [varchar](15) NULL,
   [allergy_snomed] [varchar](100) NULL,
   [dr_id] [bigint] NULL,
   [snomed_term] [varchar](500) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_new_allergies] PRIMARY KEY CLUSTERED ([pa_allergy_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[patient_new_allergies] ([pa_id], [allergy_id], [allergy_type])

GO
CREATE TABLE [dbo].[patient_new_allergies_external] (
   [pae_pa_allergy_id] [int] NOT NULL
      IDENTITY (1,1),
   [pae_pa_id] [int] NOT NULL,
   [pae_source_name] [varchar](200) NOT NULL,
   [pae_allergy_id] [int] NULL,
   [pae_allergy_description] [varchar](500) NULL,
   [pae_allergy_type] [smallint] NULL,
   [pae_add_date] [datetime] NOT NULL,
   [pae_comments] [varchar](2000) NULL,
   [pae_reaction_string] [varchar](225) NULL,
   [pae_status] [tinyint] NULL,
   [pae_dr_modified_user] [int] NULL,
   [pae_disable_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [rxnorm_code] [varchar](100) NULL,
   [severity_id] [bigint] NULL,
   [is_from_ccd] [bit] NULL

   ,CONSTRAINT [PK_patient_new_allergies_external] PRIMARY KEY CLUSTERED ([pae_pa_allergy_id])
)


GO
CREATE TABLE [dbo].[patient_next_of_kin] (
   [pa_id] [bigint] NULL,
   [kin_relation_code] [varchar](3) NULL,
   [kin_first] [varchar](35) NULL,
   [kin_middle] [varchar](35) NULL,
   [kin_last] [varchar](35) NULL,
   [kin_address1] [varchar](35) NULL,
   [kin_city] [varchar](35) NULL,
   [kin_state] [varchar](2) NULL,
   [kin_zip] [varchar](20) NULL,
   [kin_country] [varchar](10) NULL,
   [kin_phone] [varchar](20) NULL,
   [kin_email] [varchar](50) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [kin_pref_phone] [varchar](10) NULL,
   [kin_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [pk_patient_next_of_kin_kin_id] PRIMARY KEY CLUSTERED ([kin_id])
)

CREATE NONCLUSTERED INDEX [IDX_patient_next_of_kin_pa_id] ON [dbo].[patient_next_of_kin] ([pa_id])

GO
CREATE TABLE [dbo].[patient_notes] (
   [note_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [note_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [void] [bit] NOT NULL,
   [note_text] [varchar](5000) NOT NULL,
   [partner_id] [tinyint] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [note_html] [varchar](max) NULL

   ,CONSTRAINT [PK_patient_notes] PRIMARY KEY CLUSTERED ([note_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_notes-pa_id-void] ON [dbo].[patient_notes] ([pa_id], [void])

GO
CREATE TABLE [dbo].[patient_past_history] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_past_history] PRIMARY KEY CLUSTERED ([history_id])
)


GO
CREATE TABLE [dbo].[patient_past_history_template] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_past_history_template] PRIMARY KEY CLUSTERED ([history_id])
)


GO
CREATE TABLE [dbo].[patient_phr_access_log] (
   [phr_access_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [bigint] NOT NULL,
   [phr_access_type] [int] NOT NULL,
   [phr_access_description] [varchar](1024) NOT NULL,
   [phr_access_datetime] [datetime] NULL,
   [phr_access_from_ip] [varchar](50) NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [PatientRepresentativeId] [bigint] NULL,
   [phr_access_datetime_utc] [datetime] NULL

   ,CONSTRAINT [PK_patient_phr_access_log] PRIMARY KEY CLUSTERED ([phr_access_log_id])
)


GO
CREATE TABLE [dbo].[patient_portal_friendly_diagnosis] (
   [friendly_diagnosis_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [friendly_diagnosis_text] [varchar](255) NOT NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_patient_portal_friendly_diagnosis] PRIMARY KEY CLUSTERED ([friendly_diagnosis_id])
)


GO
CREATE TABLE [dbo].[patient_procedures] (
   [procedure_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date_performed] [smalldatetime] NULL,
   [type] [varchar](50) NULL,
   [status] [varchar](50) NULL,
   [code] [varchar](50) NULL,
   [description] [varchar](250) NULL,
   [notes] [varchar](255) NULL,
   [record_modified_date] [datetime] NULL,
   [date_performed_to] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [reason_type] [varchar](50) NULL,
   [reason] [varchar](50) NULL,
   [reason_type_code] [varchar](50) NULL,
   [no_of_units] [int] NULL,
   [modifier] [varchar](30) NULL,
   [modifier_name] [varchar](255) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_procedures] PRIMARY KEY CLUSTERED ([procedure_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_procedures] ON [dbo].[patient_procedures] ([pa_id], [dr_id], [date_performed] DESC)

GO
CREATE TABLE [dbo].[patient_profile] (
   [profile_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [entry_date] [datetime] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [last_update_dr_id] [int] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_profile] PRIMARY KEY CLUSTERED ([profile_id])
)

CREATE NONCLUSTERED INDEX [IDX_patient_profile_patient_id] ON [dbo].[patient_profile] ([patient_id])
CREATE NONCLUSTERED INDEX [IX_patient_profile] ON [dbo].[patient_profile] ([added_by_dr_id], [last_update_dr_id], [patient_id])

GO
CREATE TABLE [dbo].[patient_profile_details] (
   [profile_id] [int] NOT NULL,
   [item_id] [int] NOT NULL,
   [item_text] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_patient_profile_details] PRIMARY KEY CLUSTERED ([profile_id], [item_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_profile_details] ON [dbo].[patient_profile_details] ([profile_id], [item_id])

GO
CREATE TABLE [dbo].[patient_profile_headers] (
   [HeaderID] [int] NOT NULL
      IDENTITY (1,1),
   [HeaderText] [varchar](225) NOT NULL,
   [OrderId] [tinyint] NOT NULL

   ,CONSTRAINT [PK_patient_profile_headers] PRIMARY KEY CLUSTERED ([HeaderID])
)


GO
CREATE TABLE [dbo].[patient_profile_items] (
   [item_id] [int] NOT NULL
      IDENTITY (1,1),
   [header_id] [int] NOT NULL,
   [item_label] [varchar](225) NOT NULL,
   [item_type] [tinyint] NOT NULL,
   [order_id] [tinyint] NOT NULL

   ,CONSTRAINT [PK_patient_profile_items] PRIMARY KEY CLUSTERED ([item_id])
)


GO
CREATE TABLE [dbo].[patient_pulse] (
   [pa_pls_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_pulse] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_pulse] PRIMARY KEY CLUSTERED ([pa_pls_id])
)


GO
CREATE TABLE [dbo].[patient_race_details] (
   [pa_race_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [race_id] [int] NOT NULL,
   [race_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_race_details] PRIMARY KEY CLUSTERED ([pa_race_id])
)


GO
CREATE TABLE [dbo].[patient_registration] (
   [pa_reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [src_id] [smallint] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [token] [varchar](30) NOT NULL,
   [reg_date] [smalldatetime] NOT NULL,
   [exp_date] [smalldatetime] NULL,
   [last_update_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_registration] PRIMARY KEY CLUSTERED ([pa_reg_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_registration] ON [dbo].[patient_registration] ([pa_id], [src_id], [pincode], [exp_date] DESC)

GO
CREATE TABLE [dbo].[patient_registration_details] (
   [pa_reg_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_reg_id] [int] NOT NULL,
   [reg_name] [varchar](50) NOT NULL,
   [rep_name] [varchar](50) NOT NULL,
   [rep_rel] [varchar](25) NOT NULL,
   [comments] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_patient_registration_details] PRIMARY KEY CLUSTERED ([pa_reg_det_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_registration_details] ON [dbo].[patient_registration_details] ([pa_reg_id])

GO
CREATE TABLE [dbo].[patient_reg_db] (
   [pat_reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pincode] [varchar](20) NOT NULL,
   [date_created] [datetime] NOT NULL,
   [src_type] [smallint] NULL,
   [opt_out] [bit] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_reg_db] PRIMARY KEY CLUSTERED ([pat_reg_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_reg_db] ON [dbo].[patient_reg_db] ([dr_id], [pa_id], [pincode])
CREATE NONCLUSTERED INDEX [ix_patient_reg_db_pa_id] ON [dbo].[patient_reg_db] ([pa_id])

GO
CREATE TABLE [dbo].[patient_respiration] (
   [pa_resp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_resp_rate] [int] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_respiration] PRIMARY KEY CLUSTERED ([pa_resp_id])
)


GO
CREATE TABLE [dbo].[patient_review_of_sys] (
   [ros_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [csymptoms] [varchar](225) NOT NULL,
   [eyes] [varchar](225) NOT NULL,
   [ent] [varchar](225) NOT NULL,
   [cardiovascular] [varchar](225) NOT NULL,
   [gastro] [varchar](225) NOT NULL,
   [genito] [varchar](225) NOT NULL,
   [musco] [varchar](225) NOT NULL,
   [integ] [varchar](225) NOT NULL,
   [neuro] [varchar](225) NOT NULL,
   [psych] [varchar](225) NOT NULL,
   [endocrine] [varchar](225) NOT NULL,
   [lymph] [varchar](225) NOT NULL,
   [allergic] [varchar](225) NOT NULL,
   [respiratory] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_review_of_sys] PRIMARY KEY CLUSTERED ([ros_id])
)


GO
CREATE TABLE [dbo].[patient_social_history] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_social_history] PRIMARY KEY CLUSTERED ([history_id])
)


GO
CREATE TABLE [dbo].[patient_social_history_template] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_social_history_template] PRIMARY KEY CLUSTERED ([history_id])
)


GO
CREATE TABLE [dbo].[patient_social_hx] (
   [sochxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NULL,
   [emp_info] [varchar](max) NULL,
   [marital_status] [int] NULL,
   [other_marital_status] [varchar](255) NULL,
   [household_people_no] [varchar](50) NULL,
   [smoking_status] [int] NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bigint] NULL,
   [familyhx_other] [varchar](max) NULL,
   [medicalhx_other] [varchar](max) NULL,
   [surgeryhx_other] [varchar](max) NULL,
   [active] [bit] NULL,
   [SmokingStatusId] [int] NULL,
   [FinancialResourceStrainId] [int] NULL,
   [EducationStatusId] [int] NULL,
   [StressStatusId] [int] NULL,
   [StrenousDays] [varchar](200) NULL,
   [StrenousDaysND] [bit] NULL,
   [StrenousMinutes] [varchar](200) NULL,
   [StrenousMinutesND] [bit] NULL,
   [AlcoholIntervalMonthId] [int] NULL,
   [AlcoholIntervalDayId] [int] NULL,
   [AlcoholIntervalOccasionId] [int] NULL,
   [MaritalStatusId] [int] NULL,
   [WeeklyPhoneTalkCount] [varchar](200) NULL,
   [WeeklyPhoneTalkCountND] [bit] NULL,
   [FriendFamilyGetTogetherCount] [varchar](200) NULL,
   [FriendFamilyGetTogetherCountND] [bit] NULL,
   [ChurchAttendCount] [varchar](200) NULL,
   [ChurchAttendCountND] [bit] NULL,
   [ClubOrgMemberStatusId] [int] NULL,
   [EmotionallyAbusedStatusId] [int] NULL,
   [AfraidStatusId] [int] NULL,
   [SexualHarrasmentStatusId] [int] NULL,
   [KHSHurtStatusId] [int] NULL,
   [MultipleBirthIndicatorId] [int] NULL,
   [BirthOrder] [bigint] NULL,
   [hosphx_other] [varchar](1) NULL,
   [TobaccoUse] [varchar](200) NULL,
   [MarijuanaUse] [varchar](200) NULL,
   [Vaping] [varchar](200) NULL,
   [RecreationalDrugUse] [varchar](200) NULL,
   [ETOH] [varchar](200) NULL,
   [GravidaPara] [varchar](200) NULL,
   [hospitalizationhx_other] [varchar](max) NULL

   ,CONSTRAINT [PKpatient_social_hx_hx] PRIMARY KEY CLUSTERED ([sochxid])
)

CREATE NONCLUSTERED INDEX [patient_medical_hx_paid] ON [dbo].[patient_social_hx] ([sochxid], [pat_id])
CREATE NONCLUSTERED INDEX [patient_medical_hx_paidOnly] ON [dbo].[patient_social_hx] ([pat_id])

GO
CREATE TABLE [dbo].[patient_surgery_hx] (
   [surghxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pat_id] [bigint] NOT NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL,
   [source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_surgery_hx] PRIMARY KEY CLUSTERED ([surghxid])
)

CREATE NONCLUSTERED INDEX [patient_medical_hx_paid] ON [dbo].[patient_surgery_hx] ([surghxid], [pat_id])

GO
CREATE TABLE [dbo].[patient_surgery_hx_external] (
   [pse_surghxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pse_pat_id] [bigint] NOT NULL,
   [pse_problem] [varchar](max) NULL,
   [pse_icd9] [varchar](50) NULL,
   [pse_dr_id] [bigint] NULL,
   [pse_added_by_dr_id] [bigint] NULL,
   [pse_created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [pse_comments] [varchar](max) NULL,
   [pse_enable] [bit] NOT NULL,
   [pse_icd9_description] [varchar](max) NULL,
   [pse_icd10] [varchar](max) NULL,
   [pse_icd10_description] [varchar](max) NULL,
   [pse_snomed] [varchar](max) NULL,
   [pse_snomed_description] [varchar](max) NULL,
   [pse_source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_surgery_hx_external] PRIMARY KEY CLUSTERED ([pse_surghxid])
)


GO
CREATE TABLE [dbo].[patient_temperature] (
   [pa_temp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_temp] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK__patient_temperat__66B6D1CE] PRIMARY KEY CLUSTERED ([pa_temp_id])
)


GO
CREATE TABLE [dbo].[patient_visit] (
   [visit_id] [int] NOT NULL
      IDENTITY (1,1),
   [appt_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dtCreate] [smalldatetime] NOT NULL,
   [dtEnd] [smalldatetime] NOT NULL,
   [enc_id] [int] NOT NULL,
   [chkout_notes] [varchar](max) NULL,
   [vital_id] [int] NULL,
   [reason] [varchar](255) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [clinical_notes] [varchar](max) NULL

   ,CONSTRAINT [PK_patient_visit] PRIMARY KEY CLUSTERED ([visit_id])
)

CREATE NONCLUSTERED INDEX [IDX_patient_visit_pa_id] ON [dbo].[patient_visit] ([pa_id])
CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[patient_visit] ([appt_id], [pa_id], [dr_id], [enc_id])

GO
CREATE TABLE [dbo].[patient_visit_appointment_detail] (
   [visit_id] [bigint] NOT NULL,
   [AppointmentId] [bigint] NULL,
   [MasterPatientId] [bigint] NULL,
   [MasterCompanyId] [bigint] NULL,
   [MasterLoginId] [bigint] NULL,
   [PersonResourceID] [bigint] NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedDate] [datetime2] NULL,
   [LastModifiedBy] [bigint] NULL

   ,CONSTRAINT [PK_patient_visit_appointment_detail] PRIMARY KEY CLUSTERED ([visit_id])
)


GO
CREATE TABLE [dbo].[patient_vitals] (
   [pa_vt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_wt] [float] NOT NULL,
   [pa_ht] [float] NOT NULL,
   [pa_pulse] [float] NOT NULL,
   [pa_bp_sys] [float] NOT NULL,
   [pa_bp_dys] [float] NOT NULL,
   [pa_glucose] [float] NOT NULL,
   [pa_resp_rate] [float] NOT NULL,
   [pa_temp] [float] NOT NULL,
   [pa_bmi] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [dg_id] [int] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL,
   [pa_oxm] [float] NOT NULL,
   [record_modified_date] [datetime] NULL,
   [pa_hc] [float] NOT NULL,
   [pa_bp_location] [int] NULL,
   [pa_bp_sys_statnding] [float] NULL,
   [pa_bp_dys_statnding] [float] NULL,
   [pa_bp_location_statnding] [int] NULL,
   [pa_bp_sys_supine] [float] NULL,
   [pa_bp_dys_supine] [float] NULL,
   [pa_bp_location_supine] [int] NULL,
   [pa_temp_method] [int] NULL,
   [pa_pulse_rhythm] [int] NULL,
   [pa_pulse_standing] [float] NULL,
   [pa_pulse_rhythm_standing] [int] NULL,
   [pa_pulse_supine] [float] NULL,
   [pa_pulse_rhythm_supine] [int] NULL,
   [pa_heart_rate] [float] NULL,
   [pa_fio2] [float] NULL,
   [pa_flow] [float] NULL,
   [pa_resp_quality] [int] NULL,
   [pa_comment] [varchar](max) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [wt_entered_val] [float] NULL,
   [wt_entered_unit] [int] NULL,
   [ht_entered_val] [float] NULL,
   [ht_entered_unit] [int] NULL,
   [hc_entered_val] [float] NULL,
   [hc_entered_unit] [int] NULL,
   [BmiPercentile] [decimal](4,1) NULL,
   [HeadCircumferencePercentile] [decimal](4,1) NULL,
   [WeightLengthPercentile] [decimal](4,1) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK__patient_vitals__689F1A40] PRIMARY KEY CLUSTERED ([pa_vt_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[patient_vitals] ([pa_id], [date_added], [dg_id], [added_by], [added_for])

GO
CREATE TABLE [dbo].[patient_weight] (
   [pa_wt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_wgt] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patien_weight] PRIMARY KEY CLUSTERED ([pa_wt_id])
)


GO
CREATE TABLE [dbo].[PatImport] (
   [ID] [int] NOT NULL
      IDENTITY (1,1),
   [AcctID] [nvarchar](255) NULL,
   [FullName] [nvarchar](255) NULL,
   [Phone] [nvarchar](255) NULL,
   [DOB] [smalldatetime] NULL,
   [Sex] [nvarchar](255) NULL,
   [M] [nvarchar](255) NULL,
   [Prov] [nvarchar](255) NULL,
   [CoPay] [nvarchar](255) NULL,
   [XRay] [nvarchar](255) NULL,
   [Ref] [nvarchar](255) NULL,
   [DOS] [smalldatetime] NULL,
   [InsHolder] [nvarchar](255) NULL,
   [RelateCode] [nvarchar](255) NULL,
   [Address] [nvarchar](255) NULL,
   [pa_first] [varchar](50) NULL,
   [pa_middle] [varchar](50) NULL,
   [pa_last] [varchar](50) NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_address1] [varchar](100) NULL,
   [pa_address2] [varchar](100) NULL,
   [pa_city] [varchar](50) NULL,
   [pa_state] [varchar](2) NULL,
   [pa_zip] [varchar](20) NULL,
   [pa_phone] [varchar](20) NULL,
   [pa_sex] [varchar](1) NULL,
   [ic_id] [int] NULL,
   [card_holder_first] [varchar](50) NULL,
   [card_holder_mi] [varchar](1) NULL,
   [card_holder_last] [varchar](50) NULL,
   [ins_relate_code] [varchar](4) NULL

   ,CONSTRAINT [aaaaaOut_PK] PRIMARY KEY NONCLUSTERED ([ID])
)


GO
CREATE TABLE [dbo].[pat_ins_info] (
   [pat_ins_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [rxhub_pmb_id] [varchar](15) NOT NULL,
   [ic_group_numb] [varchar](30) NOT NULL,
   [ic_plan_numb] [varchar](30) NOT NULL,
   [formulary_id] [varchar](35) NOT NULL,
   [alternative_id] [varchar](35) NOT NULL,
   [pbm_member_id] [varchar](80) NOT NULL,
   [pa_bin] [varchar](30) NOT NULL,
   [ins_relate_code] [smallint] NOT NULL,
   [ins_person_code] [varchar](30) NOT NULL,
   [card_holder_id] [varchar](30) NOT NULL,
   [card_holder_first] [varchar](50) NOT NULL,
   [card_holder_middle] [varchar](1) NOT NULL,
   [card_holder_last] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_pat_ins_info] PRIMARY KEY CLUSTERED ([pat_ins_id])
)


GO
CREATE TABLE [dbo].[payment_plans] (
   [payment_plan_id] [int] NOT NULL
      IDENTITY (1,1),
   [plan_name] [varchar](80) NOT NULL,
   [plan_desc] [varchar](255) NULL

   ,CONSTRAINT [PK_payment_plans] PRIMARY KEY CLUSTERED ([payment_plan_id])
)


GO
CREATE TABLE [dbo].[payor_login] (
   [uid] [int] NOT NULL
      IDENTITY (1,1),
   [username] [varchar](50) NOT NULL,
   [password] [varchar](50) NOT NULL,
   [payor_id] [smallint] NOT NULL,
   [comments] [varchar](225) NOT NULL,
   [title] [varchar](50) NOT NULL,
   [search_restriction] [smallint] NOT NULL,
   [enabled] [bit] NOT NULL,
   [SEARCHID] [int] NOT NULL

   ,CONSTRAINT [PK_payor_login] PRIMARY KEY CLUSTERED ([uid])
)


GO
CREATE TABLE [dbo].[paypal_transaction_details] (
   [paypal_transaction_id] [int] NOT NULL
      IDENTITY (1,1),
   [paykey] [varchar](50) NOT NULL,
   [transaction_status] [varchar](50) NOT NULL,
   [correlation_id] [varchar](50) NOT NULL,
   [time_stamp] [datetime] NOT NULL,
   [rxnt_transaction_id] [varchar](50) NOT NULL,
   [rxnt_transaction_status] [varchar](50) NOT NULL,
   [rxnt_amount] [decimal](18,2) NOT NULL,
   [rxnt_account_id] [varchar](50) NOT NULL,
   [doctor_transaction_id] [varchar](50) NOT NULL,
   [doctor_transaction_status] [varchar](50) NOT NULL,
   [doctor_amount] [decimal](18,2) NOT NULL,
   [doctor_account_id] [varchar](50) NOT NULL,
   [dg_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NULL,
   [pa_last] [varchar](50) NOT NULL,
   [dg_name] [varchar](80) NOT NULL

   ,CONSTRAINT [PK_paypal_transaction_details] PRIMARY KEY CLUSTERED ([paypal_transaction_id])
)


GO
CREATE TABLE [dbo].[pbms] (
   [pbm_id] [int] NOT NULL
      IDENTITY (1,1),
   [rxhub_part_id] [varchar](15) NOT NULL,
   [pbm_name] [varchar](50) NOT NULL,
   [pbm_notes] [varchar](255) NOT NULL,
   [disp_string] [varchar](255) NOT NULL,
   [disp_options] [varchar](255) NOT NULL,
   [is_gcn_based_form] [bit] NULL

   ,CONSTRAINT [PK_pbms] PRIMARY KEY CLUSTERED ([pbm_id])
)


GO
CREATE TABLE [dbo].[pem_links] (
   [pem_id] [int] NOT NULL,
   [pem_title] [varchar](125) NOT NULL,
   [pem_link] [varchar](225) NOT NULL,
   [pem_type] [tinyint] NOT NULL

   ,CONSTRAINT [PK_pem_links] PRIMARY KEY CLUSTERED ([pem_id])
)

CREATE NONCLUSTERED INDEX [IX_pem_links] ON [dbo].[pem_links] ([pem_title], [pem_type])

GO
CREATE TABLE [dbo].[pending_transmittals] (
   [pres_id] [int] NULL,
   [refreq_id] [int] NOT NULL,
   [pending_ack] [bit] NOT NULL,
   [pres_delivery_method] [int] NOT NULL,
   [pres_send_date] [smalldatetime] NULL,
   [pres_read_date] [smalldatetime] NULL,
   [error_string] [varchar](255) NULL

   ,CONSTRAINT [PK_pending_transmittals] PRIMARY KEY CLUSTERED ([refreq_id])
)


GO
CREATE TABLE [dbo].[pharmacies] (
   [pharm_id] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_company_name] [varchar](80) NOT NULL,
   [pharm_store_numb] [varchar](36) NOT NULL,
   [pharm_lic_numb] [varchar](50) NOT NULL,
   [pharm_dea_numb] [varchar](30) NOT NULL,
   [pharm_address1] [varchar](50) NOT NULL,
   [pharm_address2] [varchar](50) NOT NULL,
   [pharm_city] [varchar](50) NOT NULL,
   [pharm_state] [varchar](50) NOT NULL,
   [pharm_zip] [varchar](20) NOT NULL,
   [pharm_phone] [varchar](30) NOT NULL,
   [pharm_phone_reception] [varchar](30) NOT NULL,
   [pharm_fax] [varchar](30) NOT NULL,
   [pharm_email] [varchar](50) NOT NULL,
   [pharm_notify_fax] [bit] NOT NULL,
   [pharm_notify_email] [bit] NOT NULL,
   [pharm_enabled] [bit] NOT NULL,
   [pharm_create_date] [datetime] NOT NULL,
   [pharm_participant] [int] NOT NULL,
   [ncpdp_numb] [varchar](10) NOT NULL,
   [disp_type] [int] NULL,
   [enable_dummy_code] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_pharmid] [varchar](50) NULL,
   [pharm_added_by_dr_id] [int] NOT NULL,
   [pharm_pending_addition] [bit] NOT NULL,
   [SS_VERSION] [int] NOT NULL,
   [service_level] [int] NULL,
   [pharm_fax_email] [varchar](50) NULL,
   [NPI] [varchar](20) NULL,
   [pharm_crossstreet] [varchar](35) NULL

   ,CONSTRAINT [PK_pharmacies] PRIMARY KEY NONCLUSTERED ([pharm_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_pharmacies_23_526729029__K1_K13_2_6_8_9_10_20] ON [dbo].[pharmacies] ([pharm_id], [pharm_fax]) INCLUDE ([pharm_company_name], [pharm_address1], [pharm_city], [pharm_state], [pharm_zip], [ncpdp_numb])
CREATE NONCLUSTERED INDEX [_dta_index_pharmacies_7_934346443__K1_2_11_13] ON [dbo].[pharmacies] ([pharm_id]) INCLUDE ([pharm_company_name], [pharm_phone], [pharm_fax])
CREATE NONCLUSTERED INDEX [_dta_index_pharmacies_7_934346443__K1_K13_2_6_7_8_9_10_11] ON [dbo].[pharmacies] ([pharm_id], [pharm_fax]) INCLUDE ([pharm_address1], [pharm_address2], [pharm_city], [pharm_company_name], [pharm_phone], [pharm_state], [pharm_zip])
CREATE NONCLUSTERED INDEX [IX_pharmacies-pharm_enabled-pharm_pending_addition-pharm_company_name-pharm_zip-incld] ON [dbo].[pharmacies] ([pharm_enabled], [pharm_pending_addition], [pharm_company_name], [pharm_zip]) INCLUDE ([pharm_id], [pharm_address1], [pharm_address2], [pharm_city], [pharm_state], [pharm_phone], [pharm_fax], [pharm_participant], [ncpdp_numb])
CREATE NONCLUSTERED INDEX [IX_pharmacies-pharm_enabled-pharm_pending_addition-pharm_state-pharm_zip-incld] ON [dbo].[pharmacies] ([pharm_enabled], [pharm_pending_addition], [pharm_state], [pharm_zip]) INCLUDE ([pharm_id], [pharm_company_name], [pharm_address1], [pharm_address2], [pharm_city], [pharm_phone], [pharm_fax], [pharm_participant], [ncpdp_numb], [service_level])
CREATE CLUSTERED INDEX [pharmacies2] ON [dbo].[pharmacies] ([pharm_fax])
CREATE NONCLUSTERED INDEX [pharmacies3] ON [dbo].[pharmacies] ([pharm_id], [pharm_company_name], [pharm_address1], [pharm_city], [pharm_state], [pharm_zip], [pharm_phone])

GO
CREATE TABLE [dbo].[pharmacies2] (
   [pharm_id] [int] NOT NULL,
   [pharm_phone] [varchar](30) NOT NULL,
   [pharm_phone_reception] [varchar](30) NOT NULL,
   [pharm_fax] [varchar](30) NOT NULL

   ,CONSTRAINT [PK_pharmacies2] PRIMARY KEY CLUSTERED ([pharm_id])
)


GO
CREATE TABLE [dbo].[pharmaciesSureScript] (
   [pharm_id] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_company_name] [varchar](80) NOT NULL,
   [pharm_store_numb] [varchar](36) NULL,
   [pharm_lic_numb] [varchar](50) NOT NULL,
   [pharm_dea_numb] [varchar](30) NOT NULL,
   [pharm_address1] [varchar](50) NOT NULL,
   [pharm_address2] [varchar](50) NOT NULL,
   [pharm_city] [varchar](50) NOT NULL,
   [pharm_state] [varchar](50) NOT NULL,
   [pharm_zip] [varchar](20) NOT NULL,
   [pharm_phone] [varchar](30) NOT NULL,
   [pharm_phone_reception] [varchar](30) NOT NULL,
   [pharm_fax] [varchar](30) NOT NULL,
   [pharm_email] [varchar](50) NOT NULL,
   [pharm_notify_fax] [bit] NOT NULL,
   [pharm_notify_email] [bit] NOT NULL,
   [pharm_enabled] [bit] NOT NULL,
   [pharm_create_date] [datetime] NOT NULL,
   [pharm_participant] [int] NOT NULL,
   [ncpdp_numb] [varchar](10) NOT NULL,
   [disp_type] [int] NULL,
   [enable_dummy_code] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_pharmid] [varchar](50) NULL,
   [pharm_added_by_dr_id] [int] NOT NULL,
   [pharm_pending_addition] [bit] NOT NULL,
   [SS_VERSION] [int] NOT NULL,
   [service_level] [int] NULL,
   [pharm_fax_email] [varchar](50) NULL

   ,CONSTRAINT [PK_pharmaciesSureScript] PRIMARY KEY NONCLUSTERED ([pharm_id])
)


GO
CREATE TABLE [dbo].[pharmacies_backup_31_2019] (
   [pharm_id] [int] NOT NULL,
   [pharm_company_name] [varchar](80) NOT NULL,
   [pharm_store_numb] [varchar](36) NOT NULL,
   [pharm_lic_numb] [varchar](50) NOT NULL,
   [pharm_dea_numb] [varchar](30) NOT NULL,
   [pharm_address1] [varchar](50) NOT NULL,
   [pharm_address2] [varchar](50) NOT NULL,
   [pharm_city] [varchar](50) NOT NULL,
   [pharm_state] [varchar](50) NOT NULL,
   [pharm_zip] [varchar](20) NOT NULL,
   [pharm_phone] [varchar](30) NOT NULL,
   [pharm_phone_reception] [varchar](30) NOT NULL,
   [pharm_fax] [varchar](30) NOT NULL,
   [pharm_email] [varchar](50) NOT NULL,
   [pharm_notify_fax] [bit] NOT NULL,
   [pharm_notify_email] [bit] NOT NULL,
   [pharm_enabled] [bit] NOT NULL,
   [pharm_create_date] [datetime] NOT NULL,
   [pharm_participant] [int] NOT NULL,
   [ncpdp_numb] [varchar](10) NOT NULL,
   [disp_type] [int] NULL,
   [enable_dummy_code] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_pharmid] [varchar](50) NULL,
   [pharm_added_by_dr_id] [int] NOT NULL,
   [pharm_pending_addition] [bit] NOT NULL,
   [SS_VERSION] [int] NOT NULL,
   [service_level] [int] NULL,
   [pharm_fax_email] [varchar](50) NULL,
   [NPI] [varchar](20) NULL,
   [pharm_crossstreet] [varchar](35) NULL

   ,CONSTRAINT [PK_pharmacies_backup_31_2019] PRIMARY KEY NONCLUSTERED ([pharm_id])
)


GO
CREATE TABLE [dbo].[pharmacy_partner_config] (
   [pharm_participant] [int] NOT NULL,
   [version] [varchar](50) NOT NULL,
   [erx_url] [varchar](100) NULL,
   [erx_login] [varchar](50) NULL,
   [erx_password] [varchar](50) NULL,
   [admin_url] [varchar](100) NULL,
   [admin_login] [varchar](50) NULL,
   [admin_password] [varchar](50) NULL,
   [admin_portal_id] [varchar](50) NULL,
   [admin_account_id] [varchar](50) NULL,
   [pharmacy_download_url] [varchar](100) NULL,
   [pharmacy_download_login] [varchar](50) NULL,
   [pharmacy_download_password] [varchar](50) NULL,
   [data_provider_id] [varchar](50) NULL

   ,CONSTRAINT [PK_pharmacy_partner_config] PRIMARY KEY CLUSTERED ([pharm_participant], [version])
)


GO
CREATE TABLE [dbo].[pharmacy_users] (
   [pharm_user_id] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_id] [int] NOT NULL,
   [pharm_user_prefix] [varchar](10) NOT NULL,
   [pharm_user_firstname] [varchar](50) NOT NULL,
   [pharm_user_mid_initial] [varchar](1) NOT NULL,
   [pharm_user_lastname] [varchar](50) NOT NULL,
   [pharm_user_suffix] [varchar](10) NOT NULL,
   [pharm_user_username] [varchar](20) NOT NULL,
   [pharm_user_password] [varchar](20) NOT NULL,
   [pharm_user_is_primary] [bit] NOT NULL,
   [pharm_user_time_difference] [int] NOT NULL,
   [pharm_user_agreement_acptd] [bit] NOT NULL,
   [pharm_user_hipaa_agreement_acptd] [bit] NOT NULL

   ,CONSTRAINT [PK_pharmacy_users] PRIMARY KEY CLUSTERED ([pharm_user_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [PUUserNameNoDupes] ON [dbo].[pharmacy_users] ([pharm_user_username])

GO
CREATE TABLE [dbo].[pharm_messages] (
   [PharmMsgID] [int] NOT NULL
      IDENTITY (1,1),
   [PharmMsgDate] [datetime] NULL,
   [PharmMsgBy] [varchar](100) NULL,
   [PharmMessage] [text] NULL

   ,CONSTRAINT [PK_pharm_messages] PRIMARY KEY CLUSTERED ([PharmMsgID])
)


GO
CREATE TABLE [dbo].[pharm_message_reads] (
   [ReadID] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_user_id] [int] NULL,
   [PharmMsgID] [int] NULL,
   [ReadDate] [datetime] NULL

   ,CONSTRAINT [PK_pharm_message_reads] PRIMARY KEY CLUSTERED ([ReadID])
)


GO
CREATE TABLE [dbo].[pharm_mo_xref] (
   [pharm_mo_indx] [int] NOT NULL
      IDENTITY (1,1),
   [pharmacy_id] [int] NOT NULL

   ,CONSTRAINT [PK_pharm_mo_xref] PRIMARY KEY CLUSTERED ([pharm_mo_indx])
)


GO
CREATE TABLE [dbo].[phone_numbers] (
   [PhoneId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PhoneNo] [varchar](30) NULL,
   [Dg_Id] [bigint] NULL

   ,CONSTRAINT [PK_phone_numbers] PRIMARY KEY CLUSTERED ([PhoneId])
)


GO
CREATE TABLE [phr].[Login] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [Username] [varchar](30) NOT NULL,
   [Password] [varchar](100) NULL,
   [Salt] [varchar](20) NOT NULL,
   [Active] [bit] NOT NULL,
   [UserAgreementId] [int] NULL,
   [WeavyId] [int] NULL,
   [CreatedBy] [int] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedBy] [int] NULL,
   [ModifiedDate] [datetime2] NULL,
   [InactivatedBy] [int] NULL,
   [InactivatedDate] [datetime2] NULL

   ,CONSTRAINT [PK_Login] PRIMARY KEY NONCLUSTERED ([Id])
)

CREATE UNIQUE NONCLUSTERED INDEX [AK_Login_Username] ON [phr].[Login] ([Username])

GO
CREATE TABLE [phr].[LoginPatientMap] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [LoginId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [Type] [tinyint] NOT NULL,
   [CreatedBy] [int] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedBy] [int] NULL,
   [ModifiedDate] [datetime2] NULL,
   [InactivatedBy] [int] NULL,
   [InactivatedDate] [datetime2] NULL

   ,CONSTRAINT [PK_LoginPatientMap] PRIMARY KEY NONCLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [IX_LoginPatientMap_LoginIdPatientId] ON [phr].[LoginPatientMap] ([LoginId], [PatientId])

GO
CREATE TABLE [phr].[LoginToken] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [LoginId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [ExpiryDate] [datetime2] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedDate] [datetime2] NOT NULL

   ,CONSTRAINT [PK_LoginToken] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
CREATE TABLE [phr].[LoginType] (
   [Id] [tinyint] NOT NULL
      IDENTITY (1,1),
   [Name] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_LoginType] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
CREATE TABLE [phr].[MaritalStatuses] (
   [MaritalStatusId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](250) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [SortOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_MaritalStatuses] PRIMARY KEY CLUSTERED ([MaritalStatusId])
)


GO
CREATE TABLE [phr].[NotificationPreferences] (
   [NotificationPreferenceId] [int] NOT NULL
      IDENTITY (1,1),
   [NotificationId] [int] NOT NULL,
   [PatientId] [bigint] NULL,
   [RepresentativeId] [bigint] NULL,
   [EnableSMS] [bit] NULL,
   [EnableEmail] [bit] NULL,
   [EnablePush] [bit] NULL

   ,CONSTRAINT [PK__Notifica__1B80A6620ECD9609] PRIMARY KEY CLUSTERED ([NotificationPreferenceId])
)

CREATE NONCLUSTERED INDEX [idx_PatientId] ON [phr].[NotificationPreferences] ([PatientId])
CREATE NONCLUSTERED INDEX [idx_RepresentativeId] ON [phr].[NotificationPreferences] ([RepresentativeId])

GO
CREATE TABLE [phr].[Notifications] (
   [NotificationId] [int] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](10) NOT NULL,
   [Description] [varchar](max) NULL,
   [EnableSMS] [bit] NOT NULL,
   [EnableEmail] [bit] NOT NULL,
   [EnablePush] [bit] NOT NULL

   ,CONSTRAINT [PK__Notifica__20CF2E1281FC9A8C] PRIMARY KEY CLUSTERED ([NotificationId])
)


GO
CREATE TABLE [phr].[PatientEmailLogs] (
   [PatientEmailLogId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [Type] [bigint] NOT NULL,
   [Token] [varchar](900) NULL,
   [TokenExpiryDate] [datetime] NULL,
   [Active] [bit] NULL,
   [Status] [bit] NULL,
   [StatusMessage] [varchar](255) NULL,
   [ApplicationId] [int] NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL,
   [LastModifiedDate] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [InActivatedDate] [datetime] NULL,
   [InActivatedBy] [bigint] NULL,
   [PatientRepresentativeId] [bigint] NULL,
   [CreatedDateUtc] [datetime2] NULL,
   [LastModifiedDateUtc] [datetime2] NULL,
   [InactivatedDateUtc] [datetime2] NULL,
   [Email] [varchar](80) NULL

   ,CONSTRAINT [PK_PatientEmailLogs] PRIMARY KEY CLUSTERED ([PatientEmailLogId])
)

CREATE NONCLUSTERED INDEX [IX_PatientEmailLogs_Token] ON [phr].[PatientEmailLogs] ([Token])

GO
CREATE TABLE [phr].[PatientPortalDocuments] (
   [PatientPortalDocumentId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DocumentId] [int] NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IsAccepted] [bit] NULL,
   [ActionDate] [datetime] NULL,
   [Active] [bit] NULL,
   [Title] [varchar](500) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [FilePath] [varchar](500) NULL,
   [FileName] [varchar](500) NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL,
   [LastModifiedDate] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [InActivatedDate] [datetime] NULL,
   [InActivatedBy] [bigint] NULL,
   [Comments] [varchar](500) NULL,
   [PatientRepresentativeId] [bigint] NULL

   ,CONSTRAINT [PK_PatientPortalDocuments] PRIMARY KEY CLUSTERED ([PatientPortalDocumentId])
)


GO
CREATE TABLE [phr].[PatientRepresentatives] (
   [PatientRepresentativeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [PersonRelationshipId] [bigint] NOT NULL,
   [FirstName] [varchar](50) NOT NULL,
   [MiddleInitial] [varchar](50) NULL,
   [LastName] [varchar](61) NOT NULL,
   [Sex] [varchar](3) NOT NULL,
   [DOB] [datetime2] NOT NULL,
   [MaritalStatusId] [bigint] NULL,
   [HomePhone] [varchar](20) NULL,
   [CellPhone] [varchar](20) NULL,
   [WorkPhone] [varchar](20) NULL,
   [OtherPhone] [varchar](20) NULL,
   [PhonePreferenceTypeId] [bigint] NULL,
   [Email] [varchar](80) NOT NULL,
   [Fax] [varchar](20) NULL,
   [Address1] [varchar](100) NOT NULL,
   [Address2] [varchar](100) NULL,
   [CityId] [bigint] NOT NULL,
   [StateId] [bigint] NOT NULL,
   [ZipCode] [varchar](5) NOT NULL,
   [ZipExtension] [varchar](4) NULL,
   [PasswordExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [accepted_terms_date] [datetime] NULL

   ,CONSTRAINT [PK_PatientRepresentatives] PRIMARY KEY CLUSTERED ([PatientRepresentativeId])
)


GO
CREATE TABLE [phr].[PatientRepresentativesInfo] (
   [PatientRepresentativesInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientRepresentativeId] [bigint] NOT NULL,
   [Text1] [varchar](50) NOT NULL,
   [Text2] [varchar](500) NOT NULL,
   [Text3] [varchar](500) NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_Text1] UNIQUE NONCLUSTERED ([Text1])
   ,CONSTRAINT [PK_PatientRepresentativesInfo] PRIMARY KEY CLUSTERED ([PatientRepresentativesInfoId])
)


GO
CREATE TABLE [phr].[PatientTextLog] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PhoneNumber] [varchar](11) NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [PatientId] [int] NULL,
   [Type] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [ApplicationId] [int] NOT NULL,
   [CreatedDateUtc] [datetime2] NOT NULL,
   [CreatedByDoctorId] [int] NULL,
   [CreatedByPatientId] [int] NULL,
   [InactivatedDateUtc] [datetime2] NULL,
   [InactivatedByDoctorId] [int] NULL

   ,CONSTRAINT [PK_PatientTextLog] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
CREATE TABLE [phr].[PersonRelationships] (
   [PersonRelationshipId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](250) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [SortOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PersonRelationships] PRIMARY KEY CLUSTERED ([PersonRelationshipId])
)


GO
CREATE TABLE [phr].[PhonePreferenceTypes] (
   [PhonePreferenceTypeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](250) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [SortOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PhonePreferenceTypes] PRIMARY KEY CLUSTERED ([PhonePreferenceTypeId])
)


GO
CREATE TABLE [phr].[RegistrationWorkflow] (
   [Id] [uniqueidentifier] NOT NULL,
   [RegistrationWorkflowStateId] [int] NOT NULL,
   [Otp] [varchar](6) NOT NULL,
   [OtpExpiryDate] [datetime2] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [DoctorGroupId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [Nonce] [uniqueidentifier] NULL

   ,CONSTRAINT [PK_RegistrationWorkflow] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
CREATE TABLE [phr].[RegistrationWorkflowState] (
   [Id] [int] NOT NULL,
   [Name] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_RegistrationWorkflowState] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
CREATE TABLE [phr].[UserAgreement] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [TermsAndConditions] [varchar](max) NULL,
   [PrivacyPolicy] [varchar](max) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [InactivatedDate] [datetime2] NULL

   ,CONSTRAINT [PK_UserAgreement] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[PhysicianList] (
   [IMSID] [varchar](255) NOT NULL,
   [MENUM] [varchar](255) NULL,
   [MMDID] [varchar](255) NULL,
   [TITLE] [varchar](255) NULL,
   [LAST_NAME] [varchar](255) NULL,
   [FIRST_NAME] [varchar](255) NULL,
   [MI] [varchar](255) NULL,
   [SPEC] [varchar](255) NULL,
   [ADDR] [varchar](255) NULL,
   [CITY] [varchar](255) NULL,
   [CURR_STT] [varchar](255) NULL,
   [CURR_ZIP] [varchar](255) NULL,
   [PHONE] [varchar](255) NULL,
   [ALLEGRA_DECILE] [varchar](255) NULL

   ,CONSTRAINT [PK_PhysicianList] PRIMARY KEY CLUSTERED ([IMSID])
)


GO
CREATE TABLE [dbo].[practice_def_formulary_files] (
   [def_tab_id] [int] NOT NULL
      IDENTITY (1,1),
   [form_table_name] [varchar](500) NULL,
   [copay_table_name] [varchar](500) NULL,
   [coverage_table_name] [varchar](500) NULL,
   [dc_id] [int] NOT NULL,
   [pbms_cross_id] [varchar](30) NOT NULL,
   [PBM_NAME] [varchar](30) NULL

   ,CONSTRAINT [PK_practice_def_formulary_files] PRIMARY KEY CLUSTERED ([def_tab_id])
)


GO
CREATE TABLE [dbo].[practice_fee_settings] (
   [Practice_Fee_Settings_Id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [Fee_Type] [char](1) NOT NULL,
   [Fee] [decimal](18,2) NOT NULL,
   [Updated_DateTime] [datetime] NOT NULL,
   [Updated_User] [nvarchar](50) NOT NULL

   ,CONSTRAINT [PK_practice_fee_settings] PRIMARY KEY CLUSTERED ([Practice_Fee_Settings_Id])
)


GO
CREATE TABLE [dbo].[PreferredLanguages] (
   [PreferredLanguageId] [int] NOT NULL,
   [Name] [varchar](100) NOT NULL,
   [Code] [varchar](10) NOT NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_PreferredLanguages] PRIMARY KEY CLUSTERED ([PreferredLanguageId])
)


GO
CREATE TABLE [dbo].[prescriptions] (
   [pres_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [off_dr_list] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [pres_is_refill] [bit] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [last_pharm_name] [varchar](80) NOT NULL,
   [last_pharm_address] [varchar](50) NOT NULL,
   [last_pharm_city] [varchar](30) NOT NULL,
   [last_pharm_state] [varchar](30) NOT NULL,
   [last_pharm_phone] [varchar](30) NOT NULL,
   [pharm_state_holder] [varchar](50) NOT NULL,
   [pharm_city_holder] [varchar](50) NOT NULL,
   [pharm_id_holder] [varchar](20) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_pres_id] [varchar](50) NULL,
   [field_not_used1] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL,
   [eligibility_checked] [bit] NULL,
   [eligibility_trans_id] [int] NULL,
   [off_pharm_list] [bit] NOT NULL,
   [DoPrintAfterPatHistory] [bit] NOT NULL,
   [DoPrintAfterPatOrig] [bit] NOT NULL,
   [DoPrintAfterPatCopy] [bit] NOT NULL,
   [DoPrintAfterPatMonograph] [bit] NOT NULL,
   [PatOrigPrintType] [int] NOT NULL,
   [PrintHistoryBackMonths] [int] NOT NULL,
   [DoPrintAfterScriptGuide] [bit] NOT NULL,
   [approve_source] [varchar](1) NULL,
   [pres_void_code] [smallint] NULL,
   [send_count] [smallint] NOT NULL,
   [print_options] [int] NOT NULL,
   [writing_dr_id] [int] NULL,
   [presc_src] [tinyint] NULL,
   [pres_start_date] [datetime] NULL,
   [pres_end_date] [datetime] NULL,
   [is_signed] [bit] NULL

   ,CONSTRAINT [PK_prescriptions] PRIMARY KEY NONCLUSTERED ([pres_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_7_249820002__K1_K2_K3_K5_K4_6_35_36_39_40] ON [dbo].[prescriptions] ([pres_id], [dr_id], [dg_id], [pa_id], [pharm_id]) INCLUDE ([pres_approved_date], [pres_entry_date], [pres_prescription_type], [pres_void], [pres_void_comments])
CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_7_249820002__K1D_K4_K36_K31_K5_K2_6_26_34_35] ON [dbo].[prescriptions] ([pres_id] DESC, [pharm_id], [pres_void], [sfi_is_sfi], [pa_id], [dr_id]) INCLUDE ([pres_entry_date], [pres_delivery_method], [admin_notes], [pres_approved_date])
CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_7_249820002__K2_K36_K35_K3_K1_K39_K5] ON [dbo].[prescriptions] ([dr_id], [pres_void], [pres_approved_date], [dg_id], [pres_id], [pres_prescription_type], [pa_id])
CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_7_249820002__K36_K5_K35_K3_K1_K2_K4_27_39_59] ON [dbo].[prescriptions] ([pres_void], [pa_id], [pres_approved_date], [dg_id], [pres_id], [dr_id], [pharm_id]) INCLUDE ([pres_end_date], [pres_prescription_type], [prim_dr_id])
CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_7_249820002__K5_K6_K4_K2_K1_3_26_35_36] ON [dbo].[prescriptions] ([pa_id], [pres_entry_date], [pharm_id], [dr_id], [pres_id]) INCLUDE ([dg_id], [pres_delivery_method], [pres_approved_date], [pres_void])
CREATE NONCLUSTERED INDEX [IDX_prescriptions_pa_id] ON [dbo].[prescriptions] ([pa_id]) INCLUDE ([admin_notes], [approve_source], [authorizing_dr_id], [dg_id], [DoPrintAfterPatCopy], [DoPrintAfterPatHistory], [DoPrintAfterPatMonograph], [DoPrintAfterPatOrig], [DoPrintAfterScriptGuide], [dr_id], [eligibility_checked], [eligibility_trans_id], [fax_conf_error_string], [fax_conf_numb_pages], [fax_conf_remote_fax_id], [fax_conf_send_date], [field_not_used1], [is_signed], [last_edit_date], [last_edit_dr_id], [last_pharm_address], [last_pharm_city], [last_pharm_name], [last_pharm_phone], [last_pharm_state], [off_dr_list], [off_pharm_list], [only_faxed], [opener_user_id], [PatOrigPrintType], [pda_written], [pharm_city_holder], [pharm_id], [pharm_id_holder], [pharm_state_holder], [pharm_viewed], [pres_approved_date], [pres_delivery_method], [pres_end_date], [pres_entry_date], [pres_id], [pres_is_refill], [pres_prescription_type], [pres_read_date], [pres_start_date], [pres_void], [pres_void_code], [pres_void_comments], [presc_src], [prim_dr_id], [print_count], [print_options], [PrintHistoryBackMonths], [rx_number], [send_count], [sfi_is_sfi], [sfi_pres_id], [writing_dr_id])
CREATE NONCLUSTERED INDEX [ix_prescriptions_dg_id_pres_approved_date_pres_void_pres_prescription_type_includes] ON [dbo].[prescriptions] ([dg_id], [pres_approved_date], [pres_void], [pres_prescription_type]) INCLUDE ([DoPrintAfterPatCopy], [DoPrintAfterPatHistory], [DoPrintAfterPatMonograph], [DoPrintAfterPatOrig], [dr_id], [fax_conf_error_string], [fax_conf_numb_pages], [fax_conf_remote_fax_id], [fax_conf_send_date], [off_dr_list], [only_faxed], [pa_id], [pharm_id], [pres_delivery_method], [pres_entry_date], [pres_id], [pres_read_date], [pres_void_comments], [prim_dr_id])
CREATE NONCLUSTERED INDEX [ix_prescriptions_dr_id_off_dr_list_pres_void_pres_approved_date_includes] ON [dbo].[prescriptions] ([dr_id], [off_dr_list], [pres_void], [pres_approved_date]) INCLUDE ([dg_id], [fax_conf_error_string], [fax_conf_numb_pages], [fax_conf_remote_fax_id], [fax_conf_send_date], [only_faxed], [pa_id], [pharm_id], [pres_delivery_method], [pres_entry_date], [pres_id], [pres_prescription_type], [pres_read_date], [pres_void_comments], [prim_dr_id])
CREATE CLUSTERED INDEX [IX_prescriptions-dg_id-pres_id] ON [dbo].[prescriptions] ([dg_id], [pres_id])
CREATE NONCLUSTERED INDEX [IX_prescriptions-prim_dr_id-pres_approved_date-pres_void-pres_prescription_type] ON [dbo].[prescriptions] ([prim_dr_id], [pres_approved_date], [pres_void], [pres_prescription_type])
CREATE NONCLUSTERED INDEX [prescriptions14] ON [dbo].[prescriptions] ([dr_id])
CREATE NONCLUSTERED INDEX [prescriptions20] ON [dbo].[prescriptions] ([pres_id], [pa_id])
CREATE NONCLUSTERED INDEX [prescriptions26] ON [dbo].[prescriptions] ([pres_approved_date])
CREATE NONCLUSTERED INDEX [VoidPendingFix_Indx] ON [dbo].[prescriptions] ([dg_id], [pres_approved_date], [pres_void], [pres_prescription_type])
CREATE NONCLUSTERED INDEX [VoidPendingFix_Indx2] ON [dbo].[prescriptions] ([dg_id], [off_dr_list], [pres_void], [pres_approved_date]) INCLUDE ([pres_id], [dr_id], [pharm_id], [pa_id], [pres_entry_date], [pres_read_date], [only_faxed], [fax_conf_send_date], [fax_conf_numb_pages], [fax_conf_remote_fax_id], [fax_conf_error_string], [pres_delivery_method], [prim_dr_id], [pres_prescription_type], [pres_void_comments])

GO
CREATE TABLE [dbo].[prescriptions_archive] (
   [pres_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [off_dr_list] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [pres_is_refill] [bit] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [last_pharm_name] [varchar](80) NOT NULL,
   [last_pharm_address] [varchar](50) NOT NULL,
   [last_pharm_city] [varchar](30) NOT NULL,
   [last_pharm_state] [varchar](30) NOT NULL,
   [last_pharm_phone] [varchar](30) NOT NULL,
   [pharm_state_holder] [varchar](50) NOT NULL,
   [pharm_city_holder] [varchar](50) NOT NULL,
   [pharm_id_holder] [varchar](20) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_pres_id] [varchar](50) NULL,
   [field_not_used1] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL,
   [eligibility_checked] [bit] NULL,
   [eligibility_trans_id] [int] NULL,
   [off_pharm_list] [bit] NOT NULL,
   [DoPrintAfterPatHistory] [bit] NOT NULL,
   [DoPrintAfterPatOrig] [bit] NOT NULL,
   [DoPrintAfterPatCopy] [bit] NOT NULL,
   [DoPrintAfterPatMonograph] [bit] NOT NULL,
   [PatOrigPrintType] [int] NOT NULL,
   [PrintHistoryBackMonths] [int] NOT NULL,
   [DoPrintAfterScriptGuide] [bit] NOT NULL,
   [approve_source] [varchar](1) NULL,
   [pres_void_code] [smallint] NULL,
   [send_count] [smallint] NOT NULL,
   [print_options] [int] NOT NULL,
   [writing_dr_id] [int] NULL,
   [presc_src] [tinyint] NULL,
   [pres_start_date] [datetime] NULL,
   [pres_end_date] [datetime] NULL,
   [is_signed] [bit] NULL

   ,CONSTRAINT [PK__prescrip__3CE2B63731B9C501] PRIMARY KEY CLUSTERED ([pres_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_archive_23_491252905__K1_K3_K2_K5_K4_6_35_36_39_40] ON [dbo].[prescriptions_archive] ([pres_id], [dg_id], [dr_id], [pa_id], [pharm_id]) INCLUDE ([pres_entry_date], [pres_approved_date], [pres_void], [pres_prescription_type], [pres_void_comments])
CREATE NONCLUSTERED INDEX [_dta_index_prescriptions_archive_9_2011258320__K5_K36_K2_K1_K4_K35_K27_K57_K58] ON [dbo].[prescriptions_archive] ([pa_id], [pres_void], [dr_id], [pres_id], [pharm_id], [pres_approved_date], [prim_dr_id], [pres_start_date], [pres_end_date])
CREATE NONCLUSTERED INDEX [dtapres_id_archive] ON [dbo].[prescriptions_archive] ([pres_id])
CREATE NONCLUSTERED INDEX [IX_prescriptions_archive-dr_id-pres_void-pres_approved_date] ON [dbo].[prescriptions_archive] ([dr_id], [pres_void], [pres_approved_date]) INCLUDE ([pres_id], [pres_delivery_method])

GO
CREATE TABLE [dbo].[prescriptions_change_log] (
   [pres_id] [int] NOT NULL,
   [pres_change_date] [smalldatetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL

   ,CONSTRAINT [PK_prescriptions_change_log] PRIMARY KEY CLUSTERED ([pres_id])
)


GO
CREATE TABLE [dbo].[prescriptions_temp_cache] (
   [pres_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [off_dr_list] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [pres_is_refill] [bit] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [last_pharm_name] [varchar](80) NOT NULL,
   [last_pharm_address] [varchar](50) NOT NULL,
   [last_pharm_city] [varchar](30) NOT NULL,
   [last_pharm_state] [varchar](30) NOT NULL,
   [last_pharm_phone] [varchar](30) NOT NULL,
   [pharm_state_holder] [varchar](50) NOT NULL,
   [pharm_city_holder] [varchar](50) NOT NULL,
   [pharm_id_holder] [varchar](20) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_pres_id] [varchar](50) NULL,
   [field_not_used1] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL,
   [eligibility_checked] [bit] NULL,
   [eligibility_trans_id] [int] NULL,
   [off_pharm_list] [bit] NOT NULL,
   [DoPrintAfterPatHistory] [bit] NOT NULL,
   [DoPrintAfterPatOrig] [bit] NOT NULL,
   [DoPrintAfterPatCopy] [bit] NOT NULL,
   [DoPrintAfterPatMonograph] [bit] NOT NULL,
   [PatOrigPrintType] [int] NOT NULL,
   [PrintHistoryBackMonths] [int] NOT NULL,
   [DoPrintAfterScriptGuide] [bit] NOT NULL,
   [new_pres_id] [int] NOT NULL

   ,CONSTRAINT [PK_prescriptions_temp_cache] PRIMARY KEY CLUSTERED ([pres_id])
)


GO
CREATE TABLE [dbo].[prescription_Cancel_transmittals] (
   [pct_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [pres_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](255) NULL,
   [queued_date] [smalldatetime] NOT NULL,
   [send_date] [smalldatetime] NULL,
   [response_date] [smalldatetime] NULL,
   [retry_count] [int] NULL,
   [next_retry_on] [datetime] NULL

   ,CONSTRAINT [PK_prescription_Cancel_transmittals] PRIMARY KEY CLUSTERED ([pct_id])
)


GO
CREATE TABLE [dbo].[prescription_coverage_info] (
   [pd_id] [int] NOT NULL,
   [ic_group_numb] [varchar](35) NOT NULL,
   [formulary_id] [varchar](30) NOT NULL,
   [pbm_id] [varchar](15) NULL,
   [pbm_member_id] [varchar](80) NULL,
   [formulary_type] [tinyint] NOT NULL,
   [copay_id] [varchar](40) NULL,
   [coverage_id] [varchar](40) NULL,
   [alternative_id] [varchar](30) NULL,
   [PLAN_ID] [varchar](50) NULL,
   [transaction_message_id] [varchar](50) NULL

   ,CONSTRAINT [PK__prescrip__F7562CCF367E7A1E] PRIMARY KEY CLUSTERED ([pd_id])
)


GO
CREATE TABLE [dbo].[Prescription_Date_Info] (
   [PDt_Id] [int] NOT NULL
      IDENTITY (1,1),
   [dtStartDate] [datetime] NULL,
   [dtEndDate] [datetime] NULL,
   [CreatedBy] [varchar](200) NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [varchar](200) NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL,
   [pd_id] [int] NOT NULL

   ,CONSTRAINT [PK_Prescription_Date_Info] PRIMARY KEY CLUSTERED ([PDt_Id])
)


GO
CREATE TABLE [dbo].[prescription_details] (
   [pd_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](150) NOT NULL,
   [ndc] [varchar](11) NULL,
   [actual] [int] NULL,
   [dosage] [varchar](1000) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NOT NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [drug_version] [varchar](10) NOT NULL,
   [form_status] [int] NOT NULL,
   [actual_form_status] [int] NOT NULL,
   [history_enabled] [bit] NOT NULL,
   [patient_delivery_method] [smallint] NULL,
   [vps_pres_id] [varchar](10) NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [include_in_print] [bit] NULL,
   [include_in_pharm_deliver] [bit] NULL,
   [pres_read_date] [datetime] NULL,
   [fill_date] [datetime] NULL,
   [prn_description] [varchar](50) NOT NULL,
   [script_guide_status] [tinyint] NULL,
   [script_guide_id] [int] NULL,
   [script_guide_file] [varchar](100) NULL,
   [compound] [bit] NOT NULL,
   [icd9] [varchar](10) NOT NULL,
   [sample_id] [int] NULL,
   [voucher_id] [varchar](100) NULL,
   [days_supply] [smallint] NULL,
   [discharge_date] [smalldatetime] NULL,
   [discharge_desc] [varchar](255) NULL,
   [discharge_dr_id] [int] NULL,
   [cancel_status_text] [varchar](255) NULL,
   [cancel_status] [tinyint] NULL,
   [refills_prn] [bit] NULL,
   [supervisor_info] [varchar](5000) NULL,
   [agent_info] [varchar](5000) NULL,
   [max_daily_dosage] [varchar](50) NULL,
   [hospice_drug_relatedness_id] [bigint] NULL,
   [drug_indication] [varchar](100) NULL,
   [order_reason] [varchar](500) NULL,
   [FillReqId] [bigint] NULL,
   [is_dispensed] [bit] NULL,
   [icd9_desc] [varchar](255) NULL,
   [pain] [varchar](30) NULL,
   [pt_height] [float] NULL,
   [pt_weight] [float] NULL,
   [pt_vital_id] [bigint] NULL,
   [is_specialty] [bit] NULL,
   [rtpb_message_id] [varchar](50) NULL,
   [coupon_id] [bigint] NULL,
   [prior_authorization_status] [varchar](10) NULL,
   [PAReferenceId] [varchar](50) NULL,
   [hide_on_pending_rx] [bit] NULL,
   [prior_auth_number] [varchar](50) NULL,
   [has_rxfillstatus] [bit] NULL,
   [rxfillstatus_filter_settings] [tinyint] NULL

   ,CONSTRAINT [PK_prescription_details] PRIMARY KEY CLUSTERED ([pd_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_7_278344106__K1_2_4_7_8_9_10_11_12] ON [dbo].[prescription_details] ([pd_id]) INCLUDE ([pres_id], [drug_name], [dosage], [use_generic], [numb_refills], [duration_amount], [duration_unit], [comments])
CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_7_278344106__K2_K1_4_7_8_9_10_11_12] ON [dbo].[prescription_details] ([pres_id], [pd_id]) INCLUDE ([drug_name], [dosage], [use_generic], [numb_refills], [duration_amount], [duration_unit], [comments])
CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_7_278344106__K2_K1_K4_K3_K39_7_8_9_10_11_12_13_18_34_38_42_43_44_45_46_47] ON [dbo].[prescription_details] ([pres_id], [pd_id], [drug_name], [ddid], [icd9]) INCLUDE ([cancel_status], [days_supply], [discharge_date], [discharge_desc], [duration_unit], [history_enabled], [numb_refills], [cancel_status_text], [comments], [compound], [prn], [prn_description], [use_generic], [discharge_dr_id], [dosage], [duration_amount])
CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_7_278344106__K35_K2] ON [dbo].[prescription_details] ([script_guide_status], [pres_id])
CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_7_278344106__K43_K2_K1_K3_4_7_8_9_10_11_12_13_14_18_34_38_45] ON [dbo].[prescription_details] ([discharge_date], [pres_id], [pd_id], [ddid]) INCLUDE ([as_directed], [comments], [discharge_dr_id], [dosage], [drug_name], [duration_amount], [duration_unit], [history_enabled], [numb_refills], [prn], [prn_description], [use_generic], [compound])
CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_7_278344106__K8_K2] ON [dbo].[prescription_details] ([use_generic], [pres_id])
CREATE NONCLUSTERED INDEX [ICD9] ON [dbo].[prescription_details] ([pd_id], [icd9])
CREATE NONCLUSTERED INDEX [prescription_details9] ON [dbo].[prescription_details] ([pres_id], [ddid])

GO
CREATE TABLE [dbo].[prescription_details_archive] (
   [pd_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](150) NOT NULL,
   [ndc] [varchar](11) NULL,
   [actual] [int] NULL,
   [dosage] [varchar](255) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NOT NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [drug_version] [varchar](10) NOT NULL,
   [form_status] [int] NOT NULL,
   [actual_form_status] [int] NOT NULL,
   [history_enabled] [bit] NOT NULL,
   [patient_delivery_method] [smallint] NULL,
   [vps_pres_id] [varchar](10) NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [include_in_print] [bit] NULL,
   [include_in_pharm_deliver] [bit] NULL,
   [pres_read_date] [datetime] NULL,
   [fill_date] [datetime] NULL,
   [prn_description] [varchar](50) NOT NULL,
   [script_guide_status] [tinyint] NULL,
   [script_guide_id] [int] NULL,
   [script_guide_file] [varchar](100) NULL,
   [compound] [bit] NOT NULL,
   [icd9] [varchar](10) NOT NULL,
   [sample_id] [int] NULL,
   [voucher_id] [varchar](100) NULL,
   [days_supply] [smallint] NULL,
   [discharge_date] [smalldatetime] NULL,
   [discharge_desc] [varchar](255) NULL,
   [discharge_dr_id] [int] NULL,
   [cancel_status_text] [varchar](255) NULL,
   [cancel_status] [tinyint] NULL,
   [refills_prn] [bit] NULL,
   [drug_indication] [varchar](100) NULL,
   [supervisor_info] [varchar](5000) NULL,
   [agent_info] [varchar](5000) NULL,
   [max_daily_dosage] [varchar](50) NULL,
   [hospice_drug_relatedness_id] [bigint] NULL,
   [FillReqId] [bigint] NULL,
   [pain] [varchar](30) NULL

   ,CONSTRAINT [PK__prescrip__F7562CCF2DE9341D] PRIMARY KEY CLUSTERED ([pd_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_archive_23_1390732107__K38_K1_K3_K2_4_7_8_9_10_11_12_13_14_18_29_33_40] ON [dbo].[prescription_details_archive] ([discharge_date], [pd_id], [ddid], [pres_id]) INCLUDE ([as_directed], [comments], [compound], [discharge_dr_id], [dosage], [drug_name], [duration_amount], [duration_unit], [history_enabled], [numb_refills], [prn], [prn_description], [use_generic])
CREATE NONCLUSTERED INDEX [_dta_index_prescription_details_archive_9_2059258491__K2_K4_K1_K3_K7_K8_K42_K41_K9_K10_K11_K38_12_13_18_29_33_34_37_39_40] ON [dbo].[prescription_details_archive] ([pres_id], [drug_name], [pd_id], [ddid], [dosage], [use_generic], [cancel_status], [cancel_status_text], [numb_refills], [duration_amount], [duration_unit], [discharge_date]) INCLUDE ([comments], [compound], [days_supply], [discharge_desc], [discharge_dr_id], [history_enabled], [icd9], [prn], [prn_description])

GO
CREATE TABLE [dbo].[prescription_details_change_log] (
   [pd_id] [int] NOT NULL,
   [pd_change_date] [smalldatetime] NOT NULL,
   [pres_id] [int] NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](125) NOT NULL,
   [ndc] [varchar](11) NULL,
   [actual] [int] NULL,
   [dosage] [varchar](255) NOT NULL,
   [use_generic] [bit] NOT NULL,
   [numb_refills] [int] NOT NULL,
   [duration_amount] [varchar](10) NULL,
   [duration_unit] [varchar](80) NULL,
   [comments] [varchar](255) NOT NULL,
   [prn] [bit] NOT NULL,
   [as_directed] [bit] NOT NULL,
   [drug_version] [varchar](10) NOT NULL,
   [history_enabled] [bit] NOT NULL,
   [patient_delivery_method] [smallint] NULL,
   [vps_pres_id] [varchar](10) NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [include_in_print] [bit] NULL,
   [include_in_pharm_deliver] [bit] NULL,
   [pres_read_date] [datetime] NULL,
   [fill_date] [datetime] NULL

   ,CONSTRAINT [PK_prescription_details_change_log] PRIMARY KEY CLUSTERED ([pd_id])
)


GO
CREATE TABLE [dbo].[prescription_discharge_external_info] (
   [pdei_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pres_id] [bigint] NOT NULL,
   [pd_id] [bigint] NOT NULL,
   [discharge_request_id] [bigint] NOT NULL,
   [batch_id] [varchar](50) NULL,
   [external_source_syncdate] [datetime] NULL,
   [response_status] [varchar](500) NULL,
   [last_modified_by] [bigint] NULL,
   [last_modified_date] [datetime] NULL

   ,CONSTRAINT [PK_prescription_discharge_external_info] PRIMARY KEY CLUSTERED ([pdei_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_discharge_external_info_pres_id_includes] ON [dbo].[prescription_discharge_external_info] ([pres_id]) INCLUDE ([pdei_id])

GO
CREATE TABLE [dbo].[prescription_discharge_requests] (
   [discharge_request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pres_id] [bigint] NOT NULL,
   [created_by] [bigint] NOT NULL,
   [created_on] [datetime] NOT NULL,
   [approved_by] [bigint] NULL,
   [approved_on] [datetime] NULL,
   [is_active] [bit] NOT NULL,
   [last_modified_by] [bigint] NULL,
   [last_modified_on] [datetime] NULL,
   [voided_by] [bigint] NULL,
   [voided_on] [datetime] NULL,
   [voided_reason] [varchar](255) NULL,
   [discharge_reason] [varchar](255) NULL,
   [requested_to] [int] NULL

   ,CONSTRAINT [PK_prescription_discharge_requests] PRIMARY KEY CLUSTERED ([discharge_request_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_discharge_requests_approved_by_approved_on_is_active] ON [dbo].[prescription_discharge_requests] ([approved_by], [approved_on], [is_active]) INCLUDE ([discharge_request_id], [pres_id])
CREATE NONCLUSTERED INDEX [ix_prescription_discharge_requests_pres_id_approved_by_includes] ON [dbo].[prescription_discharge_requests] ([pres_id], [approved_by]) INCLUDE ([discharge_request_id])

GO
CREATE TABLE [dbo].[prescription_error_notification] (
   [pres_error_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [ps_id] [int] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [active] [bit] NOT NULL,
   [comments] [varchar](2096) NULL

   ,CONSTRAINT [PK_prescription_error_notification] PRIMARY KEY CLUSTERED ([pres_error_id])
)


GO
CREATE TABLE [dbo].[prescription_external_info] (
   [pres_external_info_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [external_order_id] [varchar](255) NOT NULL,
   [comments] [varchar](1000) NULL,
   [active] [bit] NULL,
   [created_date] [datetime] NULL,
   [created_by] [int] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [external_source_syncdate] [datetime] NULL,
   [dc_id] [int] NULL,
   [dg_id] [int] NULL,
   [response_status] [varchar](500) NULL,
   [batch_id] [varchar](50) NULL

   ,CONSTRAINT [PK_prescription_external_info] PRIMARY KEY CLUSTERED ([pres_external_info_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_external_info_dc_id_includes] ON [dbo].[prescription_external_info] ([dc_id]) INCLUDE ([batch_id], [external_source_syncdate], [pres_external_info_id], [pres_id], [response_status])
CREATE NONCLUSTERED INDEX [ix_prescription_external_info_pres_id] ON [dbo].[prescription_external_info] ([pres_id])

GO
CREATE TABLE [dbo].[prescription_partner_transmittals] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [prescription_type] [tinyint] NOT NULL,
   [partner_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL

   ,CONSTRAINT [PK_prescription_partner_transmittals] PRIMARY KEY CLUSTERED ([pt_id])
)

CREATE NONCLUSTERED INDEX [ix_prescription_partner_transmittals_pd_id_includes] ON [dbo].[prescription_partner_transmittals] ([pd_id]) INCLUDE ([pres_id], [send_date])

GO
CREATE TABLE [dbo].[prescription_pharm_actions] (
   [presc_action_id] [int] NOT NULL
      IDENTITY (1,1),
   [pharm_id] [int] NOT NULL,
   [pharm_user_id] [int] NOT NULL,
   [action_date] [smalldatetime] NOT NULL,
   [action_val] [int] NOT NULL,
   [pres_id] [int] NOT NULL,
   [detail_text] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_prescription_pharm_actions] PRIMARY KEY CLUSTERED ([presc_action_id])
)


GO
CREATE TABLE [dbo].[prescription_print_queue] (
   [pres_print_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [record_entry_date] [datetime] NOT NULL,
   [record_entry_dr_id] [int] NOT NULL,
   [print_complete_date] [datetime] NULL,
   [print_complete_dr_id] [int] NULL,
   [print_IP_Address] [nvarchar](50) NULL

   ,CONSTRAINT [PK_prescription_print_queue] PRIMARY KEY CLUSTERED ([pres_print_id])
)


GO
CREATE TABLE [dbo].[prescription_scriptguide] (
   [PRES_SGID] [int] NOT NULL
      IDENTITY (1,1),
   [PD_ID] [int] NOT NULL,
   [SG_ID] [int] NOT NULL,
   [IsTest] [tinyint] NOT NULL,
   [IsControl] [tinyint] NOT NULL

   ,CONSTRAINT [PK_prescription_scriptguide] PRIMARY KEY CLUSTERED ([PRES_SGID])
)


GO
CREATE TABLE [dbo].[prescription_sendws_log] (
   [entry_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [log_text] [varchar](2000) NOT NULL,
   [entry_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_prescription_sendws_log] PRIMARY KEY CLUSTERED ([entry_id])
)


GO
CREATE TABLE [dbo].[prescription_sendws_partner_log] (
   [entry_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [log_text] [varchar](2000) NOT NULL,
   [entry_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_prescription_sendws_partner_log] PRIMARY KEY CLUSTERED ([entry_id])
)


GO
CREATE TABLE [dbo].[prescription_sig_details] (
   [pd_sig_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pd_id] [bigint] NULL,
   [sig_sequence_number] [int] NULL,
   [sig_action] [varchar](50) NULL,
   [sig_qty] [varchar](50) NULL,
   [sig_form] [varchar](50) NULL,
   [sig_route] [varchar](50) NULL,
   [sig_time_qty] [varchar](50) NULL,
   [sig_time_option] [varchar](100) NULL,
   [drug_indication] [varchar](50) NULL

   ,CONSTRAINT [PK_prescription_sig_details] PRIMARY KEY CLUSTERED ([pd_sig_id])
)

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170620-133738] ON [dbo].[prescription_sig_details] ([pd_id])

GO
CREATE TABLE [dbo].[prescription_status] (
   [ps_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [queued_date] [datetime] NOT NULL,
   [cancel_req_response_date] [smalldatetime] NULL,
   [cancel_req_response_type] [bit] NULL,
   [cancel_req_response_text] [varchar](255) NULL

   ,CONSTRAINT [PK_prescription_status] PRIMARY KEY NONCLUSTERED ([ps_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescription_status_7_206011865__K2_K4_K3_K8_5_6_7] ON [dbo].[prescription_status] ([pd_id], [response_type], [delivery_method], [queued_date]) INCLUDE ([response_text], [response_date], [confirmation_id])
CREATE UNIQUE NONCLUSTERED INDEX [prescription_status_1] ON [dbo].[prescription_status] ([pd_id], [delivery_method])
CREATE CLUSTERED INDEX [prescription_status_2] ON [dbo].[prescription_status] ([pd_id])
CREATE NONCLUSTERED INDEX [prescription_status_3] ON [dbo].[prescription_status] ([pd_id], [delivery_method], [response_type], [response_date])

GO
CREATE TABLE [dbo].[prescription_status_archive] (
   [ps_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [queued_date] [datetime] NOT NULL,
   [cancel_req_response_date] [smalldatetime] NULL,
   [cancel_req_response_type] [bit] NULL,
   [cancel_req_response_text] [varchar](255) NULL

   ,CONSTRAINT [PK_prescription_status_archive] PRIMARY KEY CLUSTERED ([ps_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_prescription_status_archive_9_2075258548__K2_K4_K5_K6_K3_K9_K10_K11] ON [dbo].[prescription_status_archive] ([pd_id], [response_type], [response_text], [response_date], [delivery_method], [cancel_req_response_date], [cancel_req_response_type], [cancel_req_response_text])

GO
CREATE TABLE [dbo].[prescription_taper_info] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [Dose] [varchar](50) NULL,
   [Sig] [varchar](210) NULL,
   [Days] [int] NULL,
   [Hrs] [int] NULL,
   [CreatedBy] [varchar](200) NULL,
   [CreatedDate] [smalldatetime] NULL,
   [LastModifiedBy] [varchar](200) NULL,
   [LastModifiedDate] [smalldatetime] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_prescription_taper_info] PRIMARY KEY CLUSTERED ([pt_id])
)


GO
CREATE TABLE [dbo].[prescription_tasks_auto_release] (
   [pd_id] [bigint] NOT NULL,
   [pres_id] [bigint] NULL,
   [performed_on] [datetime] NULL,
   [api_response_success] [bit] NULL

   ,CONSTRAINT [PK_prescription_tasks_auto_release] PRIMARY KEY CLUSTERED ([pd_id])
)


GO
CREATE TABLE [dbo].[prescription_transmittals] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [transmission_flags] [int] NULL,
   [prescription_type] [tinyint] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [transportmethod] [smallint] NULL,
   [dialingtime] [int] NULL,
   [connectiontime] [int] NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_prescription_transmittals] PRIMARY KEY CLUSTERED ([pt_id])
)

CREATE NONCLUSTERED INDEX [IX_prescription_transmittals-pd_id-delivery_method-response_date] ON [dbo].[prescription_transmittals] ([pd_id], [delivery_method], [response_date])
CREATE NONCLUSTERED INDEX [prescription_transmittals12] ON [dbo].[prescription_transmittals] ([queued_date], [pres_id], [delivery_method], [transmission_flags], [send_date])

GO
CREATE TABLE [dbo].[prescription_transmittals_archive] (
   [pt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [transmission_flags] [int] NULL,
   [prescription_type] [tinyint] NOT NULL,
   [send_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [transportmethod] [smallint] NULL,
   [dialingtime] [int] NULL,
   [connectiontime] [int] NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_prescription_transmittals_archive] PRIMARY KEY CLUSTERED ([pt_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[prescription_transmittals_archive] ([pres_id], [pd_id], [delivery_method], [queued_date], [send_date], [response_type])

GO
CREATE TABLE [dbo].[prescription_void_transmittals] (
   [pvt_id] [int] NOT NULL
      IDENTITY (1,1),
   [refreq_id] [int] NOT NULL,
   [pres_id] [int] NULL,
   [pd_id] [int] NULL,
   [queued_date] [datetime] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [confirmation_id] [varchar](255) NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL

   ,CONSTRAINT [PK_prescription_void_transmittals] PRIMARY KEY NONCLUSTERED ([pvt_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_presid_pvt] ON [dbo].[prescription_void_transmittals] ([pres_id])
CREATE NONCLUSTERED INDEX [IX_prescription_void_transmittals-send_date-response_date] ON [dbo].[prescription_void_transmittals] ([send_date], [response_date])
CREATE UNIQUE CLUSTERED INDEX [Pk_Pvt] ON [dbo].[prescription_void_transmittals] ([pvt_id])

GO
CREATE TABLE [dbo].[pres_form] (
   [pres_authform_id] [int] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [bit] NULL,
   [visit_date] [datetime] NULL,
   [drug_name] [varchar](100) NULL

   ,CONSTRAINT [PK_pres_form] PRIMARY KEY CLUSTERED ([pres_authform_id])
)


GO
CREATE TABLE [dbo].[PrinterMaster] (
   [pm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_id] [int] NULL,
   [LocationName] [varchar](255) NULL,
   [last_updated_date] [datetime] NULL,
   [is_activated] [bit] NOT NULL

   ,CONSTRAINT [PK_PrinterMaster] PRIMARY KEY CLUSTERED ([pm_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN_1] ON [dbo].[PrinterMaster] ([dc_id], [is_activated])

GO
CREATE TABLE [dbo].[printer_registration] (
   [print_reg_id] [int] NOT NULL
      IDENTITY (1,1),
   [printer_title] [varchar](255) NOT NULL,
   [printer_desc] [varchar](255) NOT NULL,
   [add_date] [datetime] NOT NULL,
   [pm_id] [int] NOT NULL

   ,CONSTRAINT [PK_printer_registration] PRIMARY KEY CLUSTERED ([print_reg_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN_1] ON [dbo].[printer_registration] ([printer_title], [printer_desc], [pm_id])

GO
CREATE TABLE [prv].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [AppLoginId] [int] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_prv_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_prv_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
CREATE TABLE [dbo].[QualityMeasureReportsConfig] (
   [qmr_id] [int] NOT NULL
      IDENTITY (1,1),
   [version] [varchar](5) NULL,
   [reporting_years] [varchar](200) NULL

   ,CONSTRAINT [PK__QualityM__687C310459888A90] PRIMARY KEY CLUSTERED ([qmr_id])
)


GO
CREATE TABLE [que].[PatientQueue] (
   [PatientQueueId] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [ActionType] [varchar](5) NOT NULL,
   [OwnerType] [varchar](5) NOT NULL,
   [QueueStatus] [varchar](5) NOT NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [ModifiedDate] [datetime] NULL,
   [ModifiedBy] [int] NULL,
   [QueueCreatedDate] [datetime] NULL,
   [QueueProcessStartDate] [datetime] NULL,
   [QueueProcessEndDate] [datetime] NULL,
   [JobId] [bigint] NULL

   ,CONSTRAINT [PK_PatientQueue] PRIMARY KEY NONCLUSTERED ([PatientQueueId])
)

CREATE NONCLUSTERED INDEX [ix_PatientQueue_QueueStatus_includes] ON [que].[PatientQueue] ([QueueStatus]) INCLUDE ([ActionType], [CreatedBy], [dc_id], [pa_id], [PatientQueueId])

GO
CREATE TABLE [que].[PatientQueueArchive] (
   [PatientQueueArchiveId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientQueueId] [bigint] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [ActionType] [varchar](5) NOT NULL,
   [OwnerType] [varchar](5) NOT NULL,
   [QueueStatus] [varchar](5) NOT NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [ModifiedDate] [datetime] NULL,
   [ModifiedBy] [int] NULL,
   [QueueCreatedDate] [datetime] NULL,
   [QueueProcessStartDate] [datetime] NULL,
   [QueueProcessEndDate] [datetime] NULL,
   [JobId] [bigint] NULL,
   [ArchiveDate] [datetime] NOT NULL

   ,CONSTRAINT [PK_PatientQueueArchive] PRIMARY KEY NONCLUSTERED ([PatientQueueArchiveId])
)


GO
CREATE TABLE [dbo].[real_world_testing_log] (
   [real_world_testing_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NULL,
   [event_name] [nvarchar](100) NOT NULL,
   [event_status] [nvarchar](100) NOT NULL,
   [event_date] [datetime] NULL

   ,CONSTRAINT [PK__real_wor__230B849D83BDA4C0] PRIMARY KEY CLUSTERED ([real_world_testing_log_id])
)


GO
CREATE TABLE [dbo].[referral_carrier_details] (
   [carrier_id] [int] NOT NULL
      IDENTITY (1,1),
   [carrier_name] [varchar](50) NOT NULL,
   [address1] [varchar](50) NOT NULL,
   [city] [varchar](50) NOT NULL,
   [state] [varchar](10) NOT NULL,
   [zip] [varchar](10) NOT NULL,
   [phone] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_referral_carrier_details] PRIMARY KEY CLUSTERED ([carrier_id])
)


GO
CREATE TABLE [dbo].[referral_dr_carrier_ids] (
   [ref_car_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dr_local] [bit] NOT NULL,
   [provider_id1] [varchar](20) NOT NULL,
   [provider_id2] [varchar](20) NOT NULL,
   [CARRIER_XREF_ID] [int] NOT NULL

   ,CONSTRAINT [PK_referral_dr_carrier_ids] PRIMARY KEY CLUSTERED ([ref_car_id])
)


GO
CREATE TABLE [dbo].[referral_fav_providers] (
   [prv_fav_id] [int] NOT NULL
      IDENTITY (1,1),
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_referral_fav_providers] PRIMARY KEY CLUSTERED ([prv_fav_id])
)


GO
CREATE TABLE [dbo].[referral_fav_providers_78813] (
   [prv_fav_id] [int] NOT NULL
      IDENTITY (1,1),
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL
)


GO
CREATE TABLE [dbo].[referral_fav_providers_old] (
   [prv_fav_id] [int] NOT NULL,
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_referral_fav_providers_old] PRIMARY KEY CLUSTERED ([prv_fav_id])
)


GO
CREATE TABLE [dbo].[referral_generic_det] (
   [ref_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [ref_reason] [varchar](255) NOT NULL,
   [ref_description] [varchar](2000) NOT NULL,
   [numb_visits] [smallint] NOT NULL,
   [icd9] [varchar](15) NULL,
   [description] [varchar](255) NULL,
   [icd10] [varchar](20) NULL

   ,CONSTRAINT [PK_referral_generic_det] PRIMARY KEY CLUSTERED ([ref_det_id])
)


GO
CREATE TABLE [dbo].[referral_institutions] (
   [inst_id] [int] NOT NULL
      IDENTITY (1,1),
   [inst_name] [varchar](50) NOT NULL,
   [inst_address1] [varchar](50) NOT NULL,
   [inst_address2] [varchar](50) NOT NULL,
   [inst_city] [varchar](50) NOT NULL,
   [inst_state] [varchar](5) NOT NULL,
   [inst_zip] [varchar](10) NOT NULL,
   [inst_phone] [varchar](15) NOT NULL,
   [inst_fax] [varchar](15) NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_referral_institutions] PRIMARY KEY CLUSTERED ([inst_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[referral_institutions] ([inst_id], [inst_name], [added_by_dr_id])

GO
CREATE TABLE [dbo].[referral_main] (
   [ref_id] [int] NOT NULL
      IDENTITY (1,1),
   [main_dr_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [ref_det_xref_id] [int] NOT NULL,
   [ref_start_date] [datetime] NOT NULL,
   [ref_end_date] [datetime] NOT NULL,
   [carrier_xref_id] [int] NOT NULL,
   [pa_member_no] [varchar](50) NOT NULL,
   [ref_det_ident] [varchar](2) NOT NULL,
   [main_prv_id1] [varchar](50) NOT NULL,
   [main_prv_id2] [varchar](50) NOT NULL,
   [target_prv_id1] [varchar](50) NOT NULL,
   [target_prv_id2] [varchar](50) NOT NULL,
   [inst_id] [int] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [old_target_dr_id] [bigint] NULL,
   [case_id] [bigint] NULL,
   [group_number] [varchar](50) NULL,
   [payer_name] [varchar](100) NULL,
   [policy_number] [varchar](50) NULL,
   [insurance_start_date] [varchar](50) NULL,
   [insurance_end_date] [varchar](50) NULL,
   [referral_version] [varchar](50) NULL,
   [patient_new_allergies] [varchar](15) NULL

   ,CONSTRAINT [PK_referral_main] PRIMARY KEY CLUSTERED ([ref_id])
)

CREATE NONCLUSTERED INDEX [IDX_referral_main_pa_id] ON [dbo].[referral_main] ([pa_id])
CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[referral_main] ([ref_id], [main_dr_id], [target_dr_id], [pa_id], [carrier_xref_id], [inst_id])
CREATE NONCLUSTERED INDEX [IX_referral_main-main_dr_id-ref_start_date-incld] ON [dbo].[referral_main] ([main_dr_id], [ref_start_date]) INCLUDE ([ref_id], [target_dr_id], [inst_id])

GO
CREATE TABLE [dbo].[referral_maryland_details] (
   [referral_md_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [referral_reason] [varchar](225) NOT NULL,
   [brief_history_text] [varchar](1000) NOT NULL,
   [bInitConsult] [bit] NOT NULL,
   [bConsultAndTreat] [bit] NOT NULL,
   [bDiagnosticTest] [bit] NOT NULL,
   [bSpecificConsult] [bit] NOT NULL,
   [specific_consult_text] [varchar](225) NOT NULL,
   [bSpecificTreatement] [bit] NOT NULL,
   [specific_treatement_text] [varchar](225) NOT NULL,
   [bGlobalOB] [bit] NOT NULL,
   [global_ob_text] [varchar](50) NOT NULL,
   [bOther] [bit] NOT NULL,
   [other_text] [varchar](50) NOT NULL,
   [visit_numb] [smallint] NOT NULL,
   [auth_id] [varchar](20) NOT NULL,
   [bOfficeService] [bit] NOT NULL,
   [bAllSites] [bit] NOT NULL,
   [bOutpatientCenter] [bit] NOT NULL,
   [bRadiology] [bit] NOT NULL,
   [bLab] [bit] NOT NULL,
   [bInpatientHospital] [bit] NOT NULL,
   [bExtendedCare] [bit] NOT NULL,
   [bOtherServicePlace] [bit] NOT NULL,
   [other_place_text] [varchar](50) NOT NULL,
   [diag_text] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_referral_maryland_details] PRIMARY KEY CLUSTERED ([referral_md_det_id])
)


GO
CREATE TABLE [dbo].[referral_michigan_det] (
   [ref_mich_det_id] [int] NOT NULL
      IDENTITY (1,1),
   [bProviderOffice] [bit] NOT NULL,
   [bOutpatient] [bit] NOT NULL,
   [bERUCC] [bit] NOT NULL,
   [facility_numb] [varchar](50) NOT NULL,
   [facility_name] [varchar](80) NOT NULL,
   [service_date] [datetime] NOT NULL,
   [bConsult] [bit] NOT NULL,
   [numb_visits] [smallint] NOT NULL,
   [bdiagnosticlab] [bit] NOT NULL,
   [baudiology] [bit] NOT NULL,
   [bopthamalogy] [bit] NOT NULL,
   [bradiology] [bit] NOT NULL,
   [bcast] [bit] NOT NULL,
   [bsurgery] [bit] NOT NULL,
   [surgery_cpt] [varchar](50) NOT NULL,
   [bdiagstudy] [bit] NOT NULL,
   [boncology] [bit] NOT NULL,
   [binjection] [bit] NOT NULL,
   [bdialysis] [bit] NOT NULL,
   [bpain] [bit] NOT NULL,
   [ballergy] [bit] NOT NULL,
   [bob] [bit] NOT NULL,
   [btherapy] [bit] NOT NULL,
   [phy_cnt] [smallint] NOT NULL,
   [occu_cnt] [smallint] NOT NULL,
   [speech_cnt] [smallint] NOT NULL,
   [cardaic_cnt] [smallint] NOT NULL,
   [other1] [varchar](10) NOT NULL,
   [other2] [varchar](10) NOT NULL,
   [other3] [varchar](10) NOT NULL,
   [other4] [varchar](10) NOT NULL,
   [other5] [varchar](10) NOT NULL,
   [other6] [varchar](10) NOT NULL,
   [bWorkerComp] [bit] NOT NULL,
   [bautoacc] [bit] NOT NULL,
   [icd9] [varchar](10) NOT NULL,
   [comments] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_referral_michigan_det] PRIMARY KEY CLUSTERED ([ref_mich_det_id])
)


GO
CREATE TABLE [dbo].[referral_status] (
   [rs_id] [int] NOT NULL
      IDENTITY (1,1),
   [referral_id] [int] NOT NULL,
   [delivery_method] [int] NOT NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](600) NULL,
   [response_date] [datetime] NULL,
   [confirmation_id] [varchar](125) NULL,
   [queued_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_referral_status] PRIMARY KEY CLUSTERED ([rs_id])
)

CREATE NONCLUSTERED INDEX [IX_referral_status] ON [dbo].[referral_status] ([delivery_method], [referral_id])
CREATE NONCLUSTERED INDEX [IX_referral_status-referral_id-incld] ON [dbo].[referral_status] ([referral_id]) INCLUDE ([delivery_method], [response_type], [response_text], [response_date])

GO
CREATE TABLE [dbo].[referral_target_docs] (
   [target_dr_id] [int] NOT NULL
      IDENTITY (1,1),
   [first_name] [varchar](50) NOT NULL,
   [last_name] [varchar](50) NOT NULL,
   [middle_initial] [varchar](5) NOT NULL,
   [GroupName] [varchar](50) NULL,
   [speciality] [varchar](50) NULL,
   [address1] [varchar](50) NULL,
   [city] [varchar](50) NULL,
   [state] [varchar](10) NULL,
   [zip] [varchar](50) NULL,
   [phone] [varchar](50) NULL,
   [fax] [varchar](50) NOT NULL,
   [IsLocal] [bit] NOT NULL,
   [ext_doc_id] [int] NOT NULL,
   [dc_id] [bigint] NULL,
   [from_target_dr_id] [bigint] NULL,
   [direct_email] [varchar](50) NULL,
   [ModifiedDate] [datetime] NULL,
   [MasterContactId] [bigint] NULL,
   [address2] [varchar](50) NULL

   ,CONSTRAINT [PK_referral_target_docs] PRIMARY KEY CLUSTERED ([target_dr_id])
)


GO
CREATE TABLE [dbo].[referral_transmittals] (
   [referral_transmit_id] [int] NOT NULL
      IDENTITY (1,1),
   [referral_id] [int] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [tinyint] NULL,
   [response_text] [varchar](225) NULL,
   [delivery_method] [tinyint] NOT NULL,
   [queued_date] [datetime] NULL

   ,CONSTRAINT [PK_referral_transmittals] PRIMARY KEY CLUSTERED ([referral_transmit_id])
)

CREATE NONCLUSTERED INDEX [IX_referral_transmittals] ON [dbo].[referral_transmittals] ([referral_id], [delivery_method], [queued_date], [send_date])

GO
CREATE TABLE [dbo].[refill_requests] (
   [refreq_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_ncpdp] [varchar](15) NULL,
   [refreq_date] [datetime] NOT NULL,
   [trc_number] [varchar](100) NULL,
   [ctrl_number] [varchar](100) NULL,
   [recverVector] [varchar](50) NULL,
   [senderVector] [varchar](50) NULL,
   [pres_id] [int] NULL,
   [response_type] [int] NULL,
   [init_date] [datetime] NULL,
   [msg_date] [datetime] NULL,
   [response_id] [varchar](15) NULL,
   [status_code] [varchar](15) NULL,
   [status_code_qualifier] [varchar](15) NULL,
   [status_msg] [varchar](255) NULL,
   [response_conf_date] [smalldatetime] NULL,
   [error_string] [varchar](255) NULL,
   [pres_fill_time] [datetime] NULL,
   [msg_ref_number] [varchar](35) NOT NULL,
   [drug_name] [varchar](125) NULL,
   [drug_ndc] [varchar](11) NULL,
   [drug_form] [varchar](3) NULL,
   [drug_strength] [varchar](70) NULL,
   [drug_strength_units] [varchar](3) NULL,
   [qty1] [varchar](35) NULL,
   [qty1_units] [varchar](50) NULL,
   [qty1_enum] [tinyint] NULL,
   [qty2] [varchar](35) NULL,
   [qty2_units] [varchar](50) NULL,
   [qty2_enum] [tinyint] NULL,
   [dosage1] [varchar](140) NULL,
   [dosage2] [varchar](70) NULL,
   [days_supply] [int] NULL,
   [date1] [smalldatetime] NULL,
   [date1_enum] [tinyint] NULL,
   [date2] [smalldatetime] NULL,
   [date2_enum] [tinyint] NULL,
   [date3] [smalldatetime] NULL,
   [date3_enum] [tinyint] NULL,
   [substitution_code] [tinyint] NULL,
   [refills] [varchar](35) NULL,
   [refills_enum] [tinyint] NULL,
   [void_comments] [varchar](255) NULL,
   [void_code] [smallint] NULL,
   [comments1] [varchar](210) NULL,
   [comments2] [varchar](70) NULL,
   [comments3] [varchar](70) NULL,
   [disp_drug_info] [bit] NOT NULL,
   [supervisor] [varchar](100) NULL,
   [SupervisorSeg] [varchar](5000) NULL,
   [PharmSeg] [varchar](5000) NULL,
   [PatientSeg] [varchar](5000) NULL,
   [DoctorSeg] [varchar](5000) NULL,
   [DispDRUSeg] [varchar](max) NULL,
   [PrescDRUSeg] [varchar](max) NULL,
   [drug_strength_code] [varchar](15) NULL,
   [drug_strength_source_code] [varchar](3) NULL,
   [drug_form_code] [varchar](15) NULL,
   [drug_form_source_code] [varchar](3) NULL,
   [qty1_units_potency_code] [varchar](15) NULL,
   [qty2_units_potency_code] [varchar](15) NULL,
   [doc_info_text] [varchar](5000) NULL,
   [fullRequestMessage] [xml] NULL,
   [versionType] [varchar](5) NULL,
   [has_miss_match] [bit] NULL,
   [miss_match_reson] [varchar](max) NULL

   ,CONSTRAINT [PK_refill_requests] PRIMARY KEY NONCLUSTERED ([refreq_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_refill_requests_7_1336443885__K12_K1_38_39_40_41_42_43] ON [dbo].[refill_requests] ([pres_id], [refreq_id]) INCLUDE ([date1], [date1_enum], [date2], [date2_enum], [date3], [date3_enum])
CREATE NONCLUSTERED INDEX [IDX_refill_requests_pa_id] ON [dbo].[refill_requests] ([pa_id])
CREATE CLUSTERED INDEX [refill_requests1] ON [dbo].[refill_requests] ([pres_id])

GO
CREATE TABLE [dbo].[refill_requests_archive] (
   [refreq_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_ncpdp] [varchar](15) NULL,
   [refreq_date] [datetime] NOT NULL,
   [trc_number] [varchar](50) NULL,
   [ctrl_number] [varchar](50) NULL,
   [recverVector] [varchar](50) NULL,
   [senderVector] [varchar](50) NULL,
   [pres_id] [int] NULL,
   [response_type] [int] NULL,
   [init_date] [datetime] NULL,
   [msg_date] [datetime] NULL,
   [response_id] [varchar](15) NULL,
   [status_code] [varchar](15) NULL,
   [status_code_qualifier] [varchar](15) NULL,
   [status_msg] [varchar](255) NULL,
   [response_conf_date] [smalldatetime] NULL,
   [error_string] [varchar](255) NULL,
   [pres_fill_time] [datetime] NULL,
   [msg_ref_number] [varchar](35) NOT NULL,
   [drug_name] [varchar](125) NULL,
   [drug_ndc] [varchar](11) NULL,
   [drug_form] [varchar](3) NULL,
   [drug_strength] [varchar](70) NULL,
   [drug_strength_units] [varchar](3) NULL,
   [qty1] [varchar](35) NULL,
   [qty1_units] [varchar](3) NULL,
   [qty1_enum] [tinyint] NULL,
   [qty2] [varchar](35) NULL,
   [qty2_units] [varchar](3) NULL,
   [qty2_enum] [tinyint] NULL,
   [dosage1] [varchar](70) NULL,
   [dosage2] [varchar](70) NULL,
   [days_supply] [int] NULL,
   [date1] [smalldatetime] NULL,
   [date1_enum] [tinyint] NULL,
   [date2] [smalldatetime] NULL,
   [date2_enum] [tinyint] NULL,
   [date3] [smalldatetime] NULL,
   [date3_enum] [tinyint] NULL,
   [substitution_code] [tinyint] NULL,
   [refills] [varchar](35) NULL,
   [refills_enum] [tinyint] NULL,
   [void_comments] [varchar](255) NULL,
   [void_code] [smallint] NULL,
   [comments1] [varchar](70) NULL,
   [comments2] [varchar](70) NULL,
   [comments3] [varchar](70) NULL,
   [disp_drug_info] [bit] NOT NULL,
   [supervisor] [varchar](100) NULL,
   [SupervisorSeg] [varchar](500) NULL,
   [PharmSeg] [varchar](500) NULL,
   [PatientSeg] [varchar](500) NULL,
   [DoctorSeg] [varchar](500) NULL,
   [DispDRUSeg] [varchar](5000) NULL,
   [PrescDRUSeg] [varchar](7999) NULL

   ,CONSTRAINT [PK_refill_requests_archive] PRIMARY KEY CLUSTERED ([refreq_id])
)


GO
CREATE TABLE [dbo].[refill_requests_info] (
   [refreqinfo_id] [int] NOT NULL
      IDENTITY (1,1),
   [refreq_id] [int] NOT NULL,
   [type] [varchar](7) NOT NULL,
   [drug_name] [varchar](125) NULL,
   [drug_ndc] [varchar](11) NULL,
   [drug_form] [varchar](3) NULL,
   [drug_strength] [varchar](70) NULL,
   [drug_strength_units] [varchar](3) NULL,
   [qty1] [varchar](35) NULL,
   [qty1_units] [varchar](50) NULL,
   [qty1_enum] [tinyint] NULL,
   [qty2] [varchar](35) NULL,
   [qty2_units] [varchar](50) NULL,
   [qty2_enum] [tinyint] NULL,
   [dosage1] [varchar](140) NULL,
   [dosage2] [varchar](70) NULL,
   [days_supply] [int] NULL,
   [date1] [smalldatetime] NULL,
   [date1_enum] [tinyint] NULL,
   [date2] [smalldatetime] NULL,
   [date2_enum] [tinyint] NULL,
   [date3] [smalldatetime] NULL,
   [date3_enum] [tinyint] NULL,
   [substitution_code] [tinyint] NULL,
   [refills] [varchar](35) NULL,
   [refills_enum] [tinyint] NULL,
   [void_comments] [varchar](255) NULL,
   [void_code] [smallint] NULL,
   [comments1] [varchar](210) NULL,
   [comments2] [varchar](70) NULL,
   [comments3] [varchar](70) NULL,
   [drug_strength_code] [varchar](15) NULL,
   [drug_strength_source_code] [varchar](3) NULL,
   [drug_form_code] [varchar](15) NULL,
   [drug_form_source_code] [varchar](3) NULL,
   [qty1_units_potency_code] [varchar](15) NULL,
   [qty2_units_potency_code] [varchar](15) NULL,
   [doc_info_text] [varchar](5000) NULL

   ,CONSTRAINT [PK_refill_requests_info] PRIMARY KEY NONCLUSTERED ([refreqinfo_id])
)

CREATE NONCLUSTERED INDEX [index_refill_requests_info1] ON [dbo].[refill_requests_info] ([refreq_id]) INCLUDE ([drug_name], [qty1], [qty1_units], [dosage1], [dosage2], [days_supply], [date1], [date1_enum], [date2], [date2_enum], [date3], [date3_enum], [refills], [comments1], [comments2], [comments3])
CREATE UNIQUE CLUSTERED INDEX [PK_RefInfo] ON [dbo].[refill_requests_info] ([refreqinfo_id], [refreq_id])

GO
CREATE TABLE [dbo].[RefTracking] (
   [RTID] [int] NOT NULL
      IDENTITY (1,1),
   [REF] [varchar](2000) NOT NULL,
   [IP] [varchar](255) NOT NULL,
   [PG] [varchar](2000) NOT NULL,
   [DT] [datetime] NOT NULL

   ,CONSTRAINT [PK_RefTracking] PRIMARY KEY CLUSTERED ([RTID])
)


GO
CREATE TABLE [dbo].[REPORT_LOG] (
   [report_id] [int] NOT NULL
      IDENTITY (1,1),
   [VERSION] [varchar](2) NOT NULL,
   [FILE_NAME] [varchar](50) NOT NULL,
   [PARTNER_NAME] [varchar](20) NULL,
   [TRANSMIT_DATE] [smalldatetime] NULL,
   [TRANSACT_FILE_TYPE] [varchar](50) NULL,
   [EXTRACT_DATE] [smalldatetime] NULL,
   [FILE_TYPE] [varchar](1) NULL,
   [START_DATE] [smalldatetime] NULL,
   [END_DATE] [smalldatetime] NULL,
   [RESPONSE_TYPE] [bit] NULL,
   [RESPONSE_FILE_NAME] [varchar](200) NULL

   ,CONSTRAINT [PK_REPORT_LOG] PRIMARY KEY CLUSTERED ([report_id])
)


GO
CREATE TABLE [dbo].[rights] (
   [right_id] [int] NOT NULL
      IDENTITY (1,1),
   [right_desc] [varchar](255) NOT NULL,
   [right_code] [varchar](50) NOT NULL,
   [right_val] [int] NULL

   ,CONSTRAINT [PK_rights] PRIMARY KEY CLUSTERED ([right_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [RightCodeNoDupes] ON [dbo].[rights] ([right_code])

GO
CREATE TABLE [rpt].[DeduplicationExcludePatients] (
   [DeduplicationExcludePatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PrimaryPatientId] [bigint] NOT NULL,
   [SecondaryPatientId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DeduplicationExcludePatients] PRIMARY KEY CLUSTERED ([DeduplicationExcludePatientId])
)


GO
CREATE TABLE [rpt].[DeduplicationMergePatients] (
   [DeduplicationMergePatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [PatientMergeRequestBatchId] [bigint] NOT NULL,
   [PatientMergeRequestQueueId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [DeduplicationPatientId] [bigint] NOT NULL

   ,CONSTRAINT [PK_DeduplicationMergePatients] PRIMARY KEY CLUSTERED ([DeduplicationMergePatientId])
)


GO
CREATE TABLE [rpt].[DeduplicationPatientGroups] (
   [DeduplicationPatientGroupId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [GroupName] [varchar](500) NOT NULL,
   [SuggestedPrimaryPatientId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [IncludeForMerge] [bit] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DeduplicationPatientGroups] PRIMARY KEY CLUSTERED ([DeduplicationPatientGroupId])
)


GO
CREATE TABLE [rpt].[DeduplicationPatients] (
   [DeduplicationPatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DeduplicationPatientGroupId] [bigint] NOT NULL,
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [DuplicationTypeId] [bigint] NOT NULL,
   [DuplicationText] [varchar](1000) NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [IsIndirectMapping] [bit] NULL,
   [IndirectMappingComments] [varchar](500) NULL,
   [IncludeWarningPatient] [bit] NULL,
   [IncludePatientForMerge] [bit] NULL,
   [Level] [int] NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [DeduplicationSecondaryPatientId] [bigint] NULL

   ,CONSTRAINT [PK_DeduplicationPatients] PRIMARY KEY CLUSTERED ([DeduplicationPatientId])
)

CREATE NONCLUSTERED INDEX [idx_DeduplicationPatients_DCDRID_PID_PSTID] ON [rpt].[DeduplicationPatients] ([DoctorCompanyDeduplicateRequestId], [PatientId], [ProcessStatusTypeId])

GO
CREATE TABLE [rpt].[DeduplicationPrimaryPatients] (
   [DeduplicationPrimaryPatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PatientMergeRequestBatchId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DeduplicationPrimaryPatients] PRIMARY KEY CLUSTERED ([DeduplicationPrimaryPatientId])
)


GO
CREATE TABLE [rpt].[DeduplicationPrimaryPatientTransition] (
   [DeduplicationPrimaryPatientTransitionId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [PrimaryPatientCriteriaTypeId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PatientMergeRequestBatchId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DeduplicationPrimaryPatientTransition] PRIMARY KEY CLUSTERED ([DeduplicationPrimaryPatientTransitionId])
)

CREATE NONCLUSTERED INDEX [ix_DeduplicationPrimaryPatientTransition_DCDRId_DCId_PID_A] ON [rpt].[DeduplicationPrimaryPatientTransition] ([DoctorCompanyDeduplicateRequestId], [CompanyId], [Active]) INCLUDE ([PatientId], [PrimaryPatientCriteriaTypeId], [ProcessStatusTypeId])

GO
CREATE TABLE [rpt].[DeduplicationSecondaryPatients] (
   [DeduplicationSecondaryPatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DeduplicationPrimaryPatientId] [bigint] NOT NULL,
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [DuplicationTypeId] [bigint] NOT NULL,
   [DuplicationText] [varchar](1000) NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PatientMergeRequestBatchId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [IsIndirectMapping] [bit] NULL,
   [IndirectMappingComments] [varchar](500) NULL,
   [IncludeWarningPatient] [bit] NULL

   ,CONSTRAINT [PK_DeduplicationSecondaryPatients] PRIMARY KEY CLUSTERED ([DeduplicationSecondaryPatientId])
)


GO
CREATE TABLE [rpt].[DoctorCompanyDeduplicateRequests] (
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorCompanyDeduplicateRequests] PRIMARY KEY CLUSTERED ([DoctorCompanyDeduplicateRequestId])
)


GO
CREATE TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] (
   [DoctorCompanyDeduplicationPatientTransitionId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicationTransitionId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [DoctorGroupId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PatientMergeRequestBatchId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorCompanyDeduplicationPatientTransition] PRIMARY KEY CLUSTERED ([DoctorCompanyDeduplicationPatientTransitionId])
)

CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationPatientTransition_Active_includes] ON [rpt].[DoctorCompanyDeduplicationPatientTransition] ([Active]) INCLUDE ([DoctorCompanyDeduplicationPatientTransitionId], [DoctorCompanyDeduplicationTransitionId], [DoctorGroupId], [PatientId], [ProcessStatusTypeId])
CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationPatientTransition_CompanyId_PatientId] ON [rpt].[DoctorCompanyDeduplicationPatientTransition] ([CompanyId], [PatientId])
CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationPatientTransition_DoctorCompanyDeduplicationTransitionId_Active] ON [rpt].[DoctorCompanyDeduplicationPatientTransition] ([DoctorCompanyDeduplicationTransitionId], [Active])

GO
CREATE TABLE [rpt].[DoctorCompanyDeduplicationTransition] (
   [DoctorCompanyDeduplicationTransitionId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [DuplicationTypeId] [bigint] NOT NULL,
   [DuplicationText] [varchar](1000) NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorCompanyDeduplicationTransition] PRIMARY KEY CLUSTERED ([DoctorCompanyDeduplicationTransitionId])
)

CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationTransition_DCDRID_DCId_PSTId_DTId] ON [rpt].[DoctorCompanyDeduplicationTransition] ([DoctorCompanyDeduplicateRequestId], [CompanyId], [ProcessStatusTypeId], [DuplicationTypeId]) INCLUDE ([DoctorCompanyDeduplicationTransitionId], [DuplicationText])
CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationTransition_DoctorCompanyDeduplicateRequestId_Active_includes] ON [rpt].[DoctorCompanyDeduplicationTransition] ([DoctorCompanyDeduplicateRequestId], [Active]) INCLUDE ([CompanyId], [DoctorCompanyDeduplicationTransitionId], [DuplicationText], [DuplicationTypeId], [ProcessStatusTypeId])

GO
CREATE TABLE [rpt].[DuplicationTypes] (
   [DuplicationTypeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](1000) NOT NULL,
   [Description] [varchar](5000) NOT NULL,
   [Weightage] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [IsWarning] [bit] NULL

   ,CONSTRAINT [AK_DuplicationTypes_Code] UNIQUE NONCLUSTERED ([Code])
   ,CONSTRAINT [PK_DuplicationTypes] PRIMARY KEY CLUSTERED ([DuplicationTypeId])
)


GO
CREATE TABLE [rpt].[PrimaryPatientCriteriaTypes] (
   [PrimaryPatientCriteriaTypeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](1000) NOT NULL,
   [Description] [varchar](5000) NOT NULL,
   [Weightage] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_PrimaryPatientCriteriaTypes_Code] UNIQUE NONCLUSTERED ([Code])
   ,CONSTRAINT [PK_PrimaryPatientCriteriaTypes] PRIMARY KEY CLUSTERED ([PrimaryPatientCriteriaTypeId])
)


GO
CREATE TABLE [rpt].[ProcessStatusTypes] (
   [ProcessStatusTypeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Code] [varchar](5) NOT NULL,
   [Name] [varchar](100) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_ProcessStatusTypes_Code] UNIQUE NONCLUSTERED ([Code])
   ,CONSTRAINT [PK_ProcessStatusTypes] PRIMARY KEY CLUSTERED ([ProcessStatusTypeId])
)


GO
CREATE TABLE [rpt].[ReactivateMergedPrimaryPatientsStatuses] (
   [ReactivateMergedPrimaryPatientsStatusId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ReactivateMergedPrimaryPatientsStatuses] PRIMARY KEY CLUSTERED ([ReactivateMergedPrimaryPatientsStatusId])
)


GO
CREATE TABLE [dbo].[rxhub_claims_log] (
   [rxclaim_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [ctrlref] [varchar](150) NOT NULL,
   [request] [text] NULL,
   [response] [text] NULL,
   [request_date] [datetime] NULL,
   [pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_rxhub_claims_log] PRIMARY KEY CLUSTERED ([rxclaim_id])
)


GO
CREATE TABLE [dbo].[rxhub_eligibility_details_log] (
   [redl_id] [int] NOT NULL
      IDENTITY (1,1),
   [rel_id] [int] NOT NULL,
   [responding_src] [varchar](50) NOT NULL,
   [formulary_id] [varchar](15) NULL,
   [alternative_id] [varchar](15) NULL,
   [response_code] [varchar](15) NOT NULL,
   [response_string] [varchar](255) NULL,
   [comments] [varchar](255) NULL,
   [request_data] [text] NULL,
   [response_data] [text] NULL

   ,CONSTRAINT [PK_rxhub_eligibility_details_log] PRIMARY KEY CLUSTERED ([redl_id])
)


GO
CREATE TABLE [dbo].[rxhub_eligibility_log] (
   [rel_id] [int] NOT NULL
      IDENTITY (1,1),
   [transaction_id] [varchar](50) NOT NULL,
   [request_date] [datetime] NOT NULL,
   [response_date] [datetime] NOT NULL,
   [request_trace_id] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_rxhub_eligibility_log] PRIMARY KEY CLUSTERED ([rel_id])
)


GO
CREATE TABLE [dbo].[rxhub_sig_transaction_details_log] (
   [rstdl_id] [int] NOT NULL
      IDENTITY (1,1),
   [rstl_id] [int] NOT NULL,
   [transaction_id] [varchar](50) NOT NULL,
   [transaction_trace_reference] [varchar](50) NOT NULL,
   [response_date] [datetime] NOT NULL,
   [response_code] [varchar](15) NULL,
   [response_code_qualifier] [varchar](15) NULL,
   [response_message] [varchar](255) NULL,
   [comments] [varchar](255) NULL,
   [request_message] [text] NULL,
   [raw_response] [text] NULL

   ,CONSTRAINT [PK_rxhub_sig_transaction_details_log] PRIMARY KEY CLUSTERED ([rstdl_id])
)


GO
CREATE TABLE [dbo].[rxhub_sig_transaction_log] (
   [rstl_id] [int] NOT NULL
      IDENTITY (1,1),
   [transaction_id] [varchar](50) NOT NULL,
   [transaction_trace_reference] [varchar](50) NOT NULL,
   [request_trace_id] [varchar](50) NOT NULL,
   [transaction_type] [smallint] NOT NULL,
   [request_date] [datetime] NOT NULL,
   [request_data] [text] NULL,
   [response_data] [text] NULL

   ,CONSTRAINT [PK_rxhub_sig_transaction_log] PRIMARY KEY CLUSTERED ([rstl_id])
)


GO
CREATE TABLE [dbo].[rxhub_status_log] (
   [rsl_id] [int] NOT NULL
      IDENTITY (1,1),
   [ctrl_ref_num] [varchar](50) NOT NULL,
   [trc_num] [varchar](50) NOT NULL,
   [status_code] [varchar](10) NOT NULL,
   [status_msg] [varchar](255) NULL,
   [status_code_qualifier] [varchar](10) NULL,
   [recved_date] [datetime] NOT NULL,
   [init_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_rxhub_status_log] PRIMARY KEY CLUSTERED ([rsl_id])
)


GO
CREATE TABLE [dbo].[RxHub_VITAS_FORM_VXFORM] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [source_ndc] [varchar](11) NULL,
   [form_status] [int] NULL,
   [rel_value] [int] NULL,
   [Text] [varchar](200) NULL
)


GO
CREATE TABLE [dbo].[rxntlibertydetails] (
   [liberty_do_id] [bigint] NOT NULL,
   [line_item_id] [int] NOT NULL,
   [msg_ref_id] [varchar](50) NOT NULL,
   [receive_date] [datetime] NOT NULL,
   [message] [xml] NOT NULL,
   [response_type] [int] NULL,
   [response_date] [datetime] NULL,
   [response_status] [smallint] NULL,
   [response_text] [varchar](500) NULL,
   [liberty_details_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__rxntlibertydetai__318EDC78] PRIMARY KEY CLUSTERED ([liberty_details_id])
)

CREATE NONCLUSTERED INDEX [IX_rxntlibertydetails-liberty_do_id-incld] ON [dbo].[rxntlibertydetails] ([liberty_do_id]) INCLUDE ([msg_ref_id], [response_type], [response_date], [response_text], [liberty_details_id])

GO
CREATE TABLE [dbo].[rxntlibertydo] (
   [liberty_do_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [msg_ref_id] [varchar](50) NOT NULL,
   [type] [int] NOT NULL,
   [total_items] [int] NOT NULL,
   [received_items] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [start_date] [datetime] NOT NULL,
   [formMessage] [xml] NULL,
   [approved_date] [datetime] NULL,
   [void] [bit] NOT NULL,
   [form_type] [varchar](255) NOT NULL,
   [sent_item] [int] NOT NULL,
   [void_code] [smallint] NULL,
   [void_comments] [varchar](255) NULL

   ,CONSTRAINT [PK_rxntlibertydo] PRIMARY KEY CLUSTERED ([liberty_do_id])
)

CREATE NONCLUSTERED INDEX [IX_rxntlibertydo-approved_date] ON [dbo].[rxntlibertydo] ([approved_date])

GO
CREATE TABLE [dbo].[rxntliberty_transmittals] (
   [rlt_id] [int] NOT NULL
      IDENTITY (1,1),
   [liberty_details_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [send_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [response_type] [smallint] NULL,
   [response_text] [varchar](500) NULL

   ,CONSTRAINT [PK_rxntliberty_transmittals] PRIMARY KEY CLUSTERED ([rlt_id])
)


GO
CREATE TABLE [dbo].[rxnttemprx] (
   [pres_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pres_entry_date] [datetime] NULL,
   [pres_read_date] [datetime] NULL,
   [only_faxed] [bit] NULL,
   [pharm_viewed] [bit] NOT NULL,
   [off_dr_list] [bit] NOT NULL,
   [opener_user_id] [int] NOT NULL,
   [pres_is_refill] [bit] NOT NULL,
   [rx_number] [varchar](50) NOT NULL,
   [last_pharm_name] [varchar](80) NOT NULL,
   [last_pharm_address] [varchar](50) NOT NULL,
   [last_pharm_city] [varchar](30) NOT NULL,
   [last_pharm_state] [varchar](30) NOT NULL,
   [last_pharm_phone] [varchar](30) NOT NULL,
   [pharm_state_holder] [varchar](50) NOT NULL,
   [pharm_city_holder] [varchar](50) NOT NULL,
   [pharm_id_holder] [varchar](20) NOT NULL,
   [fax_conf_send_date] [datetime] NULL,
   [fax_conf_numb_pages] [int] NULL,
   [fax_conf_remote_fax_id] [varchar](100) NULL,
   [fax_conf_error_string] [varchar](600) NULL,
   [pres_delivery_method] [int] NULL,
   [prim_dr_id] [int] NOT NULL,
   [print_count] [int] NOT NULL,
   [pda_written] [bit] NOT NULL,
   [authorizing_dr_id] [int] NULL,
   [sfi_is_sfi] [bit] NOT NULL,
   [sfi_pres_id] [varchar](50) NULL,
   [field_not_used1] [int] NULL,
   [admin_notes] [varchar](600) NULL,
   [pres_approved_date] [datetime] NULL,
   [pres_void] [bit] NULL,
   [last_edit_date] [datetime] NULL,
   [last_edit_dr_id] [int] NULL,
   [pres_prescription_type] [int] NULL,
   [pres_void_comments] [varchar](255) NULL,
   [eligibility_checked] [bit] NULL,
   [eligibility_trans_id] [int] NULL,
   [off_pharm_list] [bit] NOT NULL,
   [DoPrintAfterPatHistory] [bit] NOT NULL,
   [DoPrintAfterPatOrig] [bit] NOT NULL,
   [DoPrintAfterPatCopy] [bit] NOT NULL,
   [DoPrintAfterPatMonograph] [bit] NOT NULL,
   [PatOrigPrintType] [int] NOT NULL,
   [PrintHistoryBackMonths] [int] NOT NULL,
   [DoPrintAfterScriptGuide] [bit] NOT NULL,
   [approve_source] [varchar](1) NULL,
   [pres_void_code] [smallint] NULL,
   [send_count] [smallint] NOT NULL,
   [print_options] [int] NOT NULL,
   [writing_dr_id] [int] NULL,
   [presc_src] [tinyint] NULL

   ,CONSTRAINT [PK_rxnttemprx] PRIMARY KEY CLUSTERED ([pres_id])
)


GO
CREATE TABLE [dbo].[rxnt_coupons] (
   [coupon_id] [int] NOT NULL
      IDENTITY (1,1),
   [med_id] [int] NOT NULL,
   [offer_id] [varchar](50) NULL,
   [med_name] [varchar](125) NOT NULL,
   [med_resolution_type] [tinyint] NOT NULL,
   [start_date] [smalldatetime] NOT NULL,
   [end_date] [smalldatetime] NOT NULL,
   [sponsor_id] [smallint] NOT NULL,
   [is_complete] [bit] NOT NULL,
   [filename] [varchar](1024) NULL,
   [sex_filter] [varchar](1) NULL,
   [age_filter] [bit] NOT NULL,
   [min_age] [smallint] NOT NULL,
   [max_age] [smallint] NOT NULL,
   [state_exclusion] [varchar](1024) NULL,
   [zip_codes] [varchar](1024) NULL,
   [speciality_codes] [varchar](1024) NULL,
   [rx_bin] [varchar](50) NULL,
   [rx_grp] [varchar](50) NULL,
   [rx_pcn] [varchar](50) NULL,
   [rx_bin_coords] [varchar](50) NULL,
   [rx_grp_coords] [varchar](50) NULL,
   [rx_pcn_coords] [varchar](50) NULL,
   [rx_id_coords] [varchar](50) NULL,
   [pharmacy_comments] [varchar](500) NULL,
   [is_pharm_comment] [bit] NOT NULL,
   [is_new_pat] [bit] NOT NULL,
   [rx_payer_id] [varchar](50) NULL,
   [rx_payer_name] [varchar](50) NULL,
   [rx_payer_type] [varchar](50) NULL,
   [title] [varchar](30) NOT NULL,
   [disclaimer] [varchar](255) NULL

   ,CONSTRAINT [PK_rxnt_coupons] PRIMARY KEY CLUSTERED ([coupon_id])
)

CREATE NONCLUSTERED INDEX [IX_rxnt_coupons] ON [dbo].[rxnt_coupons] ([start_date], [end_date], [med_id])

GO
CREATE TABLE [dbo].[rxnt_coupon_users] (
   [user_id] [int] NOT NULL
      IDENTITY (1,1),
   [first_name] [varchar](50) NOT NULL,
   [middle_name] [varchar](10) NOT NULL,
   [last_name] [varchar](50) NOT NULL,
   [email] [varchar](50) NOT NULL,
   [phone] [varchar](12) NOT NULL,
   [username] [varchar](25) NOT NULL,
   [password] [varchar](512) NOT NULL,
   [salt] [varchar](50) NOT NULL,
   [is_enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_rxnt_coupon_users] PRIMARY KEY CLUSTERED ([user_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_rxnt_coupon_users] ON [dbo].[rxnt_coupon_users] ([username])

GO
CREATE TABLE [dbo].[rxnt_experian_log] (
   [rxnt_experian_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [date] [datetime] NOT NULL,
   [session_id] [varchar](200) NOT NULL,
   [dr_id] [int] NOT NULL,
   [request] [text] NOT NULL,
   [response] [text] NOT NULL

   ,CONSTRAINT [PK_rxnt_experian_log] PRIMARY KEY CLUSTERED ([rxnt_experian_log_id])
)


GO
CREATE TABLE [dbo].[rxnt_experian_terms] (
   [rxnt_experian_terms_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [terms_accepted] [bit] NOT NULL,
   [accepted_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_rxnt_experian_terms] PRIMARY KEY CLUSTERED ([rxnt_experian_terms_id])
)


GO
CREATE TABLE [dbo].[RxNT_Interface_Logs] (
   [RxNT_Interface_Log_Id] [int] NOT NULL
      IDENTITY (1,1),
   [RecIDentifier] [varchar](50) NULL,
   [ReceivedDatetime] [datetime] NULL,
   [PartnerName] [varchar](50) NULL,
   [IncomingIPAddress] [varchar](50) NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [msgText] [varchar](max) NULL

   ,CONSTRAINT [PK_RxNT_Interface_Logs_new] PRIMARY KEY CLUSTERED ([RxNT_Interface_Log_Id])
)


GO
CREATE TABLE [dbo].[RxNT_Interface_Logs_Archive] (
   [RxNT_Interface_Log_Id] [int] NOT NULL
      IDENTITY (1,1),
   [RecIDentifier] [varchar](50) NULL,
   [ReceivedDatetime] [datetime] NULL,
   [PartnerName] [varchar](50) NULL,
   [IncomingIPAddress] [varchar](50) NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [msgText] [varchar](max) NULL

   ,CONSTRAINT [PK_RxNT_Interface_Logs] PRIMARY KEY CLUSTERED ([RxNT_Interface_Log_Id])
)


GO
CREATE TABLE [dbo].[RxNT_Interface_Logs_Detail] (
   [log_details_id] [int] NOT NULL
      IDENTITY (1,1),
   [RecIDentifier] [nvarchar](max) NULL,
   [response] [nvarchar](max) NOT NULL,
   [status] [int] NULL,
   [CreatedDate] [datetime] NULL
)


GO
CREATE TABLE [dbo].[rxnt_patient_coupons] (
   [patient_coupon_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [med_id] [int] NOT NULL,
   [med_name] [varchar](125) NOT NULL,
   [filename] [varchar](1024) NULL,
   [coupon_id_coords] [varchar](50) NULL,
   [brochure_url] [varchar](100) NULL,
   [title] [varchar](30) NOT NULL,
   [disclaimer] [varchar](255) NULL

   ,CONSTRAINT [PK_rxnt_patient_coupons] PRIMARY KEY CLUSTERED ([patient_coupon_id])
)


GO
CREATE TABLE [dbo].[rxnt_patient_coupon_batches] (
   [cp_bt_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [patient_coupon_id] [bigint] NOT NULL,
   [pa_coupon_batch_id] [bigint] NOT NULL

   ,CONSTRAINT [PK_rxnt_patient_coupon_batches] PRIMARY KEY CLUSTERED ([cp_bt_id])
)


GO
CREATE TABLE [dbo].[rxnt_patient_coupon_identifiers] (
   [coupon_identifier_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_coupon_batch_id] [bigint] NOT NULL,
   [client_provided_id] [varchar](50) NOT NULL,
   [expiry_date] [datetime] NULL,
   [taken_date] [datetime] NULL,
   [taken_by_pa_id] [bigint] NULL,
   [taken_batch_id] [varchar](50) NULL,
   [is_used] [bit] NOT NULL,
   [used_by_pa_id] [bigint] NULL,
   [used_date] [datetime] NULL

   ,CONSTRAINT [PK_rxnt_patient_coupon_identifiers] PRIMARY KEY CLUSTERED ([coupon_identifier_id])
)


GO
CREATE TABLE [dbo].[rxnt_sg_promotions] (
   [ad_id] [int] NOT NULL
      IDENTITY (1,1),
   [medid] [int] NOT NULL,
   [med_name] [varchar](255) NOT NULL,
   [dtStart] [smalldatetime] NULL,
   [dtEnd] [smalldatetime] NULL,
   [state_exclusion] [varchar](225) NULL,
   [min_age] [int] NOT NULL,
   [iscomplete] [bit] NOT NULL,
   [max_age] [int] NOT NULL,
   [gender] [varchar](2) NULL,
   [ctrl_fac] [float] NOT NULL,
   [message] [varchar](max) NULL,
   [name] [varchar](100) NULL,
   [session_count] [bigint] NULL,
   [current_count] [bigint] NULL,
   [type] [smallint] NOT NULL,
   [speciality_1] [tinyint] NOT NULL,
   [speciality_2] [tinyint] NOT NULL,
   [speciality_3] [tinyint] NOT NULL,
   [url] [varchar](255) NOT NULL,
   [clickthroughs] [int] NOT NULL,
   [sponsor_id] [int] NOT NULL,
   [increments] [bigint] NULL,
   [message_2] [varchar](100) NULL,
   [previous_count] [int] NULL,
   [Active] [bit] NULL,
   [CreatedDate] [datetime2] NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [resource_path] [varchar](200) NULL,
   [TargetedPlatform] [varchar](64) NULL,
   [Drugs] [varchar](5000) NULL,
   [ICD10] [varchar](5000) NULL,
   [Speciality] [varchar](5000) NULL,
   [CampaignId] [varchar](20) NULL

   ,CONSTRAINT [PK_rxnt_sg_promotions] PRIMARY KEY CLUSTERED ([ad_id])
)

CREATE NONCLUSTERED INDEX [IX_rxnt_sg_promotions] ON [dbo].[rxnt_sg_promotions] ([dtStart], [dtEnd], [iscomplete], [medid])

GO
CREATE TABLE [dbo].[rxnt_sg_promotions_count] (
   [ad_count_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [ad_id] [int] NOT NULL,
   [dtstart] [smalldatetime] NOT NULL,
   [dtEnd] [smalldatetime] NOT NULL,
   [total] [int] NOT NULL

   ,CONSTRAINT [PK_rxnt_sg_promotions_count] PRIMARY KEY CLUSTERED ([ad_count_id])
)


GO
CREATE TABLE [dbo].[rxnt_sg_promo_exclude] (
   [ad_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [exclude_status] [bit] NOT NULL,
   [promo_exclude_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_rxnt_sg_promo_exclude] PRIMARY KEY CLUSTERED ([promo_exclude_id])
)

CREATE NONCLUSTERED INDEX [IX_rxnt_sg_promo_exclude] ON [dbo].[rxnt_sg_promo_exclude] ([dr_id], [ad_id])

GO
CREATE TABLE [dbo].[rxnt_sg_promo_NPIExclusions] (
   [SGPromoNPIExclusionID] [int] NOT NULL
      IDENTITY (1,1),
   [ForADID] [int] NOT NULL,
   [NPI] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_SGPromoNPIExclusions] PRIMARY KEY CLUSTERED ([SGPromoNPIExclusionID])
)


GO
CREATE TABLE [dbo].[rxnt_sg_promo_views] (
   [ad_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [ad_date] [smalldatetime] NOT NULL,
   [promo_views_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_rxnt_sg_promo_views] PRIMARY KEY CLUSTERED ([promo_views_id])
)


GO
CREATE TABLE [dbo].[rxnt_status_lookup] (
   [rxnt_status_id] [int] NOT NULL,
   [rxnt_status_name] [varchar](50) NULL

   ,CONSTRAINT [PK_rxnt_status_lookup] PRIMARY KEY CLUSTERED ([rxnt_status_id])
)


GO
CREATE TABLE [dbo].[sales_person_info] (
   [sale_person_id] [smallint] NOT NULL
      IDENTITY (1,1),
   [sale_person_fname] [varchar](50) NOT NULL,
   [sale_person_mi] [varchar](10) NOT NULL,
   [sale_person_lname] [varchar](50) NOT NULL,
   [ACTIVE] [bit] NOT NULL,
   [admin_company_id] [int] NOT NULL,
   [email] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_sales_person_info] PRIMARY KEY CLUSTERED ([sale_person_id])
)


GO
CREATE TABLE [dbo].[ScalabullLog] (
   [ScalabullLogId] [bigint] NOT NULL
      IDENTITY (1,1),
   [lab_master_id] [bigint] NOT NULL,
   [message_type] [varchar](50) NOT NULL,
   [status] [bit] NOT NULL,
   [statusresponse] [varchar](max) NULL,
   [receive_date] [datetime] NOT NULL,
   [request_message] [varchar](max) NULL,
   [response_message] [varchar](max) NULL,
   [http_response_code] [varchar](50) NULL

   ,CONSTRAINT [PK_ScalabullLog] PRIMARY KEY CLUSTERED ([ScalabullLogId])
)


GO
CREATE TABLE [dbo].[scheduled_events] (
   [se_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [for_user_id] [int] NOT NULL,
   [entry_user_id] [int] NOT NULL,
   [entry_date] [datetime] NOT NULL,
   [first_fire_date] [datetime] NOT NULL,
   [next_fire_date] [datetime] NOT NULL,
   [event_type] [int] NOT NULL,
   [event_text] [varchar](255) NOT NULL,
   [fire_count] [int] NOT NULL,
   [repeat_unit] [varchar](4) NOT NULL,
   [repeat_interval] [int] NOT NULL,
   [repeat_count] [int] NOT NULL,
   [event_flags] [int] NOT NULL,
   [parent_event_id] [int] NOT NULL

   ,CONSTRAINT [PK_scheduled_events] PRIMARY KEY CLUSTERED ([se_id])
)

CREATE NONCLUSTERED INDEX [Index_users] ON [dbo].[scheduled_events] ([pd_id], [for_user_id], [entry_user_id])
CREATE NONCLUSTERED INDEX [scheduled_index_dates] ON [dbo].[scheduled_events] ([pd_id], [entry_date], [first_fire_date], [next_fire_date])
CREATE NONCLUSTERED INDEX [schedules_index_event] ON [dbo].[scheduled_events] ([pd_id], [event_type])

GO
CREATE TABLE [dbo].[scheduled_events_exclusions] (
   [see_id] [int] NOT NULL
      IDENTITY (1,1),
   [se_id] [int] NOT NULL,
   [exclusion_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_scheduled_events_exclusions] PRIMARY KEY CLUSTERED ([see_id])
)


GO
CREATE TABLE [dbo].[scheduled_rx_archive] (
   [pres_id] [int] NOT NULL,
   [pd_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [pa_first] [varchar](50) NOT NULL,
   [pa_middle] [varchar](50) NOT NULL,
   [pa_last] [varchar](50) NOT NULL,
   [pa_dob] [smalldatetime] NOT NULL,
   [pa_gender] [varchar](1) NOT NULL,
   [pa_address1] [varchar](100) NOT NULL,
   [pa_address2] [varchar](100) NOT NULL,
   [pa_city] [varchar](50) NOT NULL,
   [pa_state] [varchar](2) NOT NULL,
   [pa_zip] [varchar](20) NOT NULL,
   [dr_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [dr_first_name] [varchar](50) NOT NULL,
   [dr_middle_initial] [varchar](10) NOT NULL,
   [dr_last_name] [varchar](50) NOT NULL,
   [dr_address1] [varchar](100) NOT NULL,
   [dr_address2] [varchar](100) NOT NULL,
   [dr_city] [varchar](30) NOT NULL,
   [dr_state] [varchar](50) NOT NULL,
   [dr_zip] [varchar](20) NOT NULL,
   [dr_dea_numb] [varchar](30) NOT NULL,
   [ddid] [int] NOT NULL,
   [drug_name] [varchar](125) NOT NULL,
   [dosage] [varchar](255) NOT NULL,
   [qty] [varchar](20) NOT NULL,
   [units] [varchar](50) NOT NULL,
   [days_supply] [int] NOT NULL,
   [refills] [int] NOT NULL,
   [approved_date] [smalldatetime] NOT NULL,
   [signature] [varchar](max) NOT NULL,
   [scheduled_rx_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [signature_version] [varchar](10) NULL

   ,CONSTRAINT [IX_scheduled_rx_archive] UNIQUE NONCLUSTERED ([pres_id], [pd_id])
   ,CONSTRAINT [PK_scheduled_rx_archive] PRIMARY KEY NONCLUSTERED ([scheduled_rx_id])
)

CREATE CLUSTERED INDEX [IX_scheduled_rx_archive_1] ON [dbo].[scheduled_rx_archive] ([dg_id])
CREATE NONCLUSTERED INDEX [IX_scheduled_rx_archive_2] ON [dbo].[scheduled_rx_archive] ([pa_id], [dr_id])

GO
CREATE TABLE [dbo].[scheduler_deletion_log] (
   [sch_log_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NULL,
   [deletion_date] [datetime] NULL,
   [reason] [varchar](1000) NULL,
   [event_id] [int] NULL

   ,CONSTRAINT [PK__schedule__DFC97B7769B40561] PRIMARY KEY CLUSTERED ([sch_log_id])
)


GO
CREATE TABLE [dbo].[scheduler_main] (
   [event_id] [int] NOT NULL
      IDENTITY (1,1),
   [event_start_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [type] [smallint] NOT NULL,
   [ext_link_id] [int] NOT NULL,
   [note] [varchar](100) NOT NULL,
   [detail_header] [varchar](200) NOT NULL,
   [event_end_date] [datetime] NOT NULL,
   [is_new_pat] [bit] NOT NULL,
   [recurrence] [varchar](1024) NULL,
   [recurrence_parent] [int] NULL,
   [status] [tinyint] NOT NULL,
   [dtCheckIn] [datetime] NULL,
   [dtCalled] [datetime] NULL,
   [dtCheckedOut] [datetime] NULL,
   [dtintake] [smalldatetime] NULL,
   [case_id] [int] NULL,
   [room_id] [int] NULL,
   [reason] [varchar](125) NULL,
   [is_confirmed] [bit] NULL,
   [discharge_disposition_code] [varchar](2) NULL,
   [is_delete_attempt] [bit] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_scheduler_main] PRIMARY KEY NONCLUSTERED ([event_id])
)

CREATE CLUSTERED INDEX [DRID] ON [dbo].[scheduler_main] ([dr_id])
CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[scheduler_main] ([event_start_date], [dr_id], [ext_link_id], [event_end_date], [type], [case_id], [room_id])
CREATE NONCLUSTERED INDEX [IX_scheduler_main-ext_link_id] ON [dbo].[scheduler_main] ([ext_link_id])

GO
CREATE TABLE [dbo].[Scheduler_OfficeHours] (
   [OH_ID] [int] NOT NULL
      IDENTITY (1,1),
   [DG_ID] [bigint] NOT NULL,
   [START_TIME] [time] NULL,
   [END_TIME] [time] NULL,
   [LAST_MDFD_USER] [varchar](500) NULL,
   [LAST_MDFD_DATE] [datetime] NULL

   ,CONSTRAINT [PK__Schedule__9C5CBF663EC9A75C] PRIMARY KEY CLUSTERED ([OH_ID])
)


GO
CREATE TABLE [dbo].[scheduler_rooms] (
   [room_id] [int] NOT NULL
      IDENTITY (1,1),
   [room_name] [varchar](50) NOT NULL,
   [dg_id] [int] NOT NULL,
   [is_active] [bit] NOT NULL

   ,CONSTRAINT [PK_scheduler_rooms] PRIMARY KEY CLUSTERED ([room_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[scheduler_rooms] ([dg_id], [is_active])

GO
CREATE TABLE [dbo].[scheduler_types] (
   [scheduler_type_id] [smallint] NOT NULL
      IDENTITY (0,1),
   [dc_id] [int] NULL,
   [type_text] [varchar](50) NOT NULL,
   [is_active] [bit] NOT NULL,
   [color] [varchar](10) NULL,
   [duration] [varchar](10) NULL

   ,CONSTRAINT [PK_scheduler_types] PRIMARY KEY CLUSTERED ([scheduler_type_id])
)


GO
CREATE TABLE [dbo].[ScriptGuideCoupons] (
   [SGCouponID] [int] NOT NULL
      IDENTITY (1,1),
   [ForSGID] [int] NOT NULL,
   [SGCouponCode] [varchar](50) NOT NULL,
   [used] [bit] NOT NULL

   ,CONSTRAINT [PK_ScriptGuideCoupons] PRIMARY KEY CLUSTERED ([SGCouponID])
)


GO
CREATE TABLE [dbo].[ScriptGuideDrugIDs] (
   [sg_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [sg_drug_xrefid] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_ScriptGuideDrugIDs] PRIMARY KEY CLUSTERED ([sg_drug_xrefid])
)

CREATE UNIQUE NONCLUSTERED INDEX [SGToDrugIDNoDupes] ON [dbo].[ScriptGuideDrugIDs] ([sg_id], [drug_id])

GO
CREATE TABLE [dbo].[ScriptGuideNPIExclusions] (
   [SGNPIExclusionID] [int] NOT NULL
      IDENTITY (1,1),
   [ForSGID] [int] NOT NULL,
   [NPI] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_ScriptGuideNPIExclusions] PRIMARY KEY CLUSTERED ([SGNPIExclusionID])
)

CREATE NONCLUSTERED INDEX [NC_ScriptGuideNPIExclusions_ForSGID] ON [dbo].[ScriptGuideNPIExclusions] ([ForSGID])

GO
CREATE TABLE [dbo].[ScriptGuideProgramSpecifications] (
   [sg_id] [int] NOT NULL
      IDENTITY (1,1),
   [drug_name] [varchar](70) NOT NULL,
   [drug_id] [int] NOT NULL,
   [start_date] [smalldatetime] NOT NULL,
   [end_date] [smalldatetime] NOT NULL,
   [drug_id_type] [tinyint] NOT NULL,
   [trigger_type] [tinyint] NULL,
   [trigger_age_min] [int] NULL,
   [trigger_age_max] [int] NULL,
   [trigger_sex] [varchar](10) NULL,
   [control_factor] [float] NOT NULL,
   [scriptguide_file] [varchar](100) NULL,
   [test_count] [int] NULL,
   [control_count] [int] NULL,
   [total_count] AS ([test_count]+[control_count]),
   [sg_desc_text] [varchar](100) NOT NULL,
   [exclude_states] [varchar](255) NULL,
   [CODE] [varchar](5) NULL,
   [bRequireCoupon] [bit] NOT NULL,
   [bIsActive] [bit] NOT NULL,
   [rxbin] [varchar](100) NULL,
   [rxpcn] [varchar](100) NULL,
   [rxgrp] [varchar](100) NULL,
   [rxsuf] [varchar](100) NULL

   ,CONSTRAINT [PK_ScriptGuideProgramSpecifications] PRIMARY KEY CLUSTERED ([sg_id])
)


GO
CREATE TABLE [dbo].[scriptguide_couponids] (
   [id] [int] NULL
)


GO
CREATE TABLE [dbo].[SEMIDOCIDS] (
   [drid] [int] NOT NULL

   ,CONSTRAINT [PK_SEMIDOCIDS] PRIMARY KEY CLUSTERED ([drid])
)


GO
CREATE TABLE [dbo].[snomed_ct_code_system] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [Name] [nvarchar](500) NOT NULL,
   [Description] [varchar](1000) NULL,
   [SnomedCode] [nvarchar](50) NOT NULL,
   [Category] [varchar](100) NULL

   ,CONSTRAINT [PK_snomed_ct_code_system] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[social_hx_migrated] (
   [patientid] [bigint] NOT NULL

   ,CONSTRAINT [PK_social_hx_migrated] PRIMARY KEY CLUSTERED ([patientid])
)


GO
CREATE TABLE [spe].[SPEMessages] (
   [spo_ir_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NULL,
   [is_success] [bit] NULL,
   [queued_date] [datetime] NULL,
   [send_date] [datetime] NULL,
   [request_id] [varchar](50) NULL,
   [request] [varchar](max) NULL,
   [response_date] [datetime] NULL,
   [response_id] [varchar](50) NULL,
   [response_message] [varchar](max) NULL,
   [response_code] [varchar](10) NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL,
   [async_response] [varchar](max) NULL,
   [async_response_text] [varchar](2000) NULL,
   [async_response_date] [datetime] NULL,
   [message_type] [int] NULL

   ,CONSTRAINT [PK_SPOInitiationRequests] PRIMARY KEY CLUSTERED ([spo_ir_id])
)


GO
CREATE TABLE [spe].[SurescriptsSpecialtyIdentificationDetails] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [NDC] [varchar](11) NOT NULL,
   [RXCUI] [varchar](8) NULL,
   [IsSpecialty] [bit] NOT NULL,
   [PerformedOn] [datetime] NULL

   ,CONSTRAINT [PK_SurescriptsSpecialtyIdentificationDetails] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[sponsored_drug_XRef] (
   [sponsor_id] [int] NOT NULL,
   [equiv_drug_id] [int] NOT NULL,
   [sponsored_drug_id] [int] NOT NULL

   ,CONSTRAINT [PK_sponsored_drug_XRef] PRIMARY KEY CLUSTERED ([sponsor_id], [equiv_drug_id], [sponsored_drug_id])
)


GO
CREATE TABLE [dbo].[sponsors] (
   [sponsor_id] [int] NOT NULL
      IDENTITY (1,1),
   [sponsor_name] [varchar](100) NOT NULL,
   [sponsor_lbl] [varchar](50) NOT NULL,
   [sponsor_type_id] [int] NOT NULL,
   [sponsor_msg] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_sponsors] PRIMARY KEY CLUSTERED ([sponsor_id])
)


GO
CREATE TABLE [dbo].[sponsor_types] (
   [sponsor_type_id] [int] NOT NULL
      IDENTITY (1,1),
   [sponsor_type] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_sponsor_types] PRIMARY KEY CLUSTERED ([sponsor_type_id])
)


GO
CREATE TABLE [dbo].[State] (
   [state_code] [varchar](10) NOT NULL,
   [state] [varchar](50) NOT NULL,
   [created_date] [datetime] NULL,
   [created_user] [varchar](50) NULL,
   [modified_date] [datetime] NULL,
   [modified_user] [varchar](50) NULL,
   [time_zone] [varchar](5) NULL,
   [time_difference] [tinyint] NULL
)


GO
CREATE TABLE [dbo].[StoreCategories] (
   [C_ID] [int] NOT NULL
      IDENTITY (1,1),
   [C_Name] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_Categories] PRIMARY KEY NONCLUSTERED ([C_ID])
)


GO
CREATE TABLE [dbo].[StoreCategoryProductTypes] (
   [CPT_ID] [int] NOT NULL
      IDENTITY (1,1),
   [C_ID] [int] NULL,
   [CPT_Name] [varchar](255) NULL,
   [CPT_Description] [varchar](4000) NULL,
   [CPT_ThumbImage] [varchar](400) NULL,
   [CPT_ThumbImageW] [varchar](10) NULL,
   [CPT_ThumbImageH] [varchar](10) NULL,
   [CPT_InActive] [bit] NULL,
   [SortID] [int] NOT NULL

   ,CONSTRAINT [PK_CategoryProductTypes] PRIMARY KEY NONCLUSTERED ([CPT_ID])
)


GO
CREATE TABLE [dbo].[StoreGlobalSettings] (
   [SSID] [int] NOT NULL
      IDENTITY (1,1),
   [HomePageProductListTitle] [varchar](255) NOT NULL

   ,CONSTRAINT [PK_StoreGlobalSettings] PRIMARY KEY CLUSTERED ([SSID])
)


GO
CREATE TABLE [dbo].[StoreOrderDetails] (
   [OrderDetailID] [int] NOT NULL
      IDENTITY (1,1),
   [OrderID] [int] NULL,
   [ProductID] [int] NULL,
   [ProductCode] [varchar](50) NULL,
   [ProductName] [varchar](200) NULL,
   [Quantity] [int] NULL,
   [UnitPrice] [money] NULL,
   [ProductWeight] [float] NULL,
   [ConfigDetails] [varchar](400) NULL

   ,CONSTRAINT [PK_OrderDetails] PRIMARY KEY NONCLUSTERED ([OrderDetailID])
)


GO
CREATE TABLE [dbo].[StoreOrders] (
   [OrderID] [int] NOT NULL
      IDENTITY (1,1),
   [CustomerID] [int] NULL,
   [OrderDate] [datetime] NULL,
   [ShippingFirstName] [varchar](50) NULL,
   [ShippingLastName] [varchar](50) NULL,
   [ShippingAddress1] [varchar](255) NULL,
   [ShippingAddress2] [varchar](255) NULL,
   [ShippingCity] [varchar](50) NULL,
   [ShippingStateOrProvince] [varchar](100) NULL,
   [ShippingPostalCode] [varchar](20) NULL,
   [ShippingCountryID] [int] NULL,
   [ShippingPhoneNumber] [varchar](30) NULL,
   [ShipDate] [datetime] NULL,
   [ShippingMethodCode] [varchar](10) NULL,
   [ShippingCharge] [money] NULL,
   [SalesTaxRate] [float] NOT NULL,
   [Processed] [bit] NOT NULL,
   [UPSTrackingNumber] [varchar](50) NOT NULL,
   [CCFailed] [bit] NOT NULL,
   [CCFailReason] [varchar](6000) NOT NULL,
   [QEmpID] [int] NOT NULL,
   [Void] [bit] NOT NULL,
   [RoyaltyBilled] [bit] NOT NULL,
   [RoyaltyPaid] [bit] NOT NULL

   ,CONSTRAINT [PK_Orders] PRIMARY KEY NONCLUSTERED ([OrderID])
)


GO
CREATE TABLE [dbo].[StorePaymentMethods] (
   [PaymentMethodID] [int] NOT NULL
      IDENTITY (1,1),
   [PaymentMethod] [varchar](50) NOT NULL,
   [MethodCode] [varchar](30) NOT NULL,
   [Enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_PaymentMethods] PRIMARY KEY NONCLUSTERED ([PaymentMethodID])
)


GO
CREATE TABLE [dbo].[StorePayments] (
   [PaymentID] [int] NOT NULL
      IDENTITY (1,1),
   [OrderID] [int] NULL,
   [PaymentAmount] [money] NULL,
   [PaymentDate] [datetime] NULL,
   [CardNumber] [varchar](30) NULL,
   [CardExpMonth] [varchar](10) NULL,
   [CardExpYear] [varchar](10) NULL,
   [ApprovalCode] [varchar](50) NULL,
   [CardType] [varchar](50) NULL,
   [RemoteTransID] [varchar](50) NULL,
   [CVV2] [varchar](50) NULL,
   [NameOnCard_F] [varchar](100) NULL,
   [NameOnCard_L] [varchar](100) NULL,
   [AVSCode] [varchar](50) NULL,
   [BillingFirstName] [varchar](50) NULL,
   [BillingLastName] [varchar](50) NULL,
   [BillingAddress1] [varchar](255) NULL,
   [BillingAddress2] [varchar](255) NULL,
   [BillingCity] [varchar](100) NULL,
   [BillingStateOrProvince] [varchar](50) NULL,
   [BillingPostalCode] [varchar](50) NULL,
   [BillingCountryID] [int] NULL,
   [BillingPhoneNumber] [varchar](50) NULL,
   [PaymentType] [varchar](2) NOT NULL,
   [PONumber] [varchar](50) NOT NULL,
   [POPaid] [bit] NOT NULL

   ,CONSTRAINT [PK_Payments] PRIMARY KEY NONCLUSTERED ([PaymentID])
)


GO
CREATE TABLE [dbo].[StoreProductAttributes] (
   [PAID] [int] NOT NULL
      IDENTITY (1,1),
   [ProductID] [int] NOT NULL,
   [PADesc] [varchar](50) NOT NULL,
   [PASortID] [int] NOT NULL,
   [PACostPlus] [money] NOT NULL,
   [PAOptionIndex] [int] NOT NULL,
   [PAColorHEX] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_StoreProductAttributes] PRIMARY KEY CLUSTERED ([PAID])
)


GO
CREATE TABLE [dbo].[StoreProductCPT] (
   [Product_CPT_ID] [int] NOT NULL
      IDENTITY (1,1),
   [ProductID] [int] NOT NULL,
   [CPT_ID] [int] NOT NULL,
   [SortID] [int] NOT NULL

   ,CONSTRAINT [PK_Product_CPT] PRIMARY KEY NONCLUSTERED ([Product_CPT_ID])
)


GO
CREATE TABLE [dbo].[StoreProducts] (
   [ProductID] [int] NOT NULL
      IDENTITY (1,1),
   [ProductCode] [varchar](50) NULL,
   [ProductIntroductionDate] [smalldatetime] NULL,
   [ProductName] [varchar](50) NULL,
   [ProductDescription] [varchar](400) NULL,
   [ProductSmallImage] [varchar](255) NULL,
   [ProductLargeImage] [varchar](255) NULL,
   [UnitPrice] [money] NULL,
   [Discount] [float] NULL,
   [ShipCost] [money] NULL,
   [StockStatus] [varchar](100) NULL,
   [KeyWords] [varchar](255) NULL,
   [InActive] [bit] NOT NULL,
   [SmallImageWidth] [varchar](10) NULL,
   [SmallImageHeight] [varchar](10) NULL,
   [LargeImageWidth] [varchar](10) NULL,
   [LargeImageHeight] [varchar](10) NULL,
   [ProductLongDescription] [varchar](2000) NULL,
   [ProductWeight] [float] NULL,
   [UserField1Label] [varchar](50) NULL,
   [UserField1Options] [varchar](1000) NULL,
   [UserField2Label] [varchar](50) NULL,
   [UserField2Options] [varchar](1000) NULL,
   [ShowOnHomePage] [bit] NOT NULL,
   [QEmployeeCost] [money] NULL,
   [SalePrice] AS ([UnitPrice]-[UnitPrice]*([Discount]/(100))),
   [ForEmployeesOnly] [bit] NULL,
   [SortID] [int] NOT NULL,
   [UserField3Label] [varchar](50) NULL,
   [UserField3Options] [varchar](1000) NULL,
   [UserField4Label] [varchar](50) NULL,
   [UserField4Options] [varchar](1000) NULL,
   [PriceUnits] [varchar](100) NULL

   ,CONSTRAINT [PK_StoreProducts] PRIMARY KEY CLUSTERED ([ProductID])
)


GO
CREATE TABLE [dbo].[StoreSalesReports] (
   [SSRID] [int] NOT NULL
      IDENTITY (1,1),
   [SSRDate] [datetime] NOT NULL,
   [SSRNotes] [varchar](1000) NOT NULL,
   [SSRNTUserName] [varchar](100) NOT NULL,
   [SSRPaid] [bit] NOT NULL

   ,CONSTRAINT [PK_StoreSalesReports] PRIMARY KEY CLUSTERED ([SSRID])
)


GO
CREATE TABLE [dbo].[StoreSalesReportsOrders] (
   [SSRID] [int] NOT NULL,
   [OrderID] [int] NOT NULL

   ,CONSTRAINT [PK_StoreSalesReportsOrders] PRIMARY KEY CLUSTERED ([SSRID], [OrderID])
)


GO
CREATE TABLE [dbo].[StoreShippingMethods] (
   [ShippingMethodID] [int] NOT NULL
      IDENTITY (1,1),
   [ShippingMethod] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_ShippingMethods] PRIMARY KEY NONCLUSTERED ([ShippingMethodID])
)


GO
CREATE TABLE [support].[Patients_Copy_Data_Ref] (
   [CopyDataRef_Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [CopyRef_Id] [bigint] NULL,
   [Type] [varchar](30) NULL,
   [CreatedOn] [datetime] NULL,
   [Old_DataRef_Id] [bigint] NULL,
   [New_DataRef_Id] [bigint] NULL,
   [Is_Copied] [bit] NULL

   ,CONSTRAINT [PK_Patients_Copy_Data_Ref] PRIMARY KEY CLUSTERED ([CopyDataRef_Id])
)


GO
CREATE TABLE [support].[Patients_Copy_Ref] (
   [CopyRef_Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [Old_PatID] [int] NOT NULL,
   [New_PatID] [int] NOT NULL,
   [Old_DGID] [int] NOT NULL,
   [New_DGID] [int] NOT NULL,
   [Old_DCID] [int] NOT NULL,
   [New_DCID] [int] NOT NULL,
   [CopyCompleted] [bit] NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastUpdatedOn] [datetime] NULL,
   [New_DRID] [bigint] NOT NULL,
   [Old_DRID] [bigint] NOT NULL

   ,CONSTRAINT [PK_Patients_Copy_Ref] PRIMARY KEY CLUSTERED ([CopyRef_Id])
)


GO
CREATE TABLE [support].[Patients_Copy_Ref_Extended] (
   [CopyRef_Id] [bigint] NOT NULL,
   [PatientExtendedDetailsCopied] [bit] NULL,
   [PatientActiveMedsCopied] [bit] NULL,
   [PatientActiveDiagnosisCopied] [bit] NULL,
   [PatientAllergiesCopied] [bit] NULL,
   [PatientHistoryCopied] [bit] NULL,
   [PatientImmunizationsCopied] [bit] NULL,
   [PatientProceduresCopied] [bit] NULL,
   [PatientReferralsCopied] [bit] NULL,
   [PatientVitalsCopied] [bit] NULL,
   [PatientDocumentsCopied] [bit] NULL,
   [PatientEncounterCopied] [bit] NULL,
   [PatientLabOrdersCopied] [bit] NULL,
   [PatientLabResultsCopied] [bit] NULL,
   [CreatedOn] [datetime] NULL,
   [LastUpdatedOn] [datetime] NULL,
   [PatientFavouritePharmaciesCopied] [bit] NULL,
   [PatientNotesCopied] [bit] NULL,
   [PatientPrescriptionsCopied] [bit] NULL,
   [PatientPrescriptionsArchiveCopied] [int] NULL,
   [PatientMedHxCopied] [bit] NULL,
   [PatientFormularyCopied] [bit] NULL,
   [PatientExternalFormularyCopied] [bit] NULL

   ,CONSTRAINT [PK_Patients_Copy_Ref_Extended] PRIMARY KEY CLUSTERED ([CopyRef_Id])
)


GO
CREATE TABLE [support].[refill_requests_ss_3357] (
   [refreq_id] [int] NOT NULL,
   [pres_id] [int] NULL,
   [pd_id] [int] NULL,
   [old_drug_id] [int] NULL,
   [old_drug_name] [varchar](150) NULL,
   [old_drug_ndc] [varchar](30) NULL,
   [old_drug_level] [int] NULL,
   [is_incorrect] [bit] NULL,
   [created_on] [datetime] NULL,
   [is_corrected] [bit] NULL,
   [corrected_on] [datetime] NULL,
   [p_drug_id] [int] NULL,
   [p_drug_ndc] [varchar](30) NULL,
   [p_drug_name] [varchar](150) NULL,
   [p_drug_level] [int] NULL,
   [p_fdb_drug_name] [varchar](150) NULL,
   [d_drug_id] [int] NULL,
   [d_drug_ndc] [varchar](30) NULL,
   [d_drug_name] [varchar](150) NULL,
   [d_drug_level] [int] NULL,
   [d_fdb_drug_name] [varchar](150) NULL,
   [is_p_dugname_matches] [bit] NULL

   ,CONSTRAINT [PK_refill_requests_ss_3357] PRIMARY KEY NONCLUSTERED ([refreq_id])
)


GO
CREATE TABLE [dbo].[surescripts_epa_messages] (
   [sem_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NULL,
   [prim_dr_id] [bigint] NULL,
   [pa_id] [bigint] NULL,
   [request_id] [varchar](100) NULL,
   [pa_reference_id] [varchar](100) NULL,
   [immediate_response_id] [varchar](100) NULL,
   [response_id] [varchar](100) NULL,
   [response_code] [varchar](50) NULL,
   [created_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [request_type] [varchar](50) NULL,
   [response_type] [varchar](50) NULL,
   [version] [varchar](10) NULL,
   [relatesto_message_id] [varchar](100) NULL

   ,CONSTRAINT [PK_surescript_epa_messages] PRIMARY KEY CLUSTERED ([sem_id])
)


GO
CREATE TABLE [dbo].[surescripts_epa_messages_ex] (
   [sem_ex_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [sem_id] [bigint] NOT NULL,
   [request] [xml] NULL,
   [response] [xml] NULL,
   [immediate_response] [varchar](max) NULL

   ,CONSTRAINT [PK_surescripts_epa_messages_ex] PRIMARY KEY CLUSTERED ([sem_ex_id])
)


GO
CREATE TABLE [dbo].[surescript_admin_message] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [messageid] [varchar](30) NULL,
   [response_type] [bit] NULL,
   [response_text] [varchar](2000) NULL,
   [send_date] [smalldatetime] NULL,
   [response_date] [smalldatetime] NULL,
   [message_type] [tinyint] NOT NULL,
   [dr_id] [int] NULL

   ,CONSTRAINT [PK_surescript_admin_message] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[surescript_medHx_messages] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [drid] [bigint] NULL,
   [patientid] [bigint] NULL,
   [requestid] [varchar](100) NULL,
   [responseid] [varchar](100) NULL,
   [startdate] [date] NULL,
   [enddate] [date] NULL,
   [request] [xml] NULL,
   [response] [xml] NULL,
   [createddate] [datetime] NULL,
   [request_type] [tinyint] NULL,
   [version] [varchar](10) NULL,
   [immediate_response_id] [varchar](100) NULL,
   [immediate_response] [varchar](max) NULL,
   [response_date] [datetime] NULL,
   [prim_dr_id] [bigint] NULL,
   [effective_end_date] [date] NULL,
   [relatesto_message_id] [varchar](100) NULL

   ,CONSTRAINT [PK_surescript_medHx_messages] PRIMARY KEY CLUSTERED ([id])
)

CREATE NONCLUSTERED INDEX [idx_surescript_medHx_messages_k4] ON [dbo].[surescript_medHx_messages] ([requestid])

GO
CREATE TABLE [dbo].[sysdiagrams] (
   [name] [nvarchar](128) NOT NULL,
   [principal_id] [int] NOT NULL,
   [diagram_id] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [definition] [varbinary](max) NULL

   ,CONSTRAINT [PK__sysdiagr__C2B05B6172536D03] PRIMARY KEY CLUSTERED ([diagram_id])
   ,CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED ([principal_id], [name])
)


GO
CREATE TABLE [dbo].[table_audit_log] (
   [audit_id] [uniqueidentifier] NOT NULL,
   [table_name] [varchar](100) NOT NULL,
   [dg_id] [int] NOT NULL,
   [src_id] [int] NOT NULL,
   [src_name] [varchar](50) NOT NULL,
   [target_id] [int] NOT NULL,
   [target_name] [varchar](50) NOT NULL,
   [evt_date] [smalldatetime] NOT NULL,
   [sql_login] [varchar](50) NOT NULL,
   [columns_updated] [xml] NULL

   ,CONSTRAINT [PK_table_audit_log] PRIMARY KEY CLUSTERED ([audit_id])
)


GO
CREATE TABLE [dbo].[tblCountries] (
   [lngCountryID] [int] NOT NULL,
   [strCountryName] [varchar](100) NOT NULL,
   [strUPSCountryCode] [varchar](3) NOT NULL,
   [bUPSZipRequired] [bit] NOT NULL,
   [strUPSWgtUnitMsr] [varchar](5) NOT NULL,
   [bEuroAllowed] [bit] NULL,
   [strUPSCurrencyCode] [varchar](50) NULL,
   [iMaxWeightLB] [int] NULL,
   [iMaxWeightKG] [int] NULL,
   [bHasUPSDelivery] [bit] NULL,
   [bStoreEnabled] [bit] NOT NULL

   ,CONSTRAINT [PK_tblCountries] PRIMARY KEY CLUSTERED ([lngCountryID])
)


GO
CREATE TABLE [dbo].[tblHealthGuidelines] (
   [rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [gender] [varchar](2) NULL,
   [added_by_dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [is_active] [bit] NULL,
   [name] [varchar](255) NULL,
   [supporting_url] [varchar](512) NULL,
   [reco_interval_min_days] [int] NULL,
   [reco_interval_max_days] [int] NULL,
   [min_age_days] [int] NULL,
   [max_age_days] [int] NULL,
   [grade] [varchar](2) NULL,
   [description] [ntext] NOT NULL,
   [service_type_id] [tinyint] NULL,
   [RecurrenceRule] [nvarchar](1024) NULL

   ,CONSTRAINT [PK_tblHealthGuidelines] PRIMARY KEY CLUSTERED ([rule_id])
)

CREATE NONCLUSTERED INDEX [IX_tblHealthGuidelines] ON [dbo].[tblHealthGuidelines] ([dg_id], [is_active])

GO
CREATE TABLE [dbo].[tblHealthGuidelinesCallHistory] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dgid] [bigint] NOT NULL,
   [patientid] [bigint] NOT NULL,
   [ruleid] [bigint] NOT NULL,
   [AccountSid] [varchar](50) NULL,
   [CallDuration] [float] NULL,
   [CallerName] [varchar](50) NULL,
   [CallSid] [varchar](50) NULL,
   [CallStatus] [varchar](30) NULL,
   [DialCallDuration] [varchar](10) NULL,
   [DialCallSid] [varchar](50) NULL,
   [DialCallStatus] [varchar](30) NULL,
   [Direction] [varchar](30) NULL,
   [From] [varchar](50) NULL,
   [To] [varchar](50) NULL,
   [CraetedOn] [datetime] NULL

   ,CONSTRAINT [PK__tblHealt__3214EC072F91856D] PRIMARY KEY CLUSTERED ([Id])
)


GO
CREATE TABLE [dbo].[tblHealthGuidelinesTemplates] (
   [template_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NULL,
   [template_name] [varchar](100) NULL,
   [template_path] [varchar](255) NULL,
   [template_type] [tinyint] NULL,
   [isactive] [bit] NULL,
   [added_by_dr_id] [bigint] NULL,
   [date_added] [smalldatetime] NULL

   ,CONSTRAINT [PK_tblHealthGuidelinesTemplates] PRIMARY KEY CLUSTERED ([template_id])
)


GO
CREATE TABLE [dbo].[tblHealthGuidelinesTemplatesFields] (
   [FieldId] [int] NOT NULL,
   [DisplayName] [varchar](50) NULL,
   [Tag] [varchar](50) NULL,
   [ParentFieldId] [int] NULL,
   [FieldGroupID] [int] NULL

   ,CONSTRAINT [PK__tblHealt__C8B6FF073826CB6E] PRIMARY KEY CLUSTERED ([FieldId])
)


GO
CREATE TABLE [dbo].[tblHealthGuidelines_Ex1] (
   [rule_id] [bigint] NULL,
   [RuleFilterConditions] [xml] NULL,
   [rule_message] [varchar](max) NULL,
   [email_template_id] [bigint] NULL,
   [mail_template_id] [bigint] NULL,
   [telephone_template_id] [bigint] NULL,
   [sms_template_id] [bigint] NULL,
   [caller_phone_id] [bigint] NULL,
   [RuleLastExecutedOn] [datetime] NULL,
   [RuleNextExecutionOn] [datetime] NULL
)


GO
CREATE TABLE [dbo].[tblPatientExternalVaccinationRecord] (
   [vac_rec_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [vac_id] [int] NOT NULL,
   [message_control_id] [varchar](100) NOT NULL,
   [vac_pat_id] [int] NOT NULL,
   [vac_dt_admin] [datetime] NULL,
   [vac_lot_no] [varchar](50) NULL,
   [vac_site] [varchar](100) NULL,
   [vac_dose] [varchar](225) NULL,
   [vac_exp_date] [datetime] NULL,
   [request_id] [int] NULL,
   [vac_reaction] [varchar](512) NULL,
   [vac_remarks] [varchar](512) NULL,
   [vac_name] [varchar](150) NULL,
   [vac_base_name] [varchar](150) NULL,
   [vis_date] [smalldatetime] NULL,
   [vis_given_date] [smalldatetime] NULL,
   [record_modified_date] [datetime] NULL,
   [vac_site_code] [varchar](10) NULL,
   [vac_dose_unit_code] [varchar](20) NULL,
   [vac_administered_code] [varchar](2) NULL,
   [vac_administered_by] [bigint] NULL,
   [vac_entered_by] [bigint] NULL,
   [substance_refusal_reason_code] [varchar](2) NULL,
   [disease_code] [varchar](10) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [vfc_eligibility_status] [varchar](10) NULL,
   [vfc_code] [varchar](10) NULL,
   [eligibility_category_code] [varchar](15) NULL,
   [route] [varchar](50) NULL,
   [route_code] [varchar](50) NULL,
   [vaccine_admin_status] [varchar](50) NULL,
   [action_code] [varchar](10) NULL,
   [vis_edition_date] [varchar](100) NULL,
   [cvx_code] [varchar](10) NULL,
   [mvx_code] [varchar](10) NULL,
   [manufacturer_name] [varchar](100) NULL,
   [is_reconciled] [bit] NULL,
   [reconciled_by] [int] NULL,
   [reconciled_at] [datetime] NULL

   ,CONSTRAINT [PK__tblPatientExternalVaccinationRe__503CB573] PRIMARY KEY CLUSTERED ([vac_rec_id])
)

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220228-150752] ON [dbo].[tblPatientExternalVaccinationRecord] ([message_control_id])

GO
CREATE TABLE [dbo].[tblPatientExternalVaccinationRequestDetails] (
   [request_details_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [message_control_id] [varchar](100) NOT NULL,
   [request_id] [bigint] NOT NULL,
   [outgoing_message] [varchar](max) NULL,
   [incoming_message] [varchar](max) NULL

   ,CONSTRAINT [UQ__tblPatie__18D3B90ED7938B43] UNIQUE NONCLUSTERED ([request_id])
)


GO
CREATE TABLE [dbo].[tblPatientExternalVaccinationRequests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [patient_id] [bigint] NOT NULL,
   [message_control_id] [varchar](100) NOT NULL,
   [dr_id] [bigint] NOT NULL,
   [request_file_path] [varchar](1000) NULL,
   [response_file_path] [varchar](1000) NULL,
   [requested_date] [datetime] NULL,
   [response_received_date] [datetime] NULL,
   [status] [varchar](100) NULL,
   [comments] [varchar](max) NULL

   ,CONSTRAINT [PK__tblPatie__18D3B90F0D0E0C90] PRIMARY KEY CLUSTERED ([request_id])
   ,CONSTRAINT [UQ__tblPatie__D665D431C8755ABE] UNIQUE NONCLUSTERED ([message_control_id])
)


GO
CREATE TABLE [dbo].[tblSecondserverlist] (
   [dc_id] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_tblSecondserverlist] PRIMARY KEY CLUSTERED ([dc_id])
)


GO
CREATE TABLE [dbo].[tblSubHealthGuidelines] (
   [sub_rule_id] [int] NOT NULL
      IDENTITY (1,1),
   [rule_id] [int] NOT NULL,
   [type] [tinyint] NOT NULL,
   [numeric_value] [decimal](10,2) NULL,
   [string_value] [varchar](255) NULL,
   [is_neg] [bit] NULL,
   [string_value2] [varchar](255) NULL

   ,CONSTRAINT [PK_tblSubHealthGuidelines] PRIMARY KEY CLUSTERED ([sub_rule_id])
)

CREATE NONCLUSTERED INDEX [IX_tblSubHealthGuidelines] ON [dbo].[tblSubHealthGuidelines] ([is_neg])

GO
CREATE TABLE [dbo].[tblTasks] (
   [task_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [task_name] [nvarchar](100) NOT NULL,
   [task_src] [int] NOT NULL,
   [task_dst] [int] NOT NULL,
   [date_created] [datetime] NOT NULL,
   [end_date] [datetime] NOT NULL,
   [priority] [tinyint] NOT NULL,
   [status] [tinyint] NOT NULL,
   [task_details] [ntext] NULL,
   [task_src_deleted] [bit] NULL,
   [task_dst_deleted] [bit] NULL

   ,CONSTRAINT [PK__tblTasks__29221CFB] PRIMARY KEY CLUSTERED ([task_id])
)

CREATE NONCLUSTERED INDEX [IX_tblTasks] ON [dbo].[tblTasks] ([end_date], [task_src], [task_dst], [priority], [status])

GO
CREATE TABLE [dbo].[tblVaccinationQueue] (
   [queue_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NOT NULL,
   [pat_id] [bigint] NOT NULL,
   [vac_rec_id] [bigint] NOT NULL,
   [isIncluded] [bit] NOT NULL,
   [exportedDate] [date] NULL,
   [FileName] [varchar](100) NULL
)


GO
CREATE TABLE [dbo].[tblVaccinationRecord] (
   [vac_rec_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [vac_id] [int] NOT NULL,
   [vac_pat_id] [int] NOT NULL,
   [vac_dt_admin] [datetime] NOT NULL,
   [vac_lot_no] [nvarchar](50) NOT NULL,
   [vac_site] [nvarchar](100) NOT NULL,
   [vac_dose] [nvarchar](225) NOT NULL,
   [vac_exp_date] [datetime] NOT NULL,
   [vac_dr_id] [int] NOT NULL,
   [vac_reaction] [nvarchar](512) NULL,
   [vac_remarks] [nvarchar](512) NULL,
   [vac_name] [varchar](150) NULL,
   [vis_date] [smalldatetime] NULL,
   [vis_given_date] [smalldatetime] NULL,
   [record_modified_date] [datetime] NULL,
   [vac_site_code] [varchar](10) NULL,
   [vac_dose_unit_code] [varchar](20) NULL,
   [vac_administered_code] [varchar](2) NULL,
   [vac_administered_by] [bigint] NULL,
   [vac_entered_by] [bigint] NULL,
   [substance_refusal_reason_code] [varchar](2) NULL,
   [disease_code] [varchar](10) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [VFC_Eligibility_Status] [varchar](10) NULL,
   [vfc_code] [varchar](10) NULL,
   [eligibility_category_code] [varchar](15) NULL,
   [route] [varchar](50) NULL,
   [route_code] [varchar](50) NULL,
   [vaccine_admin_status] [varchar](50) NULL,
   [action_code] [varchar](10) NULL,
   [vis_edition_date] [varchar](100) NULL,
   [external_vac_rec_id] [bigint] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK__tblVaccinationRe__503CB573] PRIMARY KEY CLUSTERED ([vac_rec_id])
)

CREATE NONCLUSTERED INDEX [IDX_tblVaccinationRecord_vac_pat_id] ON [dbo].[tblVaccinationRecord] ([vac_pat_id])
CREATE NONCLUSTERED INDEX [IX_tblVaccinationRecord] ON [dbo].[tblVaccinationRecord] ([vac_id], [vac_dr_id], [vac_pat_id], [vac_dt_admin])
CREATE UNIQUE NONCLUSTERED INDEX [UQ__tblVaccinationRecord__0000000000000041] ON [dbo].[tblVaccinationRecord] ([vac_rec_id])

GO
CREATE TABLE [dbo].[tblVaccineCVX] (
   [cvx_id] [int] NOT NULL
      IDENTITY (1,1),
   [cvx_name_short] [varchar](500) NOT NULL,
   [cvx_name_full] [varchar](500) NOT NULL,
   [cvx_code] [varchar](10) NOT NULL,
   [cvx_status] [varchar](20) NOT NULL,
   [last_updated_date] [datetime] NOT NULL,
   [notes] [varchar](max) NULL,
   [is_nonvaccine] [bit] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineCVX] PRIMARY KEY CLUSTERED ([cvx_id])
)


GO
CREATE TABLE [dbo].[tblVaccineCVXToVaccineGroupsMappings] (
   [map_id] [int] NOT NULL
      IDENTITY (1,1),
   [cvx_id] [int] NOT NULL,
   [vac_group_id] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineCVXToVaccineGroupsMappings] PRIMARY KEY CLUSTERED ([map_id])
)


GO
CREATE TABLE [dbo].[tblVaccineCVXToVaccineNDCMappings] (
   [ndc_map_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [NDCInnerID] [int] NULL,
   [UseUnitLabeler] [bigint] NULL,
   [UseUnitProduct] [bigint] NULL,
   [UseUnitPackage] [bigint] NULL,
   [UseUnitPropName] [varchar](max) NULL,
   [UseUnitGenericName] [varchar](max) NULL,
   [UseUnitLabelerName] [varchar](500) NULL,
   [UseUnitstartDate] [datetime] NULL,
   [UseUnitEndDate] [datetime] NULL,
   [UseUnitPackForm] [varchar](200) NULL,
   [UseUnitGTIN] [varchar](300) NULL,
   [CVXCode] [bigint] NULL,
   [CVXDescription] [varchar](max) NULL,
   [NoInner] [varchar](max) NULL,
   [NDC11] [varchar](max) NULL,
   [last_updated_date] [datetime] NULL,
   [GTIN] [varchar](max) NULL,
   [is_active] [bit] NULL

   ,CONSTRAINT [PK_tblVaccineCVXToVaccineNDCMappings] PRIMARY KEY CLUSTERED ([ndc_map_id])
)


GO
CREATE TABLE [dbo].[tblVaccineCVXToVISMappings] (
   [map_id] [int] NOT NULL
      IDENTITY (1,1),
   [cvx_id] [int] NOT NULL,
   [vis_concept_id] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL,
   [is_active] [bit] NULL

   ,CONSTRAINT [PK_tblVaccineCVXToVISMappings] PRIMARY KEY CLUSTERED ([map_id])
)


GO
CREATE TABLE [dbo].[tblVaccineGroups] (
   [vac_group_id] [int] NOT NULL
      IDENTITY (1,1),
   [vac_group_name] [varchar](50) NOT NULL,
   [vac_group_cvx] [int] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineGroups] PRIMARY KEY CLUSTERED ([vac_group_id])
)


GO
CREATE TABLE [dbo].[tblVaccineManufacturers] (
   [manufacturer_id] [int] NOT NULL
      IDENTITY (1,1),
   [manufacturer_name] [varchar](500) NOT NULL,
   [mvx_code] [varchar](10) NOT NULL,
   [notes] [varchar](max) NULL,
   [manufacturer_status] [bit] NOT NULL,
   [last_updated_date] [datetime] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineManufacturers] PRIMARY KEY CLUSTERED ([manufacturer_id])
)


GO
CREATE TABLE [dbo].[tblVaccines] (
   [vac_id] [int] NOT NULL
      IDENTITY (1,1),
   [vac_name] [nvarchar](150) NOT NULL,
   [vac_base_name] [nvarchar](150) NOT NULL,
   [manufacturer] [nvarchar](100) NOT NULL,
   [type] [nvarchar](50) NOT NULL,
   [comments] [nvarchar](250) NULL,
   [route] [nvarchar](50) NULL,
   [info_link] [nvarchar](200) NULL,
   [dc_id] [int] NOT NULL,
   [vac_exp_code] [varchar](10) NOT NULL,
   [vis_link] [varchar](200) NULL,
   [CVX_CODE] [varchar](10) NOT NULL,
   [mvx_code] [varchar](10) NOT NULL,
   [route_code] [varchar](3) NULL,
   [eligibility_category_code] [varchar](15) NULL,
   [Expiration_Date] [datetime] NULL,
   [is_active] [bit] NULL,
   [last_updated_date] [datetime] NULL,
   [cvx_id] [int] NULL,
   [manufacturer_id] [int] NULL,
   [is_CDC_Active] [bit] NULL

   ,CONSTRAINT [PK__tblVaccines__3B0D59BA] PRIMARY KEY CLUSTERED ([vac_id])
)

CREATE NONCLUSTERED INDEX [IX_tblVaccines] ON [dbo].[tblVaccines] ([dc_id])
CREATE UNIQUE NONCLUSTERED INDEX [UQ__tblVaccines__0000000000000014] ON [dbo].[tblVaccines] ([vac_id])

GO
CREATE TABLE [dbo].[tblVaccineTypes] (
   [record_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [cvx] [varchar](10) NOT NULL,
   [vac_type] [varchar](100) NOT NULL,
   [vac_type_cvx] [varchar](10) NOT NULL,
   [statement_published_on] [datetime] NULL,
   [statement_presented_on] [datetime] NULL,
   [vis_barcode] [varchar](24) NULL,
   [active] [bit] NULL

   ,CONSTRAINT [PK_tblVaccineTypes] PRIMARY KEY CLUSTERED ([record_id])
)


GO
CREATE TABLE [dbo].[tblVaccineVIS] (
   [vis_concept_id] [int] NOT NULL
      IDENTITY (1,1),
   [vis_concept_name] [varchar](100) NOT NULL,
   [vis_edition_date] [datetime] NOT NULL,
   [vis_encoded_text] [varchar](50) NOT NULL,
   [vis_concept_code] [varchar](50) NOT NULL,
   [vis_edition_status] [varchar](50) NOT NULL,
   [vis_last_updated_date] [datetime] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineVIS] PRIMARY KEY CLUSTERED ([vis_concept_id])
)


GO
CREATE TABLE [dbo].[tblVaccineVISToURL] (
   [vis_url_id] [int] NOT NULL
      IDENTITY (1,1),
   [vis_concept_id] [int] NOT NULL,
   [vis_pdf_url] [varchar](500) NOT NULL,
   [vis_html_url] [varchar](500) NOT NULL,
   [is_active] [bit] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineVISToURL] PRIMARY KEY CLUSTERED ([vis_url_id])
)


GO
CREATE TABLE [dbo].[TempAppointmentsCheckinTimeUTCToEST] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [event_id] [bigint] NOT NULL,
   [AppointmentId] [bigint] NOT NULL,
   [dtCheckInUTC] [datetime] NULL,
   [dtCheckInEST] [datetime] NULL,
   [V2CheckInTime] [datetime2] NULL,
   [dtCalledUTC] [datetime] NULL,
   [dtCalledEST] [datetime] NULL,
   [V2CallInTime] [datetime2] NULL,
   [dtCheckedOutUTC] [datetime] NULL,
   [dtCheckedOutEST] [datetime] NULL,
   [V2CheckOutTime] [datetime2] NULL,
   [IsProcessed] [bit] NULL

   ,CONSTRAINT [PK_TempAppointmentsCheckinTimeUTCToEST] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[tempencid] (
   [enc_id] [int] NOT NULL
)


GO
CREATE TABLE [dbo].[TempExternalPatientActiveMeds_26688] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NULL,
   [drug_id] [int] NULL,
   [patient_chart_no] [varchar](50) NULL,
   [dosage] [varchar](255) NULL,
   [rxnorm_code] [varchar](15) NULL,
   [drug_name] [varchar](200) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [numb_refills] [int] NULL,
   [comments] [varchar](255) NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [use_generic] [int] NULL,
   [dr_npi] [varchar](25) NULL,
   [add_date] [datetime] NULL

   ,CONSTRAINT [PK_TempExternalPatientActiveMeds_26688] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[TempExternalPatientActiveMeds_26745] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NULL,
   [drug_id] [int] NULL,
   [patient_chart_no] [varchar](50) NULL,
   [dosage] [varchar](255) NULL,
   [rxnorm_code] [varchar](15) NULL,
   [drug_name] [varchar](200) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [numb_refills] [int] NULL,
   [comments] [varchar](255) NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [use_generic] [int] NULL,
   [dr_npi] [varchar](25) NULL

   ,CONSTRAINT [PK_TempExternalPatientActiveMeds_26745] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[TempExternalPatientActiveMeds_26753] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NULL,
   [drug_id] [int] NULL,
   [patient_chart_no] [varchar](50) NULL,
   [dosage] [varchar](255) NULL,
   [rxnorm_code] [varchar](15) NULL,
   [drug_name] [varchar](200) NULL,
   [duration_amount] [varchar](15) NULL,
   [duration_unit] [varchar](80) NULL,
   [numb_refills] [int] NULL,
   [comments] [varchar](255) NULL,
   [prn] [bit] NULL,
   [prn_description] [varchar](50) NULL,
   [use_generic] [int] NULL,
   [dr_npi] [varchar](25) NULL

   ,CONSTRAINT [PK_TempExternalPatientActiveMeds_26753] PRIMARY KEY CLUSTERED ([id])
)


GO
CREATE TABLE [dbo].[temppresidupdate] (
   [pres_id] [int] NOT NULL
      IDENTITY (1,1)
)


GO
CREATE TABLE [dbo].[temp_enchanced_encounters] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL
)


GO
CREATE TABLE [dbo].[temp_encounter210] (
   [model_defn_id] [int] NOT NULL
      IDENTITY (1,1),
   [type] [varchar](225) NOT NULL,
   [definition] [xml] NULL
)


GO
CREATE TABLE [dbo].[temp_encounterupdate_docgroups] (
   [dg_id] [bigint] NOT NULL,
   [PerformedDate] [datetime] NULL,
   [EncounterId] [bigint] NOT NULL
)


GO
CREATE TABLE [dbo].[Temp_Update] (
   [enc_id] [int] NULL,
   [Update_time] [datetime] NULL
)


GO
CREATE TABLE [dbo].[TIME_ZONES] (
   [TIMEZONE_CD] [varchar](6) NOT NULL,
   [TIMEZONE_NAME] [varchar](60) NOT NULL,
   [OFFSET_HR] [int] NOT NULL,
   [OFFSET_MI] [int] NOT NULL,
   [DST_OFFSET_HR] [int] NOT NULL,
   [DST_OFFSET_MI] [int] NOT NULL,
   [DST_EFF_DT] [varchar](10) NOT NULL,
   [DST_END_DT] [varchar](10) NOT NULL,
   [EFF_DT] [datetime] NOT NULL,
   [END_DT] [datetime] NOT NULL

   ,CONSTRAINT [PK_TIME_ZONES] PRIMARY KEY CLUSTERED ([TIMEZONE_CD], [EFF_DT])
)


GO
CREATE TABLE [dbo].[TokenRepository] (
   [TOKEN_ID] [varchar](256) NOT NULL,
   [CREATION_DATE] [datetime] NOT NULL,
   [EXPIRY_DATE] [datetime] NOT NULL,
   [ACCESS_LEVEL] [int] NULL

   ,CONSTRAINT [PK__TokenRepository__1D072A30] PRIMARY KEY CLUSTERED ([TOKEN_ID])
)


GO
CREATE TABLE [dbo].[USED_DISK] (
   [UsID] [int] NOT NULL
      IDENTITY (1,1),
   [Dbname] [varchar](20) NULL,
   [SizeDb] [varchar](20) NULL,
   [UnlockDB] [varchar](20) NULL,
   [Data] [datetime] NULL

   ,CONSTRAINT [PK__USED_DIS__BD21E37F273C368E] PRIMARY KEY CLUSTERED ([UsID])
)


GO
CREATE TABLE [dbo].[void_reason_codes] (
   [Id] [int] NULL,
   [VoidReason] [varchar](2000) NULL,
   [Code] [varchar](50) NULL
)


GO
CREATE TABLE [dbo].[weavy_event_log] (
   [user_id] [int] NULL,
   [event_date] [varchar](255) NULL,
   [event_type] [varchar](255) NULL,
   [comments] [varchar](255) NULL
)


GO
CREATE TABLE [dbo].[webinars] (
   [event_id] [int] NOT NULL
      IDENTITY (1,1),
   [event_start] [smalldatetime] NOT NULL,
   [event_end] [smalldatetime] NOT NULL,
   [sales_person] [smallint] NOT NULL,
   [slots_left] [smallint] NOT NULL,
   [confcallno] [varchar](25) NOT NULL,
   [accesscode] [varchar](25) NOT NULL,
   [meetingid] [varchar](25) NOT NULL,
   [meetingURL] [varchar](2000) NOT NULL,
   [activeFlag] [bit] NOT NULL,
   [eventtype_id] [int] NOT NULL

   ,CONSTRAINT [PK_webinars] PRIMARY KEY CLUSTERED ([event_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[webinars] ([event_id], [event_start], [event_end])

GO
CREATE TABLE [dbo].[webinar_customers] (
   [customer_id] [int] NOT NULL
      IDENTITY (1,1),
   [webinar_event_id] [int] NOT NULL,
   [fname] [varchar](50) NOT NULL,
   [lname] [varchar](50) NOT NULL,
   [phone] [varchar](50) NOT NULL,
   [state] [varchar](25) NOT NULL,
   [email] [varchar](100) NOT NULL,
   [grpname] [varchar](50) NOT NULL,
   [has_viewed] [bit] NOT NULL,
   [address1] [varchar](50) NOT NULL,
   [address2] [varchar](50) NOT NULL,
   [city] [varchar](50) NOT NULL,
   [zip] [varchar](20) NOT NULL,
   [sales_rep_id] [int] NOT NULL,
   [eventtype_id] [int] NOT NULL

   ,CONSTRAINT [PK_webinar_customers] PRIMARY KEY CLUSTERED ([customer_id])
)

CREATE NONCLUSTERED INDEX [IX_webinar_customers] ON [dbo].[webinar_customers] ([webinar_event_id])

GO
CREATE TABLE [dbo].[webinar_event_type] (
   [EventTypeID] [int] NOT NULL
      IDENTITY (1,1),
   [EventType] [varchar](max) NULL

   ,CONSTRAINT [PK_webinar_event_type] PRIMARY KEY CLUSTERED ([EventTypeID])
)


GO
CREATE TABLE [dbo].[webinar_transmittals] (
   [transmit_id] [int] NOT NULL
      IDENTITY (1,1),
   [webinar_id] [int] NOT NULL,
   [start_time] [smalldatetime] NOT NULL,
   [type] [tinyint] NOT NULL,
   [is_processed] [bit] NOT NULL

   ,CONSTRAINT [PK_webinar_transmittals] PRIMARY KEY CLUSTERED ([transmit_id])
)

CREATE NONCLUSTERED INDEX [IX_webinar_transmittals] ON [dbo].[webinar_transmittals] ([is_processed], [webinar_id], [start_time])

GO
CREATE TABLE [dbo].[wt_gchart] (
   [Sex] [float] NULL,
   [Agemos] [float] NULL,
   [L] [float] NULL,
   [M] [float] NULL,
   [S] [float] NULL,
   [P3] [float] NULL,
   [P5] [float] NULL,
   [P10] [float] NULL,
   [P25] [float] NULL,
   [P50] [float] NULL,
   [P75] [float] NULL,
   [P90] [float] NULL,
   [P95] [float] NULL,
   [P97] [float] NULL,
   [wt_id] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_wt_gchart] PRIMARY KEY CLUSTERED ([wt_id])
)


GO
CREATE TABLE [dbo].[ZipCodes] (
   [zc_id] [int] NOT NULL
      IDENTITY (1,1),
   [zipcode] [varchar](10) NULL,
   [city] [varchar](80) NULL,
   [state] [varchar](80) NULL,
   [add_date] [smalldatetime] NULL

   ,CONSTRAINT [PK_ZipCodes] PRIMARY KEY NONCLUSTERED ([zc_id])
)

CREATE NONCLUSTERED INDEX [_zipcode1] ON [dbo].[ZipCodes] ([zipcode])
CREATE CLUSTERED INDEX [PK_ZipCode] ON [dbo].[ZipCodes] ([zipcode])

GO
