CREATE TABLE [cqm2018].[PatientMedicationProcedureCodes] (
   [MedicationProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [MedicationProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationProcedureCodes] PRIMARY KEY CLUSTERED ([MedicationProcedureCodeId])
)


GO
