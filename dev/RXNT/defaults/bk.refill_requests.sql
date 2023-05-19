ALTER TABLE [bk].[refill_requests] ADD CONSTRAINT [DF__refill_re__creat__3C42406C] DEFAULT (getdate()) FOR [created_date]
GO
