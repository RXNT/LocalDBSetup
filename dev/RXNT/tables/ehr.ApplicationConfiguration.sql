CREATE TABLE [ehr].[ApplicationConfiguration] (
   [ApplicationConfigurationId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ConfigurationCode] [varchar](5) NOT NULL,
   [ConfigurationDescription] [varchar](100) NOT NULL,
   [ConfigurationValueId] [bigint] NOT NULL,
   [ConfigurationDataTypeId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [ApplicationName] [nchar](10) NULL

   ,CONSTRAINT [AK_ApplicationConfiguration_ConfigurationCode] UNIQUE NONCLUSTERED ([ConfigurationCode])
   ,CONSTRAINT [PK_ApplicationConfigurationId] PRIMARY KEY CLUSTERED ([ApplicationConfigurationId])
)


GO
