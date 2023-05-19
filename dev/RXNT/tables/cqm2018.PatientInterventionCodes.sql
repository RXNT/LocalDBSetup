CREATE TABLE [cqm2018].[PatientInterventionCodes] (
   [InterventionCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [InterventionId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientInterventionCodes] PRIMARY KEY CLUSTERED ([InterventionCodeId])
)


GO
