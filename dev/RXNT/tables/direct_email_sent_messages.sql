CREATE TABLE [dbo].[direct_email_sent_messages] (
   [direct_message_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [from_address] [varchar](255) NOT NULL,
   [to_address] [varchar](255) NOT NULL,
   [subject] [varchar](100) NOT NULL,
   [message_id] [varchar](255) NOT NULL,
   [attachment_type] [varchar](50) NOT NULL,
   [send_success] [bit] NOT NULL,
   [error_message] [varchar](2000) NOT NULL,
   [sent_date] [datetime] NULL,
   [ref_id] [bigint] NULL

   ,CONSTRAINT [PK_direct_email_sent_messages] PRIMARY KEY CLUSTERED ([direct_message_id])
)


GO
