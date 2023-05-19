CREATE TABLE [dbo].[enchanced_encounter_templates] (
   [enc_tmpl_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [enc_name] [varchar](75) NOT NULL,
   [enc_json] [nvarchar](max) NULL

   ,CONSTRAINT [PK_enchanced_encounter_templates] PRIMARY KEY CLUSTERED ([enc_tmpl_id])
)


GO
