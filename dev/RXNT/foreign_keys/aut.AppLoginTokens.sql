ALTER TABLE [aut].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_aut_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [aut].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_aut_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
