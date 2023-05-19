CREATE TABLE [dbo].[PatientFullExportRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NULL,
   [DoctorGroupId] [bigint] NULL,
   [DoctorCompanyId] [bigint] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL,
   [FileName] [varchar](100) NULL,
   [FilePassword] [varchar](100) NULL,
   [ProcessedDate] [datetime] NULL
)


GO
