ALTER TABLE [dbo].[direct_email_addresses] ADD CONSTRAINT [DF_direct_email_addresses_DirectPassword] DEFAULT ('Yhsfw@34adws') FOR [DirectPassword]
GO
ALTER TABLE [dbo].[direct_email_addresses] ADD CONSTRAINT [DF_direct_email_addresses_AgreementAccepted] DEFAULT ((0)) FOR [AgreementAccepted]
GO
ALTER TABLE [dbo].[direct_email_addresses] ADD CONSTRAINT [DF_direct_email_addresses_DirectDomainID] DEFAULT ((0)) FOR [DirectDomainID]
GO
