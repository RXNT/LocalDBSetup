ALTER TABLE [cqm2023].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationProcedureCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2023].[PatientMedicationProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientMedicationProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
