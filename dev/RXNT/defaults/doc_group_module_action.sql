ALTER TABLE [dbo].[doc_group_module_action] ADD CONSTRAINT [DF_doc_group_module_action_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
