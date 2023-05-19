CREATE TABLE [dbo].[StoreSalesReportsOrders] (
   [SSRID] [int] NOT NULL,
   [OrderID] [int] NOT NULL

   ,CONSTRAINT [PK_StoreSalesReportsOrders] PRIMARY KEY CLUSTERED ([SSRID], [OrderID])
)


GO
