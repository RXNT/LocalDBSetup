ALTER TABLE [dbo].[tblVaccinationRecord] ADD CONSTRAINT [DF__tblVaccin__recor__15B1B7D9] DEFAULT (getdate()) FOR [record_modified_date]
GO
