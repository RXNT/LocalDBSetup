CREATE TABLE [cqm2023].[PatientDiagnosisCodes] (
   [DiagnosisCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DiagnosisId] [bigint] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosisCodes] PRIMARY KEY CLUSTERED ([DiagnosisCodeId])
)


GO
