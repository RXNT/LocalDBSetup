CREATE TABLE [dbo].[StorePayments] (
   [PaymentID] [int] NOT NULL
      IDENTITY (1,1),
   [OrderID] [int] NULL,
   [PaymentAmount] [money] NULL,
   [PaymentDate] [datetime] NULL,
   [CardNumber] [varchar](30) NULL,
   [CardExpMonth] [varchar](10) NULL,
   [CardExpYear] [varchar](10) NULL,
   [ApprovalCode] [varchar](50) NULL,
   [CardType] [varchar](50) NULL,
   [RemoteTransID] [varchar](50) NULL,
   [CVV2] [varchar](50) NULL,
   [NameOnCard_F] [varchar](100) NULL,
   [NameOnCard_L] [varchar](100) NULL,
   [AVSCode] [varchar](50) NULL,
   [BillingFirstName] [varchar](50) NULL,
   [BillingLastName] [varchar](50) NULL,
   [BillingAddress1] [varchar](255) NULL,
   [BillingAddress2] [varchar](255) NULL,
   [BillingCity] [varchar](100) NULL,
   [BillingStateOrProvince] [varchar](50) NULL,
   [BillingPostalCode] [varchar](50) NULL,
   [BillingCountryID] [int] NULL,
   [BillingPhoneNumber] [varchar](50) NULL,
   [PaymentType] [varchar](2) NOT NULL,
   [PONumber] [varchar](50) NOT NULL,
   [POPaid] [bit] NOT NULL

   ,CONSTRAINT [PK_Payments] PRIMARY KEY NONCLUSTERED ([PaymentID])
)


GO
