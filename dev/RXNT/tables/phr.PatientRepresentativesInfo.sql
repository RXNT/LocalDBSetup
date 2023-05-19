CREATE TABLE [phr].[PatientRepresentativesInfo] (
   [PatientRepresentativesInfoId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientRepresentativeId] [bigint] NOT NULL,
   [Text1] [varchar](50) NOT NULL,
   [Text2] [varchar](500) NOT NULL,
   [Text3] [varchar](500) NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_Text1] UNIQUE NONCLUSTERED ([Text1])
   ,CONSTRAINT [PK_PatientRepresentativesInfo] PRIMARY KEY CLUSTERED ([PatientRepresentativesInfoId])
)


GO
