ALTER TABLE [dbo].[patient_review_of_sys] WITH CHECK ADD CONSTRAINT [FK_review_of_sys_patient_encounters]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
