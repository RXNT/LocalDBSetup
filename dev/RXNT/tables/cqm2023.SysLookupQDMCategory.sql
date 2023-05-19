CREATE TABLE [cqm2023].[SysLookupQDMCategory] (
   [QDMCategoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [QDMCategory] [varchar](200) NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_cqm2023_SysLooku__3C2D04FC2C768255] PRIMARY KEY CLUSTERED ([QDMCategoryId])
)


GO
