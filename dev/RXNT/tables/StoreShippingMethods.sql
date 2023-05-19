CREATE TABLE [dbo].[StoreShippingMethods] (
   [ShippingMethodID] [int] NOT NULL
      IDENTITY (1,1),
   [ShippingMethod] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_ShippingMethods] PRIMARY KEY NONCLUSTERED ([ShippingMethodID])
)


GO
