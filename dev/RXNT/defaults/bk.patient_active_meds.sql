ALTER TABLE [bk].[patient_active_meds] ADD CONSTRAINT [DF__patient_a__creat__14344F12] DEFAULT (getdate()) FOR [created_date]
GO
