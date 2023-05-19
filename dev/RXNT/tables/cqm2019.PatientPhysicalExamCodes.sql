CREATE TABLE [cqm2019].[PatientPhysicalExamCodes] (
   [PhysicalExamCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [int] NOT NULL,
   [EncounterId] [int] NULL,
   [DoctorId] [int] NOT NULL,
   [PhysicalExamId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientPhysicalExamCodes] PRIMARY KEY CLUSTERED ([PhysicalExamCodeId])
)

CREATE NONCLUSTERED INDEX [ix_PatientPhysicalExamCodes_PatId_PerformedFrmDt_incl] ON [cqm2019].[PatientPhysicalExamCodes] ([PatientId], [PerformedFromDate]) INCLUDE ([Code])

GO
