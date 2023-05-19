ALTER TABLE [dbo].[doc_group_module_info] WITH CHECK ADD CONSTRAINT [FK_doc_group_module_info_doc_group_module_info]
   FOREIGN KEY([dg_module_info_id]) REFERENCES [dbo].[doc_group_module_info] ([dg_module_info_id])

GO
