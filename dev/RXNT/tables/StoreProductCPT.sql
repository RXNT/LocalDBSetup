CREATE TABLE [dbo].[StoreProductCPT] (
   [Product_CPT_ID] [int] NOT NULL
      IDENTITY (1,1),
   [ProductID] [int] NOT NULL,
   [CPT_ID] [int] NOT NULL,
   [SortID] [int] NOT NULL

   ,CONSTRAINT [PK_Product_CPT] PRIMARY KEY NONCLUSTERED ([Product_CPT_ID])
)


GO
