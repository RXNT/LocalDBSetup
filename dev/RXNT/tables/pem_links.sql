CREATE TABLE [dbo].[pem_links] (
   [pem_id] [int] NOT NULL,
   [pem_title] [varchar](125) NOT NULL,
   [pem_link] [varchar](225) NOT NULL,
   [pem_type] [tinyint] NOT NULL

   ,CONSTRAINT [PK_pem_links] PRIMARY KEY CLUSTERED ([pem_id])
)

CREATE NONCLUSTERED INDEX [IX_pem_links] ON [dbo].[pem_links] ([pem_title], [pem_type])

GO
