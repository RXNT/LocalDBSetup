ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ('') FOR [password1]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ('') FOR [password2]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ('') FOR [password3]
GO
ALTER TABLE [dbo].[doc_password_history] ADD  DEFAULT ((1)) FOR [nowactive]
GO
