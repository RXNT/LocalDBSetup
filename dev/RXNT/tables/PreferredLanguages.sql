CREATE TABLE [dbo].[PreferredLanguages] (
   [PreferredLanguageId] [int] NOT NULL,
   [Name] [varchar](100) NOT NULL,
   [Code] [varchar](10) NOT NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_PreferredLanguages] PRIMARY KEY CLUSTERED ([PreferredLanguageId])
)


GO
