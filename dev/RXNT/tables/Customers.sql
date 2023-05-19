CREATE TABLE [dbo].[Customers] (
   [CustID] [int] NOT NULL
      IDENTITY (1,1),
   [CustSalesPersonID] [int] NULL,
   [CustFirstName] [varchar](100) NULL,
   [CustLastName] [varchar](100) NULL,
   [CustEmail] [varchar](100) NULL,
   [CustAddress1] [varchar](100) NULL,
   [CustAddress2] [varchar](100) NULL,
   [CustCity] [varchar](100) NULL,
   [CustState] [varchar](50) NULL,
   [CustZip] [varchar](40) NULL,
   [CustOfficePhone] [varchar](40) NULL,
   [CustHomePhone] [varchar](40) NULL,
   [CustFax] [varchar](40) NULL,
   [CustMobile] [varchar](40) NULL,
   [CustComments] [varchar](255) NULL,
   [CustRigID] [int] NULL,
   [CustBoatName] [varchar](50) NULL,
   [PeachTreeID] [varchar](50) NULL,
   [bIs205DiscountCust] [bit] NULL,
   [LastEdited] [datetime] NULL,
   [CustCountry] [varchar](100) NULL,
   [lngCountryID] [int] NOT NULL,
   [CustPassword] [varchar](20) NULL,
   [CustShippingAddress1] [varchar](255) NULL,
   [CustShippingAddress2] [varchar](255) NULL,
   [CustShippingCity] [varchar](100) NULL,
   [CustShippingStateOrProvince] [varchar](50) NULL,
   [CustShippingPostalCode] [varchar](50) NULL,
   [CustShippingCountryID] [int] NOT NULL,
   [CustShippingPhoneNumber] [varchar](50) NULL,
   [CustBillingFirstName] [varchar](100) NULL,
   [CustBillingLastName] [varchar](100) NULL

   ,CONSTRAINT [IX_Customers] UNIQUE NONCLUSTERED ([CustFirstName], [CustLastName], [CustEmail])
   ,CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED ([CustID])
)


GO
