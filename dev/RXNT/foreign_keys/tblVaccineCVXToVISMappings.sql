ALTER TABLE [dbo].[tblVaccineCVXToVISMappings] WITH CHECK ADD CONSTRAINT [FK_tblVaccineCVXToVISMappings_tblVaccineCVX]
   FOREIGN KEY([cvx_id]) REFERENCES [dbo].[tblVaccineCVX] ([cvx_id])

GO
ALTER TABLE [dbo].[tblVaccineCVXToVISMappings] WITH CHECK ADD CONSTRAINT [FK_tblVaccineCVXToVISMappings_tblVaccineVIS]
   FOREIGN KEY([vis_concept_id]) REFERENCES [dbo].[tblVaccineVIS] ([vis_concept_id])

GO
