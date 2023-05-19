CREATE TABLE [cqm2022].[PatientMedicationProcedureCodes] (
   [MedicationProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [MedicationProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationProcedureCodes] PRIMARY KEY CLUSTERED ([MedicationProcedureCodeId])
)


GO
