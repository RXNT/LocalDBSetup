CREATE TABLE [dbo].[surescripts_epa_messages] (
   [sem_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NULL,
   [prim_dr_id] [bigint] NULL,
   [pa_id] [bigint] NULL,
   [request_id] [varchar](100) NULL,
   [pa_reference_id] [varchar](100) NULL,
   [immediate_response_id] [varchar](100) NULL,
   [response_id] [varchar](100) NULL,
   [response_code] [varchar](50) NULL,
   [created_date] [datetime] NULL,
   [response_date] [datetime] NULL,
   [request_type] [varchar](50) NULL,
   [response_type] [varchar](50) NULL,
   [version] [varchar](10) NULL,
   [relatesto_message_id] [varchar](100) NULL

   ,CONSTRAINT [PK_surescript_epa_messages] PRIMARY KEY CLUSTERED ([sem_id])
)


GO
