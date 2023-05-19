CREATE TABLE [dbo].[ManualMergedPatients] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [PrimaryPatientId] [bigint] NULL,
   [SecondaryPatientId] [bigint] NULL

   ,CONSTRAINT [PK_ManualMergedPatients] PRIMARY KEY CLUSTERED ([Id])
)


GO
