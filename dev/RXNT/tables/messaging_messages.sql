CREATE TABLE [dbo].[messaging_messages] (
   [message_id] [int] NOT NULL
      IDENTITY (1,1),
   [sender_dr_id] [int] NOT NULL,
   [mm_subject] [varchar](255) NOT NULL,
   [mm_create_date] [datetime] NOT NULL,
   [mm_body_text] [text] NOT NULL

   ,CONSTRAINT [PK_messaging_messages] PRIMARY KEY CLUSTERED ([message_id])
)


GO
