CREATE TABLE [rpt].[DeduplicationExcludePatients] (
   [DeduplicationExcludePatientId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL,
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
   [ProcessStartDate] [datetime2] NULL,
   [ProcessEndDate] [datetime2] NULL,
   [ProcessStatusMessage] [varchar](4000) NULL,
   [PrimaryPatientId] [bigint] NOT NULL,
   [SecondaryPatientId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DeduplicationExcludePatients] PRIMARY KEY CLUSTERED ([DeduplicationExcludePatientId])
)


GO
