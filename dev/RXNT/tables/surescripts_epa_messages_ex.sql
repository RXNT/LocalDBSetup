CREATE TABLE [dbo].[surescripts_epa_messages_ex] (
   [sem_ex_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [sem_id] [bigint] NOT NULL,
   [request] [xml] NULL,
   [response] [xml] NULL,
   [immediate_response] [varchar](max) NULL

   ,CONSTRAINT [PK_surescripts_epa_messages_ex] PRIMARY KEY CLUSTERED ([sem_ex_id])
)


GO
