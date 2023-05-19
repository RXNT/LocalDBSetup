CREATE TABLE [dbo].[erx_senders] (
   [sender_id] [int] NOT NULL,
   [sender_name] [varchar](80) NOT NULL,
   [sender_website] [varchar](255) NULL,
   [sender_url] [varchar](255) NOT NULL,
   [plan_code] [varchar](20) NOT NULL,
   [generate_tracking_numb] [bit] NOT NULL,
   [account_number] [varchar](6) NULL

   ,CONSTRAINT [PK_erx_senders] PRIMARY KEY CLUSTERED ([sender_id])
)


GO
