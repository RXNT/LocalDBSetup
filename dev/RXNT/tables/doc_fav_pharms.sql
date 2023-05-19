CREATE TABLE [dbo].[doc_fav_pharms] (
   [fp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [update_code] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_pharms] PRIMARY KEY NONCLUSTERED ([fp_id])
)

CREATE CLUSTERED INDEX [doc_fav_pharms1] ON [dbo].[doc_fav_pharms] ([pharm_id])
CREATE NONCLUSTERED INDEX [doc_fav_pharms5] ON [dbo].[doc_fav_pharms] ([pharm_id], [dr_id], [update_code])
CREATE UNIQUE NONCLUSTERED INDEX [DrPh_NoDups] ON [dbo].[doc_fav_pharms] ([dr_id], [pharm_id])

GO
