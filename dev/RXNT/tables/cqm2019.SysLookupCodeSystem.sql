CREATE TABLE [cqm2019].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A81F1C8737] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
