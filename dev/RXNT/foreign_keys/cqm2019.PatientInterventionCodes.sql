ALTER TABLE [cqm2019].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_PatientInterventionCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2019].[PatientInterventionCodes] WITH CHECK ADD CONSTRAINT [FK_PatientInterventionCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
