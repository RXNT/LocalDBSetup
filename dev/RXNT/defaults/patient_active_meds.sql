ALTER TABLE [dbo].[patient_active_meds] ADD CONSTRAINT [DF_patient_active_meds_from_pres_id] DEFAULT (0) FOR [from_pd_id]
GO
ALTER TABLE [dbo].[patient_active_meds] ADD  DEFAULT (0) FOR [compound]
GO
ALTER TABLE [dbo].[patient_active_meds] ADD CONSTRAINT [DF__patient_a__drug___71601421] DEFAULT ('') FOR [drug_name]
GO
