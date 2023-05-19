CREATE TABLE [dbo].[ScalabullLog] (
   [ScalabullLogId] [bigint] NOT NULL
      IDENTITY (1,1),
   [lab_master_id] [bigint] NOT NULL,
   [message_type] [varchar](50) NOT NULL,
   [status] [bit] NOT NULL,
   [statusresponse] [varchar](max) NULL,
   [receive_date] [datetime] NOT NULL,
   [request_message] [varchar](max) NULL,
   [response_message] [varchar](max) NULL,
   [http_response_code] [varchar](50) NULL

   ,CONSTRAINT [PK_ScalabullLog] PRIMARY KEY CLUSTERED ([ScalabullLogId])
)


GO
