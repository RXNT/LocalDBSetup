CREATE TABLE [dbo].[PatientCarePlan] (
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

   ,CONSTRAINT [PK_PatientCarePlan] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [Index_PatientCarePlan_EncounterId] ON [dbo].[PatientCarePlan] ([EncounterId])
CREATE NONCLUSTERED INDEX [Index_PatientCarePlan_PatientId] ON [dbo].[PatientCarePlan] ([PatientId])

GO
