ALTER TABLE [ehr].[CompanyApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_CompanyApplicationConfiguration_ApplicationConfigurationId]
   FOREIGN KEY([ApplicationConfigurationId]) REFERENCES [ehr].[ApplicationConfiguration] ([ApplicationConfigurationId])

GO
ALTER TABLE [ehr].[CompanyApplicationConfiguration] WITH CHECK ADD CONSTRAINT [FK_CompanyApplicationConfiguration_ConfigurationValue]
   FOREIGN KEY([ConfigurationValueId]) REFERENCES [ehr].[ApplicationTableConstants] ([ApplicationTableConstantId])

GO
