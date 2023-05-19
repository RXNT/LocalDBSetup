ALTER TABLE [dbo].[sales_person_info] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO
ALTER TABLE [dbo].[sales_person_info] ADD  DEFAULT ((1)) FOR [admin_company_id]
GO
ALTER TABLE [dbo].[sales_person_info] ADD  DEFAULT ('') FOR [email]
GO
