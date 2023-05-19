ALTER TABLE [dbo].[admin_companies] ADD CONSTRAINT [DF_admin_companies_admin_company_rights] DEFAULT ((0)) FOR [admin_company_rights]
GO
ALTER TABLE [dbo].[admin_companies] ADD CONSTRAINT [DF_admin_companies_enabled] DEFAULT ((1)) FOR [enabled]
GO
