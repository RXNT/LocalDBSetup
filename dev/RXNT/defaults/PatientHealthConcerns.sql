ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_EncounterId] DEFAULT (NULL) FOR [EncounterId]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_EffectiveDate] DEFAULT (getdate()) FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_CreatedUserId] DEFAULT (NULL) FOR [CreatedUserId]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_CreatedTimestamp] DEFAULT (getdate()) FOR [CreatedTimestamp]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_LastModifiedUserId] DEFAULT (NULL) FOR [LastModifiedUserId]
GO
ALTER TABLE [dbo].[PatientHealthConcerns] ADD CONSTRAINT [DEFAULT_PatientHealthConcerns_LastModifiedTimestamp] DEFAULT (getdate()) FOR [LastModifiedTimestamp]
GO
