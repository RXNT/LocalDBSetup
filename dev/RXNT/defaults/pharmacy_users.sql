ALTER TABLE [dbo].[pharmacy_users] ADD CONSTRAINT [DF_pharmacy_users_pharm_user_agreement_acptd] DEFAULT ((0)) FOR [pharm_user_agreement_acptd]
GO
ALTER TABLE [dbo].[pharmacy_users] ADD CONSTRAINT [DF_pharmacy_users_pharm_user_hipaa_agreement_acptd] DEFAULT ((0)) FOR [pharm_user_hipaa_agreement_acptd]
GO
