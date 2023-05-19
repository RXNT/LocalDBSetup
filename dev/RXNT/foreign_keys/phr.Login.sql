ALTER TABLE [phr].[Login] WITH CHECK ADD CONSTRAINT [FK_Login_UserAgreement]
   FOREIGN KEY([UserAgreementId]) REFERENCES [phr].[UserAgreement] ([Id])

GO
