ALTER TABLE [adm].[AppLoginTokens] WITH CHECK ADD CONSTRAINT [FK_AppLoginTokens_AppLogins]
   FOREIGN KEY([AppLoginId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
