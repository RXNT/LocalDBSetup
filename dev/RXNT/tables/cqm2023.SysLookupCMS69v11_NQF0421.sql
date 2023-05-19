CREATE TABLE [cqm2023].[SysLookupCMS69v11_NQF0421] (
   [CodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ValueSetId] [int] NOT NULL,
   [Code] [varchar](max) NOT NULL,
   [Description] [varchar](max) NULL,
   [QDMCategoryId] [int] NULL,
   [CodeSystemId] [int] NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLookupCMS69v11_NQF0421] PRIMARY KEY CLUSTERED ([CodeId])
)


GO
