ALTER TABLE [dbo].[patient_hpi] WITH CHECK ADD CONSTRAINT [FK_patient_hpi_patient_hpi]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
