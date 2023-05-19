CREATE TABLE [dbo].[PatientGoals] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [EffectiveDate] [datetime] NULL,
   [Text] [text] NULL,
   [CreatedUserId] [int] NULL,
   [CreatedTimestamp] [datetime] NULL,
   [LastModifiedUserId] [int] NULL,
   [LastModifiedTimestamp] [datetime] NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientGoals] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [Index_PatientGoals_EncounterId] ON [dbo].[PatientGoals] ([EncounterId])
CREATE NONCLUSTERED INDEX [Index_PatientGoals_PatientId] ON [dbo].[PatientGoals] ([PatientId])

GO
