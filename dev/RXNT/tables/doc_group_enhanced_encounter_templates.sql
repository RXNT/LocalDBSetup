CREATE TABLE [dbo].[doc_group_enhanced_encounter_templates] (
   [enc_tmpl_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NOT NULL,
   [added_by_dr_id] [bigint] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [enc_name] [varchar](75) NOT NULL,
   [enc_json] [nvarchar](max) NULL,
   [import_ref_id] [bigint] NULL,
   [import_date] [datetime] NULL

   ,CONSTRAINT [PK_doc_group_enhanced_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
