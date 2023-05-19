ALTER TABLE [dbo].[patient_active_diagnosis_external] ADD CONSTRAINT [DF_patient_active_diagnosis_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
