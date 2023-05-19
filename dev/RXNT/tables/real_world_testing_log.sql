CREATE TABLE [dbo].[real_world_testing_log] (
   [real_world_testing_log_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [bigint] NULL,
   [event_name] [nvarchar](100) NOT NULL,
   [event_status] [nvarchar](100) NOT NULL,
   [event_date] [datetime] NULL

   ,CONSTRAINT [PK__real_wor__230B849D83BDA4C0] PRIMARY KEY CLUSTERED ([real_world_testing_log_id])
)


GO
