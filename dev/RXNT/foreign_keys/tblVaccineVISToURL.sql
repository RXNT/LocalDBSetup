ALTER TABLE [dbo].[tblVaccineVISToURL] WITH CHECK ADD CONSTRAINT [FK_tblVaccineVISToURL_tblVaccineVIS]
   FOREIGN KEY([vis_concept_id]) REFERENCES [dbo].[tblVaccineVIS] ([vis_concept_id])

GO
