CREATE TABLE [dbo].[doc_group_encounter_templates] (
   [enc_tmpl_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [enc_type_id] [int] NOT NULL,
   [enc_name] [varchar](75) NULL,
   [enc_text] [ntext] NULL,
   [enc_json] [varchar](max) NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
