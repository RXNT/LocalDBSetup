ALTER TABLE [dbo].[Patient_Encounter_request_queue] WITH CHECK ADD CONSTRAINT [FK_Patient_Encounter_request_queue_Patient_Encounter_request_batch]
   FOREIGN KEY([batchid]) REFERENCES [dbo].[Patient_Encounter_request_batch] ([batchid])

GO
