ALTER TABLE [rpt].[ReactivateMergedPrimaryPatientsStatuses] WITH CHECK ADD CONSTRAINT [FK_ReactivateMergedPrimaryPatientsStatuses_DoctorCompanyDeduplicateRequests]
   FOREIGN KEY([DoctorCompanyDeduplicateRequestId]) REFERENCES [rpt].[DoctorCompanyDeduplicateRequests] ([DoctorCompanyDeduplicateRequestId])

GO
ALTER TABLE [rpt].[ReactivateMergedPrimaryPatientsStatuses] WITH CHECK ADD CONSTRAINT [FK_ReactivateMergedPrimaryPatientsStatuses_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
