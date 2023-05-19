CREATE TABLE [ehr].[PatientImplantableDevice] (
   [PatientImplantableDeviceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [bigint] NOT NULL,
   [PatientId] [bigint] NOT NULL,
   [ImplantableDeviceId] [bigint] NOT NULL,
   [BatchNumber] [varchar](200) NULL,
   [LotNumber] [varchar](200) NULL,
   [SerialNumber] [varchar](200) NULL,
   [ManufacturedDate] [datetime2] NULL,
   [ExpirationDate] [datetime2] NULL,
   [CreatedOn] [datetime2] NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL,
   [Source] [varchar](100) NULL,
   [VisibilityHiddenToPatient] [bit] NULL

   ,CONSTRAINT [PK_PatientImplantableDevice] PRIMARY KEY CLUSTERED ([PatientImplantableDeviceId])
)


GO
