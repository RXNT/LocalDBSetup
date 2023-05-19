CREATE TABLE [spe].[SPEMessages] (
   [spo_ir_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pres_id] [int] NULL,
   [pd_id] [int] NULL,
   [is_success] [bit] NULL,
   [queued_date] [datetime] NULL,
   [send_date] [datetime] NULL,
   [request_id] [varchar](50) NULL,
   [request] [varchar](max) NULL,
   [response_date] [datetime] NULL,
   [response_id] [varchar](50) NULL,
   [response_message] [varchar](max) NULL,
   [response_code] [varchar](10) NULL,
   [next_retry_on] [datetime] NULL,
   [retry_count] [int] NULL,
   [async_response] [varchar](max) NULL,
   [async_response_text] [varchar](2000) NULL,
   [async_response_date] [datetime] NULL,
   [message_type] [int] NULL

   ,CONSTRAINT [PK_SPOInitiationRequests] PRIMARY KEY CLUSTERED ([spo_ir_id])
)


GO
