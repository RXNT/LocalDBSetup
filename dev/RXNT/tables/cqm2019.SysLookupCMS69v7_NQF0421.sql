CREATE TABLE [cqm2019].[SysLookupCMS69v7_NQF0421] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C151B4BF653] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
