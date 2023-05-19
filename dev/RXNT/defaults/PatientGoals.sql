ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_EncounterId] DEFAULT (NULL) FOR [EncounterId]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_EffectiveDate] DEFAULT (getdate()) FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_CreatedUserId] DEFAULT (NULL) FOR [CreatedUserId]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_CreatedTimestamp] DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_LastModifiedUserId] DEFAULT (NULL) FOR [LastModifiedUserId]
GO
ALTER TABLE [dbo].[PatientGoals] ADD CONSTRAINT [DEFAULT_PatientGoals_LastModifiedTimestamp] DEFAULT (getdate()) FOR [LastModifiedTimestamp]
GO
