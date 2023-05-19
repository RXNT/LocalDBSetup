ALTER TABLE [dbo].[doc_group_page_info] ADD CONSTRAINT [DF_doc_group_page_info_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn]
GO
