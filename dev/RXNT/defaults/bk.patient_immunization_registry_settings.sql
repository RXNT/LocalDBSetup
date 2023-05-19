ALTER TABLE [bk].[patient_immunization_registry_settings] ADD CONSTRAINT [DF__patient_i__creat__01217A9E] DEFAULT (getdate()) FOR [created_date]
GO
