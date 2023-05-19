CREATE TABLE [cqm2022].[PatientInterventionCodes] (
   [InterventionCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [InterventionId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [Status] [varchar](50) NULL,
   [ReasonTypeCode] [varchar](15) NULL

   ,CONSTRAINT [PK_PatientInterventionCodes] PRIMARY KEY CLUSTERED ([InterventionCodeId])
)


GO
