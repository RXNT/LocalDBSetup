CREATE TABLE [rpt].[DeduplicationPatients] (
   [DeduplicationPatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DeduplicationPatientGroupId] [bigint] NOT NULL,
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [DuplicationTypeId] [bigint] NOT NULL,
   [DuplicationText] [varchar](1000) NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [Active] [bit] NOT NULL,
   [IsIndirectMapping] [bit] NULL,
   [IndirectMappingComments] [varchar](500) NULL,
   [IncludeWarningPatient] [bit] NULL,
   [IncludePatientForMerge] [bit] NULL,
   [Level] [int] NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [DeduplicationSecondaryPatientId] [bigint] NULL

   ,CONSTRAINT [PK_DeduplicationPatients] PRIMARY KEY CLUSTERED ([DeduplicationPatientId])
)

CREATE NONCLUSTERED INDEX [idx_DeduplicationPatients_DCDRID_PID_PSTID] ON [rpt].[DeduplicationPatients] ([DoctorCompanyDeduplicateRequestId], [PatientId], [ProcessStatusTypeId])

GO
