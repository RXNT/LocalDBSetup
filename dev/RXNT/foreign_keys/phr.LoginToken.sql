ALTER TABLE [phr].[LoginToken] WITH CHECK ADD CONSTRAINT [FK_LoginToken_Login]
   FOREIGN KEY([LoginId]) REFERENCES [phr].[Login] ([Id])

GO
