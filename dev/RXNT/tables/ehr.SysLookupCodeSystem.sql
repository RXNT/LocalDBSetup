CREATE TABLE [ehr].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystem] [varchar](200) NOT NULL,
   [Active] [bit] NOT NULL,
   [ApplicationTableCode] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A85158C6A3] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
