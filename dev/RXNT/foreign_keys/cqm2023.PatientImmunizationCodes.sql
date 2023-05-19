ALTER TABLE [cqm2023].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientImmunizationCodes_PatientImmunizationCodes2]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientImmunizationCodes_PatientImmunizationCodes1]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientImmunizationCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientImmunizationCodes_PatientImmunizationCodes]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
