ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_DeduplicationPatientGroups]
   FOREIGN KEY([DeduplicationPatientGroupId]) REFERENCES [rpt].[DeduplicationPatientGroups] ([DeduplicationPatientGroupId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_DuplicationTypes]
   FOREIGN KEY([DuplicationTypeId]) REFERENCES [rpt].[DuplicationTypes] ([DuplicationTypeId])

GO
ALTER TABLE [rpt].[DeduplicationPatients] WITH CHECK ADD CONSTRAINT [FK_DeduplicationPatients_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
