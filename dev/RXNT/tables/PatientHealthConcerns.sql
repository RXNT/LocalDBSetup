CREATE TABLE [dbo].[PatientHealthConcerns] (
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

   ,CONSTRAINT [PK_PatientHealthConcerns] PRIMARY KEY CLUSTERED ([Id])
)

CREATE NONCLUSTERED INDEX [Index_PatientHealthConcerns_EncounterId] ON [dbo].[PatientHealthConcerns] ([EncounterId])
CREATE NONCLUSTERED INDEX [Index_PatientHealthConcerns_PatientId] ON [dbo].[PatientHealthConcerns] ([PatientId])

GO
