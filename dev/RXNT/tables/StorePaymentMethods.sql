CREATE TABLE [dbo].[StorePaymentMethods] (
   [PaymentMethodID] [int] NOT NULL
      IDENTITY (1,1),
   [PaymentMethod] [varchar](50) NOT NULL,
   [MethodCode] [varchar](30) NOT NULL,
   [Enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_PaymentMethods] PRIMARY KEY NONCLUSTERED ([PaymentMethodID])
)


GO
