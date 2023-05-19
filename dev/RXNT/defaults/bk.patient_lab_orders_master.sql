ALTER TABLE [bk].[patient_lab_orders_master] ADD CONSTRAINT [DF__patient_l__creat__255EDB14] DEFAULT (getdate()) FOR [created_date]
GO
