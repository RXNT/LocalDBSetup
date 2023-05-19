CREATE TABLE [dbo].[StoreCategories] (
   [C_ID] [int] NOT NULL
      IDENTITY (1,1),
   [C_Name] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_Categories] PRIMARY KEY NONCLUSTERED ([C_ID])
)


GO
