ALTER TABLE [dbo].[messaging_messages] ADD CONSTRAINT [DF_messaging_messages_mm_create_date] DEFAULT (getdate()) FOR [mm_create_date]
GO
