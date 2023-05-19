ALTER TABLE [dbo].[doc_group_freetext_meds] WITH CHECK ADD CONSTRAINT [IgnoreFDBDrugId] CHECK  ([drug_id]>(999999))
GO
