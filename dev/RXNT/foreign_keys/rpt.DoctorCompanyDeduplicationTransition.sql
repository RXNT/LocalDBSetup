ALTER TABLE [rpt].[DoctorCompanyDeduplicationTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationTransition_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationTransition_DuplicationTypes]
   FOREIGN KEY([DuplicationTypeId]) REFERENCES [rpt].[DuplicationTypes] ([DuplicationTypeId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationTransition_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
