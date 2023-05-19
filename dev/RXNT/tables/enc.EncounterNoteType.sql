CREATE TABLE [enc].[EncounterNoteType] (
   [Id] [int] NOT NULL,
   [Code] [varchar](10) NOT NULL,
   [Name] [varchar](50) NOT NULL,
   [LOINC] [varchar](10) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_enc_EncounterNoteType] PRIMARY KEY CLUSTERED ([Id])
)


GO
