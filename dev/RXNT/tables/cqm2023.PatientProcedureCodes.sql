CREATE TABLE [cqm2023].[PatientProcedureCodes] (
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
   [ValueSetId] [int] NULL,
   [Status] [varchar](50) NULL,
   [ReasonTypeCode] [varchar](15) NULL

   ,CONSTRAINT [PK_PatientProcedureCodes] PRIMARY KEY CLUSTERED ([ProcedureCodeId])
)


GO
