CREATE TABLE [dbo].[doc_fav_drugs] (
   [dfd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL

   ,CONSTRAINT [PK_doc_fav_drugs_v2] PRIMARY KEY NONCLUSTERED ([dfd_id])
)

CREATE UNIQUE CLUSTERED INDEX [unique_doc_fav_drugs] ON [dbo].[doc_fav_drugs] ([dr_id], [drug_id])

GO
