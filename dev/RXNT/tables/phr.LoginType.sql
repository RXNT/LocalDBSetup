CREATE TABLE [phr].[LoginType] (
   [Id] [tinyint] NOT NULL
      IDENTITY (1,1),
   [Name] [varchar](50) NOT NULL

   ,CONSTRAINT [PK_LoginType] PRIMARY KEY NONCLUSTERED ([Id])
)


GO
