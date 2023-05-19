ALTER TABLE [dbo].[passwords_change_log] ADD CONSTRAINT [DF_passwords_change_log_user_type] DEFAULT (1) FOR [user_type]
GO
