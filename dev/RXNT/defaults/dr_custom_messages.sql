ALTER TABLE [dbo].[dr_custom_messages] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[dr_custom_messages] ADD CONSTRAINT [dr_custom_messages_message_typeid_default] DEFAULT ((1)) FOR [message_typeid]
GO
