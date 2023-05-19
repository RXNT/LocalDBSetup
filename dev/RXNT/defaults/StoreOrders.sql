ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_Orders_UPSTrackingNumber] DEFAULT ('') FOR [UPSTrackingNumber]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_Orders_CCFailed] DEFAULT ((0)) FOR [CCFailed]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_Orders_CCFailReason] DEFAULT ('') FOR [CCFailReason]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_QEmpID] DEFAULT ((0)) FOR [QEmpID]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_Void] DEFAULT ((0)) FOR [Void]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_CommissionBilled] DEFAULT ((0)) FOR [RoyaltyBilled]
GO
ALTER TABLE [dbo].[StoreOrders] ADD CONSTRAINT [DF_StoreOrders_RoyaltyPaid] DEFAULT ((0)) FOR [RoyaltyPaid]
GO
