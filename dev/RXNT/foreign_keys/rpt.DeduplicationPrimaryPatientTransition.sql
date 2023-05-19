ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_PrimaryPatientCriteriaTypes]
   FOREIGN KEY([PrimaryPatientCriteriaTypeId]) REFERENCES [rpt].[PrimaryPatientCriteriaTypes] ([PrimaryPatientCriteriaTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPrimaryPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPrimaryPatientTransition_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
