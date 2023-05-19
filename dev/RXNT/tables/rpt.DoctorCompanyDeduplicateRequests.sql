CREATE TABLE [rpt].[DoctorCompanyDeduplicateRequests] (
   [DoctorCompanyDeduplicateRequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [CompanyId] [bigint] NOT NULL,
   [ProcessStatusTypeId] [bigint] NOT NULL,
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

   ,CONSTRAINT [PK_DoctorCompanyDeduplicateRequests] PRIMARY KEY CLUSTERED ([DoctorCompanyDeduplicateRequestId])
)


GO
