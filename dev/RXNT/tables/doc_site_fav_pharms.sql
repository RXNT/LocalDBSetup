CREATE TABLE [dbo].[doc_site_fav_pharms] (
   [dfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_site_fav_pharms] PRIMARY KEY CLUSTERED ([dfp_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[doc_site_fav_pharms] ([dr_id], [pharm_id])

GO
