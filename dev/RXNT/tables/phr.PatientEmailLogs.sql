CREATE TABLE [phr].[PatientEmailLogs] (
   [PatientEmailLogId] [bigint] NOT NULL
      IDENTITY (1,1),
   [DoctorCompanyId] [int] NOT NULL,
   [PatientId] [int] NOT NULL,
   [Type] [bigint] NOT NULL,
   [Token] [varchar](900) NULL,
   [TokenExpiryDate] [datetime] NULL,
   [Active] [bit] NULL,
   [Status] [bit] NULL,
   [StatusMessage] [varchar](255) NULL,
   [ApplicationId] [int] NULL,
   [CreatedDate] [datetime] NULL,
   [CreatedBy] [bigint] NULL,
   [LastModifiedDate] [datetime] NULL,
   [LastModifiedBy] [bigint] NULL,
   [InActivatedDate] [datetime] NULL,
   [InActivatedBy] [bigint] NULL,
   [PatientRepresentativeId] [bigint] NULL,
   [CreatedDateUtc] [datetime2] NULL,
   [LastModifiedDateUtc] [datetime2] NULL,
   [InactivatedDateUtc] [datetime2] NULL,
   [Email] [varchar](80) NULL

   ,CONSTRAINT [PK_PatientEmailLogs] PRIMARY KEY CLUSTERED ([PatientEmailLogId])
)

CREATE NONCLUSTERED INDEX [IX_PatientEmailLogs_Token] ON [phr].[PatientEmailLogs] ([Token])

GO
