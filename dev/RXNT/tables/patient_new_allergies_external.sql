CREATE TABLE [dbo].[patient_new_allergies_external] (
   [pae_pa_allergy_id] [int] NOT NULL
      IDENTITY (1,1),
   [pae_pa_id] [int] NOT NULL,
   [pae_source_name] [varchar](200) NOT NULL,
   [pae_allergy_id] [int] NULL,
   [pae_allergy_description] [varchar](500) NULL,
   [pae_allergy_type] [smallint] NULL,
   [pae_add_date] [datetime] NOT NULL,
   [pae_comments] [varchar](2000) NULL,
   [pae_reaction_string] [varchar](225) NULL,
   [pae_status] [tinyint] NULL,
   [pae_dr_modified_user] [int] NULL,
   [pae_disable_date] [datetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [rxnorm_code] [varchar](100) NULL,
   [severity_id] [bigint] NULL,
   [is_from_ccd] [bit] NULL

   ,CONSTRAINT [PK_patient_new_allergies_external] PRIMARY KEY CLUSTERED ([pae_pa_allergy_id])
)


GO
