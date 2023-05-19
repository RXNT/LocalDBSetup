CREATE TABLE [dbo].[StoreOrderDetails] (
   [OrderDetailID] [int] NOT NULL
      IDENTITY (1,1),
   [OrderID] [int] NULL,
   [ProductID] [int] NULL,
   [ProductCode] [varchar](50) NULL,
   [ProductName] [varchar](200) NULL,
   [Quantity] [int] NULL,
   [UnitPrice] [money] NULL,
   [ProductWeight] [float] NULL,
   [ConfigDetails] [varchar](400) NULL

   ,CONSTRAINT [PK_OrderDetails] PRIMARY KEY NONCLUSTERED ([OrderDetailID])
)


GO
