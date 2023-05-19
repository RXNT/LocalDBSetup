CREATE TABLE [dbo].[patient_active_meds_external] (
   [pame_id] [int] NOT NULL
      IDENTITY (1,1),
   [pame_pa_id] [int] NOT NULL,
   [pame_drug_id] [int] NOT NULL,
   [pame_date_added] [datetime] NOT NULL,
   [pame_compound] [bit] NOT NULL,
   [pame_comments] [varchar](255) NULL,
   [pame_status] [tinyint] NULL,
   [pame_drug_name] [varchar](200) NULL,
   [pame_dosage] [varchar](255) NULL,
   [pame_duration_amount] [varchar](15) NULL,
   [pame_duration_unit] [varchar](80) NULL,
   [pame_drug_comments] [varchar](255) NULL,
   [pame_numb_refills] [int] NULL,
   [pame_use_generic] [int] NULL,
   [pame_days_supply] [smallint] NULL,
   [pame_prn] [bit] NULL,
   [pame_prn_description] [varchar](50) NULL,
   [pame_date_start] [datetime] NULL,
   [pame_date_end] [datetime] NULL,
   [pame_source_name] [varchar](500) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [external_id] [varchar](100) NULL,
   [rxnorm_code] [varchar](100) NULL,
   [is_from_ccd] [bit] NULL

   ,CONSTRAINT [PK_patient_active_meds_external] PRIMARY KEY CLUSTERED ([pame_id])
)

CREATE NONCLUSTERED INDEX [ix_patient_active_meds_external_pame_pa_id_pame_source_name_external_id] ON [dbo].[patient_active_meds_external] ([pame_pa_id], [pame_source_name], [external_id])

GO
