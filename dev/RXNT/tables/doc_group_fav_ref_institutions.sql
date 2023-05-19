CREATE TABLE [dbo].[doc_group_fav_ref_institutions] (
   [dgfri_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [inst_id] [int] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL,
   [added_by_dr_id] [bigint] NULL,
   [added_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_ref_institutions] PRIMARY KEY CLUSTERED ([dgfri_id])
)


GO
