ALTER TABLE [dbo].[PatientTokens] WITH CHECK ADD CONSTRAINT [FK_PatientTokens_Companies]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
