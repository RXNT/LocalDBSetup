ALTER TABLE [phr].[PatientRepresentativesInfo] WITH CHECK ADD CONSTRAINT [FK_PatientRepresentativesInfo_PatientRepresentativeId]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
