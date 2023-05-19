CREATE TABLE [cqm2018].[PatientEncounterCodes] (
   [EncounterCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientEncounterCodes] PRIMARY KEY CLUSTERED ([EncounterCodeId])
)


GO
