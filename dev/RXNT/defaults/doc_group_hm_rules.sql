ALTER TABLE [dbo].[doc_group_hm_rules] ADD CONSTRAINT [DF_doc_group_hm_rules_date_added] DEFAULT (getdate()) FOR [date_added]
GO
