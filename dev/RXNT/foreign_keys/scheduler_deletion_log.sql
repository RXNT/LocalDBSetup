ALTER TABLE [dbo].[scheduler_deletion_log] WITH CHECK ADD CONSTRAINT [FK__scheduler__event__6B9C4DD3]
   FOREIGN KEY([event_id]) REFERENCES [dbo].[scheduler_main] ([event_id])

GO
