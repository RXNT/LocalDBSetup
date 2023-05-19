CREATE TABLE [cqm2023].[PatientDiagnosticStudyCodes] (
   [DiagnosticStudyCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [DiagnosticStudyId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientDiagnosticStudyCodes] PRIMARY KEY CLUSTERED ([DiagnosticStudyCodeId])
)


GO
