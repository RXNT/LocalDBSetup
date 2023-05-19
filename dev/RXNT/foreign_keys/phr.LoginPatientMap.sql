ALTER TABLE [phr].[LoginPatientMap] WITH CHECK ADD CONSTRAINT [FK_LoginPatientMap_Login]
   FOREIGN KEY([LoginId]) REFERENCES [phr].[Login] ([Id])

GO
ALTER TABLE [phr].[LoginPatientMap] WITH CHECK ADD CONSTRAINT [FK_LoginPatientMap_PatientId]
   FOREIGN KEY([PatientId]) REFERENCES [dbo].[patients] ([pa_id])

GO
ALTER TABLE [phr].[LoginPatientMap] WITH CHECK ADD CONSTRAINT [FK_LoginPatientMap_Type]
   FOREIGN KEY([Type]) REFERENCES [phr].[LoginType] ([Id])

GO
