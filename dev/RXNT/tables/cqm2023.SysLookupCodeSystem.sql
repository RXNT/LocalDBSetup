CREATE TABLE [cqm2023].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL,
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLooku__BE9EB9A81F1C8737] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
