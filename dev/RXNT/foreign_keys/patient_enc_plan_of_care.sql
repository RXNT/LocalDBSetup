ALTER TABLE [dbo].[patient_enc_plan_of_care] WITH CHECK ADD CONSTRAINT [FK_patient_enc_plan_of_care_patient_encounters]
   FOREIGN KEY([enc_id]) REFERENCES [dbo].[patient_encounters] ([enc_id])

GO
