ALTER TABLE [dbo].[tblHealthGuidelinesTemplates] ADD  DEFAULT ((1)) FOR [isactive]
GO
ALTER TABLE [dbo].[tblHealthGuidelinesTemplates] ADD  DEFAULT (getdate()) FOR [date_added]
GO
