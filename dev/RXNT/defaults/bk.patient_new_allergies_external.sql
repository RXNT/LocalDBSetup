ALTER TABLE [bk].[patient_new_allergies_external] ADD CONSTRAINT [DF__patient_n__creat__77981064] DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [bk].[patient_new_allergies_external] ADD CONSTRAINT [DF_patient_new_allergies_external_is_from_ccd] DEFAULT ((0)) FOR [is_from_ccd]
GO
