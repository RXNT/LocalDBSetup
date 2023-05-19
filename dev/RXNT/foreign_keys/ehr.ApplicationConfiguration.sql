ALTER TABLE [ehr].[ApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_ApplicationConfiguration_ConfigurationDataType]
   FOREIGN KEY([ConfigurationDataTypeId]) REFERENCES [ehr].[ApplicationTableConstants] ([ApplicationTableConstantId])

GO
ALTER TABLE [ehr].[ApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_ApplicationConfiguration_ConfigurationValue]
   FOREIGN KEY([ConfigurationValueId]) REFERENCES [ehr].[ApplicationTableConstants] ([ApplicationTableConstantId])

GO
