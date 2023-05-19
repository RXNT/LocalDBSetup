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
