CREATE TABLE [ehr].[DoctorManageCCDViewPreferences] (
   [DoctorManageCCDViewPreferenceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ManageCCDViewDataId] [bigint] NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [DoctorId] [bigint] NOT NULL,
   [IsViewable] [bit] NOT NULL,
   [DisplayOrder] [int] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_DoctorManageCCDViewPreferences] PRIMARY KEY CLUSTERED ([DoctorManageCCDViewPreferenceId])
)


GO
