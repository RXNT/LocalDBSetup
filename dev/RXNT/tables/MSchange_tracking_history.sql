CREATE TABLE [dbo].[MSchange_tracking_history] (
   [internal_table_name] [nvarchar](128) NOT NULL,
   [table_name] [nvarchar](128) NOT NULL,
   [start_time] [datetime] NOT NULL,
   [end_time] [datetime] NOT NULL,
   [rows_cleaned_up] [bigint] NOT NULL,
   [cleanup_version] [bigint] NOT NULL,
   [comments] [nvarchar](max) NOT NULL

)

CREATE NONCLUSTERED INDEX [IX_MSchange_tracking_history_start_time] ON [dbo].[MSchange_tracking_history] ([start_time])

GO
