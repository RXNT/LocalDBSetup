CREATE TABLE [cqm2022].[SysLookupCMS68v11_NQF0419] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK__SysLookupCMS68v11_NQF0419__C6DE2C15177B656F] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
