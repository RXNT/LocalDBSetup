ALTER TABLE [bk].[patients] ADD CONSTRAINT [DF__patients__create__666D8462] DEFAULT (getdate()) FOR [created_date]
GO
