CREATE TABLE [cqm2018].[SysLookupCodeSystem] (
   [CodeSystemId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CodeSystem] [varchar](200) NULL,
   [CodeSystemOID] [varchar](200) NULL,
   [CodeSystemVersion] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__BE9EB9A86512AAFB] PRIMARY KEY CLUSTERED ([CodeSystemId])
)


GO
