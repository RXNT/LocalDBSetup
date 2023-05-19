CREATE TABLE [cqm2018].[SysLookupCMS117v6_NQF0038] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C150397321B] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
