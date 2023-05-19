ALTER TABLE [dbo].[patient_medical_hx_external] ADD CONSTRAINT [DF_patient_medical_hx_external_enable] DEFAULT ((1)) FOR [pme_enable]
GO
