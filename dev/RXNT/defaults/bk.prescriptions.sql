ALTER TABLE [bk].[prescriptions] ADD CONSTRAINT [DF__prescript__creat__2EE8454E] DEFAULT (getdate()) FOR [created_date]
GO
