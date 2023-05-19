CREATE TABLE [dbo].[PatientTokens] (
   [PatientTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PatientId] [bigint] NOT NULL,
   [DoctorCompanyId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [TokenExpiryDate] [datetime2] NOT NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [ModifiedBy] [bigint] NULL,
   [InactivatedDate] [datetime2] NULL,
   [InactivatedBy] [bigint] NULL,
   [Concurrency] [timestamp] NOT NULL

   ,CONSTRAINT [AK_PatientTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_PatientTokens] PRIMARY KEY CLUSTERED ([PatientTokenId])
)


GO
