CREATE TABLE [ehr].[PatientSmokingStatusDetailExternal] (
   [PatientSmokingStatusDetailExtId] [bigint] NOT NULL
      IDENTITY (1,1),
   [Pa_Flag_Id] [bigint] NOT NULL,
   [SmokingStatusCode] [varchar](50) NOT NULL,
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [StartDate] [datetime2] NULL,
   [EndDate] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_PatientSmokingStatusDetailExternal] PRIMARY KEY CLUSTERED ([PatientSmokingStatusDetailExtId])
)


GO
