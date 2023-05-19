ALTER TABLE [dbo].[patient_phr_access_log] WITH CHECK ADD CONSTRAINT [FK_patient_phr_access_log_PatientRepresentatives]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
