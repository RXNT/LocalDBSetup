ALTER TABLE [dbo].[doc_admin] ADD  DEFAULT (7 / 1 / 2004) FOR [report_date]
GO
ALTER TABLE [dbo].[doc_admin] ADD  DEFAULT (getdate()) FOR [update_date]
GO
ALTER TABLE [dbo].[doc_admin] ADD CONSTRAINT [DF__doc_admin__versi__3F88C16B] DEFAULT ('10.6') FOR [version]
GO
