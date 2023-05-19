ALTER TABLE [cqm2022].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientCommunicationCodes] WITH CHECK ADD CONSTRAINT [FK_PatientCommunicationCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
