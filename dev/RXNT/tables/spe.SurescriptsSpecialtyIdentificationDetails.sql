CREATE TABLE [spe].[SurescriptsSpecialtyIdentificationDetails] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [NDC] [varchar](11) NOT NULL,
   [RXCUI] [varchar](8) NULL,
   [IsSpecialty] [bit] NOT NULL,
   [PerformedOn] [datetime] NULL

   ,CONSTRAINT [PK_SurescriptsSpecialtyIdentificationDetails] PRIMARY KEY CLUSTERED ([Id])
)


GO
