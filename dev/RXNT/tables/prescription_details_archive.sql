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
