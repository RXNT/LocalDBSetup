ALTER TABLE [dbo].[PatientGoals] WITH CHECK ADD CONSTRAINT [FK_PatientGoals_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [dbo].[PatientGoals] WITH CHECK ADD CONSTRAINT [FK_PatientGoals_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
