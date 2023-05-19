ALTER TABLE [dbo].[doc_fav_scripts] WITH CHECK ADD CONSTRAINT [FK_doc_fav_scripts_hospice_drug_relatedness]
   FOREIGN KEY([hospice_drug_relatedness_id]) REFERENCES [dbo].[hospice_drug_relatedness] ([hospice_drug_relatedness_id])

GO
