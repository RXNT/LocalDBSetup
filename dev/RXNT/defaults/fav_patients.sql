ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_update_code] DEFAULT (0) FOR [update_code]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_notes_update_code] DEFAULT (0) FOR [notes_update_code]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_drugs_update_code] DEFAULT (0) FOR [drugs_update_code]
GO
ALTER TABLE [dbo].[fav_patients] ADD CONSTRAINT [DF_fav_patients_pharm_update_code] DEFAULT (0) FOR [pharm_update_code]
GO
