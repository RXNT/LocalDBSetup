ALTER TABLE [dbo].[patient_active_diagnosis] ADD CONSTRAINT [DF_patient_active_diagnosis_icd9] DEFAULT ('') FOR [icd9]
GO
ALTER TABLE [dbo].[patient_active_diagnosis] ADD CONSTRAINT [DF__patient_a__enabl__304FD425] DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[patient_active_diagnosis] ADD CONSTRAINT [DF__patient_a__recor__3EE8D796] DEFAULT (getdate()) FOR [record_modified_date]
GO
