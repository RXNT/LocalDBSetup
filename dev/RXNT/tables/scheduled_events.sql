CREATE TABLE [dbo].[scheduled_events] (
   [se_id] [int] NOT NULL
      IDENTITY (1,1),
   [pd_id] [int] NOT NULL,
   [for_user_id] [int] NOT NULL,
   [entry_user_id] [int] NOT NULL,
   [entry_date] [datetime] NOT NULL,
   [first_fire_date] [datetime] NOT NULL,
   [next_fire_date] [datetime] NOT NULL,
   [event_type] [int] NOT NULL,
   [event_text] [varchar](255) NOT NULL,
   [fire_count] [int] NOT NULL,
   [repeat_unit] [varchar](4) NOT NULL,
   [repeat_interval] [int] NOT NULL,
   [repeat_count] [int] NOT NULL,
   [event_flags] [int] NOT NULL,
   [parent_event_id] [int] NOT NULL

   ,CONSTRAINT [PK_scheduled_events] PRIMARY KEY CLUSTERED ([se_id])
)

CREATE NONCLUSTERED INDEX [Index_users] ON [dbo].[scheduled_events] ([pd_id], [for_user_id], [entry_user_id])
CREATE NONCLUSTERED INDEX [scheduled_index_dates] ON [dbo].[scheduled_events] ([pd_id], [entry_date], [first_fire_date], [next_fire_date])
CREATE NONCLUSTERED INDEX [schedules_index_event] ON [dbo].[scheduled_events] ([pd_id], [event_type])

GO
