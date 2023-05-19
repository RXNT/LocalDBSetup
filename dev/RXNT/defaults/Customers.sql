ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustSalesPersonID] DEFAULT ((0)) FOR [CustSalesPersonID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustFirstName] DEFAULT ('') FOR [CustFirstName]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustLastName] DEFAULT ('') FOR [CustLastName]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustEmail] DEFAULT ('') FOR [CustEmail]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustAddress1] DEFAULT ('') FOR [CustAddress1]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustAddress2] DEFAULT ('') FOR [CustAddress2]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustCity] DEFAULT ('') FOR [CustCity]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustState] DEFAULT ('') FOR [CustState]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustZip] DEFAULT ('') FOR [CustZip]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustOfficePhone] DEFAULT ('') FOR [CustOfficePhone]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustHomePhone] DEFAULT ('') FOR [CustHomePhone]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustFax] DEFAULT ('') FOR [CustFax]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustMobile] DEFAULT ('') FOR [CustMobile]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustComments] DEFAULT ('') FOR [CustComments]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_RigID] DEFAULT ((0)) FOR [CustRigID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustBoatName] DEFAULT ('') FOR [CustBoatName]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_PeachTreeID] DEFAULT ('') FOR [PeachTreeID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_bIs205DiscountCust] DEFAULT ((0)) FOR [bIs205DiscountCust]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_LastEdited] DEFAULT (getdate()) FOR [LastEdited]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustCountry] DEFAULT ('') FOR [CustCountry]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_lngCountryID] DEFAULT ((0)) FOR [lngCountryID]
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF_Customers_CustShippingCountryID] DEFAULT ((0)) FOR [CustShippingCountryID]
GO
