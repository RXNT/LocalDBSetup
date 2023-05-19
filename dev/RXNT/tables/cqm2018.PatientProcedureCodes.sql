CREATE TABLE [cqm2018].[PatientProcedureCodes] (
   [ProcedureCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [ProcedureId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL,
   [ValueSetId] [int] NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
