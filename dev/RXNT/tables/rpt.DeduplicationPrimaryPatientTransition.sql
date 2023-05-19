CREATE TABLE [rpt].[DeduplicationPrimaryPatientTransition] (
   [DeduplicationPrimaryPatientTransitionId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [PatientId] [bigint] NOT NULL,
   [PrimaryPatientCriteriaTypeId] [bigint] NOT NULL,
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

   ,CONSTRAINT [PK_DeduplicationPrimaryPatientTransition] PRIMARY KEY CLUSTERED ([DeduplicationPrimaryPatientTransitionId])
)

CREATE NONCLUSTERED INDEX [ix_DeduplicationPrimaryPatientTransition_DCDRId_DCId_PID_A] ON [rpt].[DeduplicationPrimaryPatientTransition] ([DoctorCompanyDeduplicateRequestId], [CompanyId], [Active]) INCLUDE ([PatientId], [PrimaryPatientCriteriaTypeId], [ProcessStatusTypeId])

GO
