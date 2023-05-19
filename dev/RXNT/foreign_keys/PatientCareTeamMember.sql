ALTER TABLE [dbo].[PatientCareTeamMember] WITH CHECK ADD CONSTRAINT [FK_PatientCareTeamMember_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [dbo].[PatientCareTeamMember] WITH CHECK ADD CONSTRAINT [FK_PatientCareTeamMember_StatusId]
   FOREIGN KEY([StatusId]) REFERENCES [dbo].[PatientCareTeamMemberStatus] ([Id])

GO
