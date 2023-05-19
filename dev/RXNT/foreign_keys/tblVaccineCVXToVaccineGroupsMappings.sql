ALTER TABLE [dbo].[tblVaccineCVXToVaccineGroupsMappings] WITH CHECK ADD CONSTRAINT [FK_tblVaccineCVXToVaccineGroupsMappings_tblVaccineCVX]
   FOREIGN KEY([cvx_id]) REFERENCES [dbo].[tblVaccineCVX] ([cvx_id])

GO
