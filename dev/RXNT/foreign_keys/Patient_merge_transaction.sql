ALTER TABLE [dbo].[Patient_merge_transaction] WITH CHECK ADD CONSTRAINT [FK_Patient_merge_transaction_Patient_merge_request_queue]
   FOREIGN KEY([pa_merge_reqid]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
