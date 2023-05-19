CREATE TABLE [dbo].[PatientUnmergeRequests] (
   [PatientUnmergeRequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_merge_batchid] [bigint] NOT NULL,
   [CompanyId] [bigint] NULL,
   [StatusId] [int] NOT NULL,
   [CheckBatchId] [bit] NULL,
   [Comments] [varchar](max) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL

   ,CONSTRAINT [PK_PatientUnmergeRequests] PRIMARY KEY CLUSTERED ([PatientUnmergeRequestId])
)


GO
