ALTER TABLE [dbo].[patient_new_allergies_external] ADD CONSTRAINT [DF_patient_new_allergies_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
