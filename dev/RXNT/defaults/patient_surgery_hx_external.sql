ALTER TABLE [dbo].[patient_surgery_hx_external] ADD CONSTRAINT [DF_patient_surgery_hx_external_enable] DEFAULT ((1)) FOR [pse_enable]
GO
