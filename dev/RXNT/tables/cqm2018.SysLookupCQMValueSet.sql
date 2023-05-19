CREATE TABLE [cqm2018].[SysLookupCQMValueSet] (
   [ValueSetId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetName] [varchar](200) NULL,
   [ValueSetOID] [varchar](200) NULL,
   [QDMCategoryId] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__222987C15B8940C1] PRIMARY KEY CLUSTERED ([ValueSetId])
)


GO
