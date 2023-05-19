ALTER TABLE [dbo].[StorePayments] ADD CONSTRAINT [DF_Payments_PaymentDate] DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[StorePayments] ADD CONSTRAINT [DF_StorePayments_PONumber] DEFAULT ('') FOR [PONumber]
GO
ALTER TABLE [dbo].[StorePayments] ADD CONSTRAINT [DF_StorePayments_POPaid] DEFAULT ((0)) FOR [POPaid]
GO
