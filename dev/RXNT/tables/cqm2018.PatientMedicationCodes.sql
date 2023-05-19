CREATE TABLE [cqm2018].[PatientMedicationCodes] (
   [MedicationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [MedicationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientMedicationCodes] PRIMARY KEY CLUSTERED ([MedicationCodeId])
)


GO
