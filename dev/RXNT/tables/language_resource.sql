CREATE TABLE [dbo].[language_resource] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [displaytext] [ntext] NOT NULL,
   [language] [smallint] NOT NULL,
   [POSITION] [int] NOT NULL

   ,CONSTRAINT [PK__language_resourc__5E218BCD] PRIMARY KEY CLUSTERED ([id])
)

CREATE UNIQUE NONCLUSTERED INDEX [NoDuplicateEntries] ON [dbo].[language_resource] ([language], [POSITION])

GO
