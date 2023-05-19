CREATE TABLE [dbo].[encounter_templates] (
   [enc_tmpl_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [enc_type_id] [int] NOT NULL,
   [enc_name] [varchar](75) NULL,
   [enc_text] [ntext] NULL,
   [enc_json] [varchar](max) NULL

   ,CONSTRAINT [PK_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
