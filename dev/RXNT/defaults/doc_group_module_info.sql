ALTER TABLE [dbo].[doc_group_module_info] ADD CONSTRAINT [DF_doc_group_module_info_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
