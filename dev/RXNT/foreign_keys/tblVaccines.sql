ALTER TABLE [dbo].[tblVaccines] WITH CHECK ADD CONSTRAINT [FK_tblVaccines_tblVaccineCVX]
   FOREIGN KEY([cvx_id]) REFERENCES [dbo].[tblVaccineCVX] ([cvx_id])

GO
ALTER TABLE [dbo].[tblVaccines] WITH CHECK ADD CONSTRAINT [FK_tblVaccines_tblVaccineManufacturers]
   FOREIGN KEY([manufacturer_id]) REFERENCES [dbo].[tblVaccineManufacturers] ([manufacturer_id])

GO
