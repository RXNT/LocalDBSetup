CREATE TABLE [rpt].[DoctorCompanyDeduplicationTransition] (
   [DoctorCompanyDeduplicationTransitionId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [DuplicationTypeId] [bigint] NOT NULL,
   [DuplicationText] [varchar](1000) NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorCompanyDeduplicationTransition] PRIMARY KEY CLUSTERED ([DoctorCompanyDeduplicationTransitionId])
)

CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationTransition_DCDRID_DCId_PSTId_DTId] ON [rpt].[DoctorCompanyDeduplicationTransition] ([DoctorCompanyDeduplicateRequestId], [CompanyId], [ProcessStatusTypeId], [DuplicationTypeId]) INCLUDE ([DoctorCompanyDeduplicationTransitionId], [DuplicationText])
CREATE NONCLUSTERED INDEX [ix_DoctorCompanyDeduplicationTransition_DoctorCompanyDeduplicateRequestId_Active_includes] ON [rpt].[DoctorCompanyDeduplicationTransition] ([DoctorCompanyDeduplicateRequestId], [Active]) INCLUDE ([CompanyId], [DoctorCompanyDeduplicationTransitionId], [DuplicationText], [DuplicationTypeId], [ProcessStatusTypeId])

GO
