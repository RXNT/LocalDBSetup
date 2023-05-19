CREATE TABLE [phr].[LoginToken] (
   [Id] [int] NOT NULL
      IDENTITY (1,1),
   [LoginId] [int] NOT NULL,
   [Token] [varchar](900) NOT NULL,
   [ExpiryDate] [datetime2] NOT NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [ModifiedDate] [datetime2] NOT NULL

   ,CONSTRAINT [PK_LoginToken] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
