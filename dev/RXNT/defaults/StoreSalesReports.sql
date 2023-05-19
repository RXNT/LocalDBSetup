ALTER TABLE [dbo].[StoreSalesReports] ADD CONSTRAINT [DF_StoreSalesReports_SSRDate] DEFAULT (getdate()) FOR [SSRDate]
GO
ALTER TABLE [dbo].[StoreSalesReports] ADD CONSTRAINT [DF_StoreSalesReports_SSRPaid] DEFAULT ((0)) FOR [SSRPaid]
GO
