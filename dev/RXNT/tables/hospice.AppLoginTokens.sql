CREATE TABLE [hospice].[AppLoginTokens] (
   [AppLoginTokenId] [bigint] NOT NULL
      IDENTITY (1,1),
   [PartnerId] [bigint] NOT NULL,
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

   ,CONSTRAINT [AK_hospice_AppLoginTokens_Token] UNIQUE NONCLUSTERED ([Token])
   ,CONSTRAINT [PK_hospice_AppLoginTokens] PRIMARY KEY CLUSTERED ([AppLoginTokenId])
)


GO
