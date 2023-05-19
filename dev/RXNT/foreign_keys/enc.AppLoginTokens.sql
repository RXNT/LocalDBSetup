ALTER TABLE [enc].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_enc_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [enc].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_enc_AppLoginTokens_DoctorCompany]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
