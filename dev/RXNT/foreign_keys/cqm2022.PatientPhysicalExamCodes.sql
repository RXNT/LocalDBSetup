ALTER TABLE [cqm2022].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2022].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [cqm2022].[PatientPhysicalExamCodes] WITH CHECK ADD CONSTRAINT [FK_PatientPhysicalExamCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
