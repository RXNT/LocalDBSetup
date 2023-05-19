ALTER TABLE [bk].[patient_measure_compliance] ADD CONSTRAINT [DF__patient_m__creat__218E4A30] DEFAULT (getdate()) FOR [created_date]
GO
