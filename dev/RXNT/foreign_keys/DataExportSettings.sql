ALTER TABLE [dbo].[DataExportSettings] WITH CHECK ADD CONSTRAINT [FK_DataExportSettings_DoctorCompanies]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
