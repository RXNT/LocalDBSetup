ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_beta_tester] DEFAULT ((0)) FOR [beta_tester]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_sfi_group] DEFAULT ((0)) FOR [sfi_group]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_sfi_patient_lookup] DEFAULT ((0)) FOR [sfi_patient_lookup]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_payment_plan_id] DEFAULT ((1)) FOR [payment_plan_id]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF_doc_groups_payment_reoccurrence] DEFAULT ((0)) FOR [payment_reoccurrence]
GO
ALTER TABLE [dbo].[doc_groups] ADD CONSTRAINT [DF__doc_group__sched__7FAC9CCA] DEFAULT ((1)) FOR [scheduled_enabled]
GO
ALTER TABLE [dbo].[doc_groups] ADD  DEFAULT ((0)) FOR [lab_status]
GO
ALTER TABLE [dbo].[doc_groups] ADD  DEFAULT ((0)) FOR [emr_modules]
GO
