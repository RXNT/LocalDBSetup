ALTER TABLE [phr].[PatientRepresentatives] WITH CHECK ADD CONSTRAINT [FK_PatientRepresentatives_PersonRelationshipId]
   FOREIGN KEY([PersonRelationshipId]) REFERENCES [phr].[PersonRelationships] ([PersonRelationshipId])

GO
