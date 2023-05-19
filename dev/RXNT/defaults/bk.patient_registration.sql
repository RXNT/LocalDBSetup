ALTER TABLE [bk].[patient_registration] ADD CONSTRAINT [DF__patient_r__creat__6C265DB8] DEFAULT (getdate()) FOR [created_date]
GO
