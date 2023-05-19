CREATE TABLE [ehr].[ImplantableDevice] (
   [ImplantableDeviceId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DeviceId] [varchar](50) NULL,
   [DeviceIdIssuingAgency] [varchar](200) NULL,
   [BrandName] [varchar](200) NOT NULL,
   [CompanyName] [varchar](200) NULL,
   [VersionModelNumber] [varchar](200) NULL,
   [MRISafetyStatus] [varchar](500) NULL,
   [LabeledContainsNRL] [varchar](200) NULL,
   [DeviceRecordStatus] [varchar](200) NULL,
   [CreationDate] [varchar](200) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ImplantableDevice] PRIMARY KEY CLUSTERED ([ImplantableDeviceId])
)


GO
