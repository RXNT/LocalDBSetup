CREATE TABLE [cqm2023].[PatientImmunizationCodes] (
   [ImmunizationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ImmunizationId] [bigint] NULL,
   [VaccinationRecordId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL,
   [PrescriptionId] [int] NULL

   ,CONSTRAINT [PK_PatientImmunizationCodes] PRIMARY KEY CLUSTERED ([ImmunizationCodeId])
)


GO
