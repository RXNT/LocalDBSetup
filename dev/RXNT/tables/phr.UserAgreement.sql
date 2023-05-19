CREATE TABLE [phr].[UserAgreement] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [TermsAndConditions] [varchar](max) NULL,
   [PrivacyPolicy] [varchar](max) NULL,
   [Active] [bit] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedDate] [datetime2] NULL,
   [InactivatedDate] [datetime2] NULL

   ,CONSTRAINT [PK_UserAgreement] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
