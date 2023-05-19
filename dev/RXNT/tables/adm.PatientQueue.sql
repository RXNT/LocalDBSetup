CREATE TABLE [adm].[PatientQueue] (
   [PatientQueueId] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dc_id] [int] NOT NULL,
   [ActionType] [varchar](5) NOT NULL,
   [OwnerType] [varchar](5) NOT NULL,
   [QueueStatus] [varchar](5) NOT NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [int] NULL,
   [ModifiedDate] [datetime] NULL,
   [ModifiedBy] [int] NULL,
   [QueueCreatedDate] [datetime] NULL,
   [QueueProcessStartDate] [datetime] NULL,
   [QueueProcessEndDate] [datetime] NULL,
   [JobId] [bigint] NULL

   ,CONSTRAINT [PK_PatientQueue] PRIMARY KEY NONCLUSTERED ([PatientQueueId])
)


GO
