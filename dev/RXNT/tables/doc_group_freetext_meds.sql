CREATE TABLE [dbo].[doc_group_freetext_meds] (
   [dgfm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [drug_name] [varchar](200) NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [is_active] [bit] NOT NULL,
   [drug_category] [smallint] NOT NULL,
   [preferred_name] [bit] NULL

   ,CONSTRAINT [PK_doc_group_freetext_meds] PRIMARY KEY CLUSTERED ([dgfm_id])
)

CREATE NONCLUSTERED INDEX [ix_doc_group_freetext_meds_dg_id_drug_id_includes] ON [dbo].[doc_group_freetext_meds] ([dg_id], [drug_id]) INCLUDE ([drug_category])
CREATE NONCLUSTERED INDEX [ix_doc_group_freetext_meds_drug_id] ON [dbo].[doc_group_freetext_meds] ([drug_id])

GO
