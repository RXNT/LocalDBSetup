ALTER TABLE [dbo].[doc_group_fav_scripts_sig_details] WITH CHECK ADD CONSTRAINT [FK_doc_group_fav_scripts_sig_details_doc_group_fav_scripts]
   FOREIGN KEY([script_id]) REFERENCES [dbo].[doc_group_fav_scripts] ([script_id])

GO
