ALTER TABLE [bk].[patient_lab_orders] ADD CONSTRAINT [DF__patient_l__creat__34A11EA4] DEFAULT (getdate()) FOR [created_date]
GO
