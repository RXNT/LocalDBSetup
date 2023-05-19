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
