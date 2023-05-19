CREATE TABLE [dbo].[TokenRepository] (
   [TOKEN_ID] [varchar](256) NOT NULL,
   [CREATION_DATE] [datetime] NOT NULL,
   [EXPIRY_DATE] [datetime] NOT NULL,
   [ACCESS_LEVEL] [int] NULL

   ,CONSTRAINT [PK__TokenRepository__1D072A30] PRIMARY KEY CLUSTERED ([TOKEN_ID])
)


GO
