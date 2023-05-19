CREATE TABLE [dbo].[DataExportSettings] (
   [DataExportSettingId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [int] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [ExportType] [bigint] NOT NULL,
   [CycleName] [varchar](100) NULL,
   [CycleFrequencyTypeId] [bigint] NULL,
   [StartDate] [datetime2] NULL,
   [EndDate] [datetime2] NULL,
   [RunDayTypeId] [bigint] NULL,
   [RunAt] [datetime2] NULL,
   [RunAtTimeId] [bigint] NULL,
   [Location] [varchar](250) NULL,
   [LastRunDate] [datetime2] NULL,
   [RecurringCriteria] [bigint] NULL,
   [LastRunStatusId] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DataExportSettings] PRIMARY KEY CLUSTERED ([DataExportSettingId])
)


GO
