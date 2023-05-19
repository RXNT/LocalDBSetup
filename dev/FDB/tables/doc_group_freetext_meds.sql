CREATE TABLE [dbo].[doc_group_freetext_meds] (
   [dgfm_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [drug_name] [varchar](200) NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [is_active] [bit] NOT NULL,
   [drug_category] [smallint] NOT NULL

   ,CONSTRAINT [PK_doc_group_freetext_meds] PRIMARY KEY CLUSTERED ([dgfm_id])
)


GO
