ALTER TABLE [epa].[epa_transaction_log] WITH CHECK ADD CONSTRAINT [FK_epa_transaction_log_doc_companies]
   FOREIGN KEY([dc_id]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [epa].[epa_transaction_log] WITH CHECK ADD CONSTRAINT [FK_epa_transaction_log_patient_id]
   FOREIGN KEY([pa_id]) REFERENCES [dbo].[patients] ([pa_id])

GO
