ALTER TABLE [bk].[patient_visit] ADD CONSTRAINT [DF__patient_v__creat__3E2A88DE] DEFAULT (getdate()) FOR [created_date]
GO
