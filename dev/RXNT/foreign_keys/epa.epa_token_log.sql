ALTER TABLE [epa].[epa_token_log] WITH CHECK ADD CONSTRAINT [FK_epa_token_log_doc_companies]
   FOREIGN KEY([dc_id]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
