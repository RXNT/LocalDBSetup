ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_pd_id] DEFAULT (0) FOR [pd_id]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_entry_date] DEFAULT (getdate()) FOR [entry_date]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_event_text] DEFAULT ('') FOR [event_text]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_fire_count] DEFAULT (0) FOR [fire_count]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_repeat_unit] DEFAULT ('') FOR [repeat_unit]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_repeat_interval] DEFAULT (0) FOR [repeat_interval]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_repeat_count] DEFAULT (0) FOR [repeat_count]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_event_flags] DEFAULT (0) FOR [event_flags]
GO
ALTER TABLE [dbo].[scheduled_events] ADD CONSTRAINT [DF_scheduled_events_parent_event_id] DEFAULT (0) FOR [parent_event_id]
GO
