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
