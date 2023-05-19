ALTER TABLE [bk].[patient_appointment_request] ADD CONSTRAINT [DF__patient_a__creat__1063BE2E] DEFAULT (getdate()) FOR [created_date]
GO
