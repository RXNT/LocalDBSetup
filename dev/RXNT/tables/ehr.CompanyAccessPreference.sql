CREATE TABLE [ehr].[CompanyAccessPreference] (
   [CompanyAccessPreferenceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [AccessPreferenceId] [bigint] NOT NULL,
   [PreferenceValueId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_CompanyAccessPreferenceId] PRIMARY KEY CLUSTERED ([CompanyAccessPreferenceId])
)


GO
