ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_username] DEFAULT ('') FOR [admin_username]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_password] DEFAULT ('') FOR [admin_password]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_first_name] DEFAULT ('') FOR [admin_first_name]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_middle_initial] DEFAULT ('') FOR [admin_middle_initial]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_last_name] DEFAULT ('') FOR [admin_last_name]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF__admin_use__enabl__69092E94] DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_users_admin_user_rights] DEFAULT ((-1)) FOR [admin_user_rights]
GO
ALTER TABLE [dbo].[admin_users] ADD CONSTRAINT [DF_admin_users_admin_user_create_date] DEFAULT (getdate()) FOR [admin_user_create_date]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ((0)) FOR [sales_person_id]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ('') FOR [tracker_uid]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ('') FOR [tracker_pwd]
GO
ALTER TABLE [dbo].[admin_users] ADD  DEFAULT ((0)) FOR [is_token]
GO
