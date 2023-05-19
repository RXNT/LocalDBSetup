CREATE TABLE [cqm2022].[PatientEncounterCodes] (
   [EncounterCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientEncounterCodes] PRIMARY KEY CLUSTERED ([EncounterCodeId])
)


GO
