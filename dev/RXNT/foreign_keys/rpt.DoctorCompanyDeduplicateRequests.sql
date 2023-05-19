ALTER TABLE [rpt].[DoctorCompanyDeduplicateRequests] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicateRequests_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
