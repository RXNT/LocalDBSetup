CREATE TABLE [dbo].[payor_login] (
   [uid] [int] NOT NULL
      IDENTITY (1,1),
   [username] [varchar](50) NOT NULL,
   [password] [varchar](50) NOT NULL,
   [payor_id] [smallint] NOT NULL,
   [comments] [varchar](225) NOT NULL,
   [title] [varchar](50) NOT NULL,
   [search_restriction] [smallint] NOT NULL,
   [enabled] [bit] NOT NULL,
   [SEARCHID] [int] NOT NULL

   ,CONSTRAINT [PK_payor_login] PRIMARY KEY CLUSTERED ([uid])
)


GO
