CREATE TABLE [cqm2018].[DoctorCQMCalculationRequest] (
   [RequestId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorId] [bigint] NULL,
   [StartDate] [date] NULL,
   [EndDate] [date] NULL,
   [StatusId] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedOn] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [Active] [bit] NOT NULL,
   [DataImportStatus] [bit] NULL,
   [RetryCount] [int] NULL
)


GO
