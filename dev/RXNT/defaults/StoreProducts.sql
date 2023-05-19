ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_InActive] DEFAULT ((0)) FOR [InActive]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_ShowOnHomePage] DEFAULT ((0)) FOR [ShowOnHomePage]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_ForEmployeesOnly] DEFAULT ((0)) FOR [ForEmployeesOnly]
GO
ALTER TABLE [dbo].[StoreProducts] ADD CONSTRAINT [DF_StoreProducts_SortID] DEFAULT ((0)) FOR [SortID]
GO
ALTER TABLE [dbo].[StoreProducts] ADD  DEFAULT ('') FOR [PriceUnits]
GO
