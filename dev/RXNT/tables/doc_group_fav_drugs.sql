CREATE TABLE [dbo].[doc_group_fav_drugs] (
   [dgfd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_drugs] PRIMARY KEY CLUSTERED ([dgfd_id])
)


GO
