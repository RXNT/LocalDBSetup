CREATE TABLE [phr].[PatientPortalDocuments] (
   [PatientPortalDocumentId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DocumentId] [int] NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [DoctorId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [IsAccepted] [bit] NULL,
   [ActionDate] [datetime] NULL,
   [Active] [bit] NULL,
   [Title] [varchar](500) NOT NULL,
   [Description] [varchar](500) NOT NULL,
   [FilePath] [varchar](500) NULL,
   [FileName] [varchar](500) NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL,
   [LastModifiedDate] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [InActivatedDate] [datetime] NULL,
   [InActivatedBy] [bigint] NULL,
   [Comments] [varchar](500) NULL,
   [PatientRepresentativeId] [bigint] NULL

   ,CONSTRAINT [PK_PatientPortalDocuments] PRIMARY KEY CLUSTERED ([PatientPortalDocumentId])
)


GO
