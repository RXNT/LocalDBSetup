CREATE TABLE [cqm2019].[PatientProcedureCodes] (
   [ProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [ProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
