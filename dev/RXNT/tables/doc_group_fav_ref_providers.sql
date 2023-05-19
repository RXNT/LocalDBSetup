CREATE TABLE [dbo].[doc_group_fav_ref_providers] (
   [dgfrp_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [target_dr_id] [int] NOT NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL,
   [added_by_dr_id] [bigint] NULL,
   [added_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_fav_ref_providers] PRIMARY KEY CLUSTERED ([dgfrp_id])
)


GO
