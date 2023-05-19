CREATE TABLE [dbo].[Scheduler_OfficeHours] (
   [OH_ID] [int] NOT NULL
      IDENTITY (1,1),
   [DG_ID] [bigint] NOT NULL,
   [START_TIME] [time] NULL,
   [END_TIME] [time] NULL,
   [LAST_MDFD_USER] [varchar](500) NULL,
   [LAST_MDFD_DATE] [datetime] NULL

   ,CONSTRAINT [PK__Schedule__9C5CBF663EC9A75C] PRIMARY KEY CLUSTERED ([OH_ID])
)


GO
