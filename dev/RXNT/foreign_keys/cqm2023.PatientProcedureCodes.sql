ALTER TABLE [cqm2023].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientProcedureCodes_doctors]
   FOREIGN KEY([DoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [cqm2023].[PatientProcedureCodes] WITH CHECK ADD CONSTRAINT [FK_cqm2023_PatientProcedureCodes_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
