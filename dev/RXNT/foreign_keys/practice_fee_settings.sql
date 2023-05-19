ALTER TABLE [dbo].[practice_fee_settings] WITH CHECK ADD CONSTRAINT [FK_practice_fee_settings_doc_groups]
   FOREIGN KEY([dg_id]) REFERENCES [dbo].[doc_groups] ([dg_id])

GO
