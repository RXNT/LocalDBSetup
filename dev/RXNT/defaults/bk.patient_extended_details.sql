ALTER TABLE [bk].[patient_extended_details] ADD CONSTRAINT [DF__patient_e__creat__08C29C66] DEFAULT (getdate()) FOR [created_date]
GO
