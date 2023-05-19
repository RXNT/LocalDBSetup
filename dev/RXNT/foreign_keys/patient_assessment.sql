ALTER TABLE [dbo].[patient_assessment] WITH CHECK ADD CONSTRAINT [FK_patient_assessment_patient_encounters]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
