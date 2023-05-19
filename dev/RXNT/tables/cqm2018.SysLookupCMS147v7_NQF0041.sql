CREATE TABLE [cqm2018].[SysLookupCMS147v7_NQF0041] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C1578257F6F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
