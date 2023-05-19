ALTER TABLE [dbo].[StorePaymentMethods] ADD CONSTRAINT [DF_PaymentMethods_Enabled] DEFAULT ((1)) FOR [Enabled]
GO
