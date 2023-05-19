CREATE TABLE [cqm2018].[PatientDiagnosisCodes] (
   [DiagnosisCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DiagnosisId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosisCodes] PRIMARY KEY CLUSTERED ([DiagnosisCodeId])
)


GO
