CREATE TABLE [cqm2018].[PatientPhysicalExamCodes] (
   [PhysicalExamCodeId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [EncounterId] [bigint] NULL,
   [DoctorId] [bigint] NOT NULL,
   [PhysicalExamId] [bigint] NULL,
   [Code] [varchar](50) NOT NULL,
   [CodeSystemId] [int] NOT NULL,
   [PerformedFromDate] [datetime] NULL,
   [PerformedToDate] [datetime] NULL

   ,CONSTRAINT [PK_PatientPhysicalExamCodes] PRIMARY KEY CLUSTERED ([PhysicalExamCodeId])
)

CREATE NONCLUSTERED INDEX [ix_PatientPhysicalExamCodes_PerformedFromDate_includes] ON [cqm2018].[PatientPhysicalExamCodes] ([PatientId], [PerformedFromDate]) INCLUDE ([Code])

GO
