CREATE TABLE [dbo].[doc_fav_patients] (
   [dfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_patients] PRIMARY KEY NONCLUSTERED ([dfp_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [DrPat_NoDups] ON [dbo].[doc_fav_patients] ([dr_id], [pa_id])

GO
