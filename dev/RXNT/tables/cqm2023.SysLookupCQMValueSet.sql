CREATE TABLE [cqm2023].[SysLookupCQMValueSet] (
   [ValueSetId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetName] [varchar](200) NULL,
   [ValueSetOID] [varchar](200) NULL,
   [QDMCategoryId] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLooku__222987C128A5F171] PRIMARY KEY CLUSTERED ([ValueSetId])
)


GO
