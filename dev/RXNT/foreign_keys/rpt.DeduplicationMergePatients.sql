ALTER TABLE [rpt].[DeduplicationMergePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationMergePatients_DeduplicationPatients]
   FOREIGN KEY([DeduplicationPatientId]) REFERENCES [rpt].[DeduplicationPatients] ([DeduplicationPatientId])

GO
ALTER TABLE [rpt].[DeduplicationMergePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationMergePatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationMergePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationMergePatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
