ALTER TABLE [dbo].[doc_group_actions] ADD CONSTRAINT [DF_doc_group_actions_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
