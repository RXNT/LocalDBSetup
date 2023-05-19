CREATE TABLE [ehr].[CompanyApplicationConfiguration] (
   [CompanyApplicationConfigurationId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [ApplicationConfigurationId] [bigint] NOT NULL,
   [ConfigurationValueId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_CompanyApplicationConfigurationId] PRIMARY KEY CLUSTERED ([CompanyApplicationConfigurationId])
)


GO
