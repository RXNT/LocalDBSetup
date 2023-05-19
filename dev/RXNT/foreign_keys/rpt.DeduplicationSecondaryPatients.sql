ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_DeduplicationPrimaryPatients]
   FOREIGN KEY([DeduplicationPrimaryPatientId]) REFERENCES [rpt].[DeduplicationPrimaryPatients] ([DeduplicationPrimaryPatientId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_DuplicationTypes]
   FOREIGN KEY([DuplicationTypeId]) REFERENCES [rpt].[DuplicationTypes] ([DuplicationTypeId])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DeduplicationSecondaryPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationSecondaryPatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
