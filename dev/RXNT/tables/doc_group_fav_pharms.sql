CREATE TABLE [dbo].[doc_group_fav_pharms] (
   [dgfp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL,
   [added_by_dr_id] [bigint] NULL,
   [added_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_pharms] PRIMARY KEY CLUSTERED ([dgfp_id])
)


GO
