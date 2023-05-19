CREATE TABLE [cqm2023].[PatientLaboratoryTestCodes] (
   [LaboratoryTestCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [LaboratoryTestId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientLaboratoryTestCodes] PRIMARY KEY CLUSTERED ([LaboratoryTestCodeId])
)


GO
