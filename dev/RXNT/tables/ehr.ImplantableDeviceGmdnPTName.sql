CREATE TABLE [ehr].[ImplantableDeviceGmdnPTName] (
   [PatientImplantableGmdnPTNameId] [bigint] NOT NULL
      IDENTITY (1,1),
   [ImplantableDeviceId] [bigint] NOT NULL,
   [GmdnPTName] [varchar](200) NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [PK_ImplantableDeviceGmdnPTName] PRIMARY KEY CLUSTERED ([PatientImplantableGmdnPTNameId])
)


GO
