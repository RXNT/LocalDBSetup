ALTER TABLE [rpt].[DeduplicationPatientGroups] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatientGroups_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPatientGroups] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatientGroups_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
