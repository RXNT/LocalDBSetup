ALTER TABLE [dbo].[enchanced_encounter] WITH CHECK ADD CONSTRAINT [FK_enchanced_encounter_EncounterNoteType]
   FOREIGN KEY([EncounterNoteTypeId]) REFERENCES [enc].[EncounterNoteType] ([Id])

GO
ALTER TABLE [dbo].[enchanced_encounter] WITH CHECK ADD CONSTRAINT [FkEnchancedEncounterInformationBlockingReason]
   FOREIGN KEY([InformationBlockingReasonId]) REFERENCES [dbo].[InformationBlockingReason] ([Id])

GO
