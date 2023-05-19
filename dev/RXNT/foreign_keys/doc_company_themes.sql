ALTER TABLE [dbo].[doc_company_themes] WITH CHECK ADD CONSTRAINT [FK_doc_company_themes_doc_company_themes_xref]
   FOREIGN KEY([theme_id]) REFERENCES [dbo].[doc_company_themes_xref] ([theme_id])

GO
