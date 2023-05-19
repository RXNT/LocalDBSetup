CREATE TABLE [dbo].[messaging_message_recipients] (
   [message_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_messaging_message_recipients] PRIMARY KEY CLUSTERED ([message_id], [dr_id])
)


GO
