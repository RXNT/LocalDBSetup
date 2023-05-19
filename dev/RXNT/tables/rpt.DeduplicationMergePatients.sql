CREATE TABLE [rpt].[DeduplicationMergePatients] (
   [DeduplicationMergePatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [PatientMergeRequestBatchId] [bigint] NOT NULL,
   [PatientMergeRequestQueueId] [bigint] NOT NULL,
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
   [Concurrency] [timestamp] NOT NULL,
   [DeduplicationPatientId] [bigint] NOT NULL

   ,CONSTRAINT [PK_DeduplicationMergePatients] PRIMARY KEY CLUSTERED ([DeduplicationMergePatientId])
)


GO
