ALTER TABLE [bk].[patient_procedures] ADD CONSTRAINT [DF__patient_p__creat__71DF370E] DEFAULT (getdate()) FOR [created_date]
GO
