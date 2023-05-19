CREATE TABLE [dbo].[StoreProducts] (
   [ProductID] [int] NOT NULL
      IDENTITY (1,1),
   [ProductCode] [varchar](50) NULL,
   [ProductIntroductionDate] [smalldatetime] NULL,
   [ProductName] [varchar](50) NULL,
   [ProductDescription] [varchar](400) NULL,
   [ProductSmallImage] [varchar](255) NULL,
   [ProductLargeImage] [varchar](255) NULL,
   [UnitPrice] [money] NULL,
   [Discount] [float] NULL,
   [ShipCost] [money] NULL,
   [StockStatus] [varchar](100) NULL,
   [KeyWords] [varchar](255) NULL,
   [InActive] [bit] NOT NULL,
   [SmallImageWidth] [varchar](10) NULL,
   [SmallImageHeight] [varchar](10) NULL,
   [LargeImageWidth] [varchar](10) NULL,
   [LargeImageHeight] [varchar](10) NULL,
   [ProductLongDescription] [varchar](2000) NULL,
   [ProductWeight] [float] NULL,
   [UserField1Label] [varchar](50) NULL,
   [UserField1Options] [varchar](1000) NULL,
   [UserField2Label] [varchar](50) NULL,
   [UserField2Options] [varchar](1000) NULL,
   [ShowOnHomePage] [bit] NOT NULL,
   [QEmployeeCost] [money] NULL,
   [SalePrice] AS ([UnitPrice]-[UnitPrice]*([Discount]/(100))),
   [ForEmployeesOnly] [bit] NULL,
   [SortID] [int] NOT NULL,
   [UserField3Label] [varchar](50) NULL,
   [UserField3Options] [varchar](1000) NULL,
   [UserField4Label] [varchar](50) NULL,
   [UserField4Options] [varchar](1000) NULL,
   [PriceUnits] [varchar](100) NULL

   ,CONSTRAINT [PK_StoreProducts] PRIMARY KEY CLUSTERED ([ProductID])
)


GO
