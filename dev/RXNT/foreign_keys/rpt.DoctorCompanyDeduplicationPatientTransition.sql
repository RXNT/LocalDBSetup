ALTER TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationPatientTransition_DoctorCompanyDeduplicationTransition]
   FOREIGN KEY([DoctorCompanyDeduplicationTransitionId]) REFERENCES [rpt].[DoctorCompanyDeduplicationTransition] ([DoctorCompanyDeduplicationTransitionId])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationPatientTransition_Patient_merge_request_queue]
   FOREIGN KEY([PatientMergeRequestBatchId]) REFERENCES [dbo].[Patient_merge_request_queue] ([pa_merge_reqid])

GO
ALTER TABLE [rpt].[DoctorCompanyDeduplicationPatientTransition] WITH CHECK ADD CONSTRAINT [FK_DoctorCompanyDeduplicationPatientTransition_ProcessStatusTypes]
   FOREIGN KEY([ProcessStatusTypeId]) REFERENCES [rpt].[ProcessStatusTypes] ([ProcessStatusTypeId])

GO
