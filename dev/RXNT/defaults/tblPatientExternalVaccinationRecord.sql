ALTER TABLE [dbo].[tblPatientExternalVaccinationRecord] ADD CONSTRAINT [DF__tblPatientExternalVaccin__recor__15B1B7D9] DEFAULT (getdate()) FOR [record_modified_date]
GO
