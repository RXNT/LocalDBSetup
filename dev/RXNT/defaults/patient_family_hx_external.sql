ALTER TABLE [dbo].[patient_family_hx_external] ADD CONSTRAINT [DF_patient_family_hx_external_enable] DEFAULT ((1)) FOR [pfhe_enable]
GO
