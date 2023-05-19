ALTER TABLE [dbo].[doctor_patient_messages] WITH CHECK ADD CONSTRAINT [FK_doctor_patient_messages_PatientRepresentatives]
   FOREIGN KEY([PatientRepresentativeId]) REFERENCES [phr].[PatientRepresentatives] ([PatientRepresentativeId])

GO
