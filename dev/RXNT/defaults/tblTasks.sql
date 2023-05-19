ALTER TABLE [dbo].[tblTasks] ADD CONSTRAINT [DF__tblTasks__task_s__0495A9BF] DEFAULT ('FALSE') FOR [task_src_deleted]
GO
ALTER TABLE [dbo].[tblTasks] ADD CONSTRAINT [DF__tblTasks__task_d__067DF231] DEFAULT ('FALSE') FOR [task_dst_deleted]
GO
