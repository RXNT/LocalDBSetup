CREATE TABLE [cqm2023].[PatientAttributeCodes] (
   [AttributeCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [AttributeId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [int] NULL,
   [PerformedToDate] [int] NULL

   ,CONSTRAINT [PK_PatientAttributeCodes] PRIMARY KEY CLUSTERED ([AttributeCodeId])
)


GO
