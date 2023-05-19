ALTER TABLE [rpt].[DeduplicationPrimaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatients_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
