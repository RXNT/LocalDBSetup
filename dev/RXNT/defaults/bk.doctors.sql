ALTER TABLE [bk].[doctors] ADD CONSTRAINT [DF__doctors__created__2B17B46A] DEFAULT (getdate()) FOR [created_date]
GO
