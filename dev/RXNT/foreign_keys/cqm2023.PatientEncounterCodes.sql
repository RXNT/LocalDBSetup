ALTER TABLE [cqm2023].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientEncounterCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientEncounterCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientEncounterCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
