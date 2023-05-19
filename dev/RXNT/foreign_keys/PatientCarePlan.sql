ALTER TABLE [dbo].[PatientCarePlan] WITH CHECK ADD CONSTRAINT [FK_PatientCarePlan_enchanced_encounter]
   FOREIGN KEY([EncounterId]) REFERENCES [dbo].[enchanced_encounter] ([enc_id])

GO
ALTER TABLE [dbo].[PatientCarePlan] WITH CHECK ADD CONSTRAINT [FK_PatientCarePlan_patients]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
