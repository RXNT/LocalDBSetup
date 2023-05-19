CREATE TABLE [dbo].[StoreOrders] (
   [OrderID] [int] NOT NULL
      IDENTITY (1,1),
   [CustomerID] [int] NULL,
   [OrderDate] [datetime] NULL,
   [ShippingFirstName] [varchar](50) NULL,
   [ShippingLastName] [varchar](50) NULL,
   [ShippingAddress1] [varchar](255) NULL,
   [ShippingAddress2] [varchar](255) NULL,
   [ShippingCity] [varchar](50) NULL,
   [ShippingStateOrProvince] [varchar](100) NULL,
   [ShippingPostalCode] [varchar](20) NULL,
   [ShippingCountryID] [int] NULL,
   [ShippingPhoneNumber] [varchar](30) NULL,
   [ShipDate] [datetime] NULL,
   [ShippingMethodCode] [varchar](10) NULL,
   [ShippingCharge] [money] NULL,
   [SalesTaxRate] [float] NOT NULL,
   [Processed] [bit] NOT NULL,
   [UPSTrackingNumber] [varchar](50) NOT NULL,
   [CCFailed] [bit] NOT NULL,
   [CCFailReason] [varchar](6000) NOT NULL,
   [QEmpID] [int] NOT NULL,
   [Void] [bit] NOT NULL,
   [RoyaltyBilled] [bit] NOT NULL,
   [RoyaltyPaid] [bit] NOT NULL

   ,CONSTRAINT [PK_Orders] PRIMARY KEY NONCLUSTERED ([OrderID])
)


GO
