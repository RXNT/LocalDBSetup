ALTER TABLE [dbo].[Patient_CCD_request_queue] WITH CHECK ADD CONSTRAINT [FK_Patient_CCD_request_queue_Patient_CCD_request_batch]
   FOREIGN KEY([batchid]) REFERENCES [dbo].[Patient_CCD_request_batch] ([batchid])

GO
