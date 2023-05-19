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
