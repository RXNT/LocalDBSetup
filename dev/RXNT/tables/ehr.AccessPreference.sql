CREATE TABLE [ehr].[AccessPreference] (
   [AccessPreferenceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PreferenceCode] [varchar](5) NOT NULL,
   [PreferenceDescription] [varchar](100) NOT NULL,
   [PreferenceDataTypeId] [bigint] NOT NULL,
   [Active] [bit] NOT NULL,
   [Module] [varchar](100) NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_AccessPreferenceId] PRIMARY KEY CLUSTERED ([AccessPreferenceId])
)


GO
