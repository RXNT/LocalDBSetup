ALTER TABLE [bk].[patient_active_diagnosis] ADD CONSTRAINT [DF__patient_a__creat__1804DFF6] DEFAULT (getdate()) FOR [created_date]
GO
