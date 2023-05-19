ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_EncounterId] DEFAULT (NULL) FOR [EncounterId]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_EffectiveDate] DEFAULT (getdate()) FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_CreatedUserId] DEFAULT (NULL) FOR [CreatedUserId]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_CreatedTimestamp] DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_LastModifiedUserId] DEFAULT (NULL) FOR [LastModifiedUserId]
GO
ALTER TABLE [dbo].[PatientCarePlan] ADD CONSTRAINT [DEFAULT_PatientCarePlan_LastModifiedTimestamp] DEFAULT (getdate()) FOR [LastModifiedTimestamp]
GO
