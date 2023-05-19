ALTER TABLE [bk].[patient_medical_hx] ADD CONSTRAINT [DF__patient_m__creat__1FA601BE] DEFAULT (getdate()) FOR [created_date]
GO
