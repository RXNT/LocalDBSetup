CREATE TABLE [cqm2018].[PatientLaboratoryTestCodes] (
   [LaboratoryTestCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [LaboratoryTestId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientLaboratoryTestCodes] PRIMARY KEY CLUSTERED ([LaboratoryTestCodeId])
)


GO
