ALTER TABLE [bk].[scheduled_rx_archive] ADD CONSTRAINT [DF__scheduled__creat__4012D150] DEFAULT (getdate()) FOR [created_date]
GO
