ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_CreatedByDoctorId]
   FOREIGN KEY([CreatedByDoctorId]) REFERENCES [dbo].[doctors] ([dr_id])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_CreatedByPatientId]
   FOREIGN KEY([CreatedByPatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_DoctorCompanyId]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [phr].[PatientTextLog] WITH CHECK ADD CONSTRAINT [FK_PatientTextLog_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
