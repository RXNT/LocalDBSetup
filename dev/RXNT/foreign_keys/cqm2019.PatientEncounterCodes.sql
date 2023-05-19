ALTER TABLE [cqm2019].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_PatientEncounterCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_PatientEncounterCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
