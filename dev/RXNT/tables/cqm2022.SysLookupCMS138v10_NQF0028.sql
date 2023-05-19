CREATE TABLE [cqm2022].[SysLookupCMS138v10_NQF0028] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLooku__C6DE2C153F8956C9] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
