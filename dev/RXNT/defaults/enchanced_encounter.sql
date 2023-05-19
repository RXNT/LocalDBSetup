ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__enc_t__0CB8B83C] DEFAULT ('') FOR [enc_text]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__chief__0DACDC75] DEFAULT ('') FOR [chief_complaint]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced___type__6CE4AC70] DEFAULT ('RxNTEncounterModels.EnhancedPatientEncounter') FOR [type]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__issig__6ECCF4E2] DEFAULT ((0)) FOR [issigned]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__last___4D21E854] DEFAULT (getdate()) FOR [last_modified_date]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__is_mu__72D81F51] DEFAULT ((0)) FOR [is_multisignature]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD CONSTRAINT [DF__enchanced__is_in__73CC438A] DEFAULT ((0)) FOR [is_inreview]
GO
ALTER TABLE [dbo].[enchanced_encounter] ADD  DEFAULT (NULL) FOR [EncounterReasonSnomedCode]
GO
