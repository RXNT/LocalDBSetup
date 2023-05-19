ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_notify_fax] DEFAULT (0) FOR [pharm_notify_fax]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_notify_email] DEFAULT (0) FOR [pharm_notify_email]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_participant] DEFAULT (1) FOR [pharm_participant]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_ncpdp_numb] DEFAULT (0) FOR [ncpdp_numb]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_disp_type] DEFAULT (1) FOR [disp_type]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_enable_dummy_code] DEFAULT (0) FOR [enable_dummy_code]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF__pharmacie__sfi_i__037240B6] DEFAULT (0) FOR [sfi_is_sfi]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_added_by_dr_id] DEFAULT (0) FOR [pharm_added_by_dr_id]
GO
ALTER TABLE [dbo].[pharmacies] ADD CONSTRAINT [DF_pharmacies_pharm_pending_addition] DEFAULT (0) FOR [pharm_pending_addition]
GO
ALTER TABLE [dbo].[pharmacies] ADD  DEFAULT ((3)) FOR [SS_VERSION]
GO
