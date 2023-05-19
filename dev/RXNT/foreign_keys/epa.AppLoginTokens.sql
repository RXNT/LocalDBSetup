ALTER TABLE [epa].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_epa_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [epa].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_epa_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
