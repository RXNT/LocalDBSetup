CREATE TABLE [adm].[SchedulerDataMigrationRequests] (
   [request_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dc_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL,
   [reuested_on] [datetime] NOT NULL,
   [migrated_on] [datetime] NULL,
   [status] [int] NOT NULL

   ,CONSTRAINT [PK_SchedulerDataMigrationRequests] PRIMARY KEY CLUSTERED ([request_id])
)


GO
