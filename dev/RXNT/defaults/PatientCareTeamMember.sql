ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_License] DEFAULT (NULL) FOR [License]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_RoleDescription] DEFAULT (NULL) FOR [RoleDescription]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_PhoneNumber] DEFAULT (NULL) FOR [PhoneNumber]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_Email] DEFAULT (NULL) FOR [Email]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_AddressId] DEFAULT (NULL) FOR [AddressId]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD CONSTRAINT [DF_StatusId] DEFAULT (NULL) FOR [StatusId]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT ('') FOR [RoleCode]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT ('') FOR [LastName]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PatientCareTeamMember] ADD  DEFAULT ((1)) FOR [CreatedBy]
GO
