ALTER TABLE [dbo].[enchanced_encounter_additional_info] ADD CONSTRAINT [DF__enchanced___type__1F9BE01D] DEFAULT ('RxNTEncounterModels.EnhancedPatientEncounter') FOR [type]
GO
ALTER TABLE [dbo].[enchanced_encounter_additional_info] ADD CONSTRAINT [DF__enchanced__issig__20900456] DEFAULT ((0)) FOR [issigned]
GO
ALTER TABLE [dbo].[enchanced_encounter_additional_info] ADD CONSTRAINT [DF__enchanced__last___2184288F] DEFAULT (getdate()) FOR [last_modified_date]
GO
