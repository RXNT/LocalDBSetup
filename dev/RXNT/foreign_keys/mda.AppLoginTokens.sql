ALTER TABLE [mda].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_mda_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [mda].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_mda_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
