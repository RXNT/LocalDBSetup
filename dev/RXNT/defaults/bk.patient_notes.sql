ALTER TABLE [bk].[patient_notes] ADD CONSTRAINT [DF__patient_n__creat__32B8D632] DEFAULT (getdate()) FOR [created_date]
GO
