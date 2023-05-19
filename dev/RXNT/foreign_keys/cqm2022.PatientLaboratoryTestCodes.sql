ALTER TABLE [cqm2022].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientLaboratoryTestCodes] WITH CHECK ADD CONSTRAINT [FK_PatientLaboratoryTestCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
