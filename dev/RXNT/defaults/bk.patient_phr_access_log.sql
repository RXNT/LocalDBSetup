ALTER TABLE [bk].[patient_phr_access_log] ADD CONSTRAINT [DF__patient_p__creat__73C77F80] DEFAULT (getdate()) FOR [created_date]
GO
