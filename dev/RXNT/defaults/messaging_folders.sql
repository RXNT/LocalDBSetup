ALTER TABLE [dbo].[messaging_folders] ADD CONSTRAINT [DF_messaging_folders_parent_folder_id] DEFAULT ((0)) FOR [parent_folder_id]
GO
