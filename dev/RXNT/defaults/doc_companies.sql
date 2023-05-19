ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT (0) FOR [partner_id]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF__doc_compa__SHOW___1551C526] DEFAULT ((0)) FOR [SHOW_EMAIL]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF_doc_companies_dc_host_id] DEFAULT ((1)) FOR [dc_host_id]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT ((1)) FOR [admin_company_id]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF__doc_compa__emr_m__4DEB2404] DEFAULT ((255)) FOR [emr_modules]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT ((0)) FOR [dc_settings]
GO
ALTER TABLE [dbo].[doc_companies] ADD CONSTRAINT [DF__doc_compa__Enabl__21CC1117] DEFAULT ((0)) FOR [EnableV2EncounterTemplate]
GO
ALTER TABLE [dbo].[doc_companies] ADD  DEFAULT ((0)) FOR [IsBannerAdsDisabled]
GO
