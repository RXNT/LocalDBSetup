CREATE TABLE [dbo].[patient_new_allergies] (
   [pa_allergy_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NULL,
   [allergy_type] [smallint] NOT NULL,
   [add_date] [datetime] NOT NULL,
   [comments] [varchar](2000) NULL,
   [reaction_string] [varchar](225) NULL,
   [status] [tinyint] NULL,
   [dr_modified_user] [int] NULL,
   [disable_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [allergy_description] [varchar](500) NULL,
   [record_source] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [severity_id] [bigint] NULL,
   [rxnorm_code] [varchar](200) NULL,
   [reaction_snomed] [varchar](15) NULL,
   [allergy_snomed] [varchar](100) NULL,
   [dr_id] [bigint] NULL,
   [snomed_term] [varchar](500) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_new_allergies] PRIMARY KEY CLUSTERED ([pa_allergy_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[patient_new_allergies] ([pa_id], [allergy_id], [allergy_type])

GO
