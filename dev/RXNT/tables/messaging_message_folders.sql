CREATE TABLE [dbo].[messaging_message_folders] (
   [message_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [folder_id] [int] NOT NULL,
   [is_read] [bit] NOT NULL

   ,CONSTRAINT [PK_messaging_message_folders] PRIMARY KEY CLUSTERED ([message_id], [dr_id], [folder_id])
)


GO
