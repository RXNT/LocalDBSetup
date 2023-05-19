CREATE TABLE [dbo].[surescript_admin_message] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [messageid] [varchar](30) NULL,
   [response_type] [bit] NULL,
   [response_text] [varchar](2000) NULL,
   [send_date] [smalldatetime] NULL,
   [response_date] [smalldatetime] NULL,
   [message_type] [tinyint] NOT NULL,
   [dr_id] [int] NULL

   ,CONSTRAINT [PK_surescript_admin_message] PRIMARY KEY CLUSTERED ([id])
)


GO
