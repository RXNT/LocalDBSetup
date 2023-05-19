ALTER TABLE [dbo].[doc_fav_vitals] WITH CHECK ADD CONSTRAINT [fk_favVitals1]
   FOREIGN KEY([vitalsId]) REFERENCES [dbo].[doc_vitalsList] ([vitalsId])

GO
