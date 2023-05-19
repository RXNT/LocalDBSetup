ALTER TABLE [dbo].[PatientHealthConcerns] WITH CHECK ADD CONSTRAINT [FK_PatientHealthConcerns_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [dbo].[PatientHealthConcerns] WITH CHECK ADD CONSTRAINT [FK_PatientHealthConcerns_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
