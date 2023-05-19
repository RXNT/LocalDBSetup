CREATE TABLE [cqm2018].[PatientImmunizationCodes] (
   [ImmunizationCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
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
