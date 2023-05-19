CREATE TABLE [dbo].[DataExportHistory] (
   [DataExportHistoryId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DataExportSettingId] [bigint] NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [StatusId] [bigint] NOT NULL,
   [StatusMessage] [varchar](2000) NULL,
   [BatchName] [varchar](500) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL
)


GO
