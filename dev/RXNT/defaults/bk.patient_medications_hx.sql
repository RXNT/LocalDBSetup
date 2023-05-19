ALTER TABLE [bk].[patient_medications_hx] ADD CONSTRAINT [DF__patient_m__creat__30D08DC0] DEFAULT (getdate()) FOR [created_date]
GO
