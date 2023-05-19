ALTER TABLE [bk].[patient_active_meds_external] ADD CONSTRAINT [DF__patient_a__creat__124C06A0] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_meds_external] ADD CONSTRAINT [DF_patient_active_meds_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
