ALTER TABLE [dbo].[doc_fav_scripts_sig_details] WITH CHECK ADD CONSTRAINT [FK_doc_fav_scripts_sig_details_doc_fav_scripts]
   FOREIGN KEY([script_id]) REFERENCES [dbo].[doc_fav_scripts] ([script_id])

GO
ALTER TABLE [dbo].[doc_fav_scripts_sig_details] WITH CHECK ADD CONSTRAINT [FK_doc_fav_scripts_sig_details_doc_fav_scripts_sig_details]
   FOREIGN KEY([script_sig_id]) REFERENCES [dbo].[doc_fav_scripts_sig_details] ([script_sig_id])

GO
