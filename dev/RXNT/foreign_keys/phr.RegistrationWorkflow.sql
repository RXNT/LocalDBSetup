ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_DoctorCompanyId]
   FOREIGN KEY([DoctorCompanyId]) REFERENCES [dbo].[doc_companies] ([dc_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_DoctorGroupId]
   FOREIGN KEY([DoctorGroupId]) REFERENCES [dbo].[doc_groups] ([dg_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[RegistrationWorkflow] WITH CHECK ADD CONSTRAINT [FK_RegistrationWorkflow_RegistrationWorkflowStateId]
   FOREIGN KEY([RegistrationWorkflowStateId]) REFERENCES [phr].[RegistrationWorkflowState] ([Id])

GO
