ALTER TABLE [bk].[patient_active_diagnosis_external] ADD CONSTRAINT [DF__patient_a__creat__161C9784] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_active_diagnosis_external] ADD CONSTRAINT [DF_patient_active_diagnosis_external_is_from_ccd_1] DEFAULT ((0)) FOR [is_from_ccd]
GO
