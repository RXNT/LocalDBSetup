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
