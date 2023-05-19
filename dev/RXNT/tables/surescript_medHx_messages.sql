CREATE TABLE [dbo].[surescript_medHx_messages] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [drid] [bigint] NULL,
   [patientid] [bigint] NULL,
   [requestid] [varchar](100) NULL,
   [responseid] [varchar](100) NULL,
   [startdate] [date] NULL,
   [enddate] [date] NULL,
   [request] [xml] NULL,
   [response] [xml] NULL,
   [createddate] [datetime] NULL,
   [request_type] [tinyint] NULL,
   [version] [varchar](10) NULL,
   [immediate_response_id] [varchar](100) NULL,
   [immediate_response] [varchar](max) NULL,
   [response_date] [datetime] NULL,
   [prim_dr_id] [bigint] NULL,
   [effective_end_date] [date] NULL,
   [relatesto_message_id] [varchar](100) NULL

   ,CONSTRAINT [PK_surescript_medHx_messages] PRIMARY KEY CLUSTERED ([id])
)

CREATE NONCLUSTERED INDEX [idx_surescript_medHx_messages_k4] ON [dbo].[surescript_medHx_messages] ([requestid])

GO
