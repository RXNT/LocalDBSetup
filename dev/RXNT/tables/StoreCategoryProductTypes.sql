CREATE TABLE [dbo].[StoreCategoryProductTypes] (
   [CPT_ID] [int] NOT NULL
      IDENTITY (1,1),
   [C_ID] [int] NULL,
   [CPT_Name] [varchar](255) NULL,
   [CPT_Description] [varchar](4000) NULL,
   [CPT_ThumbImage] [varchar](400) NULL,
   [CPT_ThumbImageW] [varchar](10) NULL,
   [CPT_ThumbImageH] [varchar](10) NULL,
   [CPT_InActive] [bit] NULL,
   [SortID] [int] NOT NULL

   ,CONSTRAINT [PK_CategoryProductTypes] PRIMARY KEY NONCLUSTERED ([CPT_ID])
)


GO
