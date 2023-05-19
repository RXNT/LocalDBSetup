ALTER TABLE [dbo].[Patient_merge_request_queue] WITH CHECK ADD CONSTRAINT [FK_Patient_merge_request_queue_Patient_merge_request_batch]
   FOREIGN KEY([pa_merge_batchid]) REFERENCES [dbo].[Patient_merge_request_batch] ([pa_merge_batchid])

GO
