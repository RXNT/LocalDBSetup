CREATE TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] (
   [DoctorCompanyDeduplicationPatientTransitionId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicationTransitionId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [DoctorGroupId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PatientMergeRequestBatchId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorCompanyDeduplicationPatientTransition] PRIMARY KEY CLUSTERED ([DoctorCompanyDeduplicationPatientTransitionId])
)

CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationPatientTransition_Active_includes] ON [rpt].[DoctorCompanyDeduplicationPatientTransition] ([Active]) INCLUDE ([DoctorCompanyDeduplicationPatientTransitionId], [DoctorCompanyDeduplicationTransitionId], [DoctorGroupId], [PatientId], [ProcessStatusTypeId])
CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationPatientTransition_CompanyId_PatientId] ON [rpt].[DoctorCompanyDeduplicationPatientTransition] ([CompanyId], [PatientId])
CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationPatientTransition_DoctorCompanyDeduplicationTransitionId_Active] ON [rpt].[DoctorCompanyDeduplicationPatientTransition] ([DoctorCompanyDeduplicationTransitionId], [Active])

GO
