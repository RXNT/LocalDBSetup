CREATE TABLE [phr].[Login] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [Username] [varchar](30) NOT NULL,
   [Password] [varchar](100) NULL,
   [Salt] [varchar](20) NOT NULL,
   [Active] [bit] NOT NULL,
   [UserAgreementId] [int] NULL,
   [WeavyId] [int] NULL,
   [CreatedBy] [int] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedBy] [int] NULL,
   [ModifiedDate] [datetime2] NULL,
   [InactivatedBy] [int] NULL,
   [InactivatedDate] [datetime2] NULL

   ,CONSTRAINT [PK_Login] PRIMARY KEY NONCLUSTERED ([Id])
)

CREATE UNIQUE NONCLUSTERED INDEX [AK_Login_Username] ON [phr].[Login] ([Username])

GO
