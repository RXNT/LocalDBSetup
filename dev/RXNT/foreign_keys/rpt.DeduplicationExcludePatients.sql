ALTER TABLE [rpt].[DeduplicationExcludePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationExcludePatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationExcludePatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationExcludePatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
