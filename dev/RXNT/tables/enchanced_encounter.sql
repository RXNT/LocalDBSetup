CREATE TABLE [dbo].[enchanced_encounter] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](500) NULL,
   [type_of_visit] [char](10) NULL,
   [clinical_summary_first_date] [datetime] NULL,
   [active] [bit] NULL,
   [encounter_version] [varchar](10) NULL,
   [is_released] [bit] NULL,
   [external_encounter_id] [varchar](250) NULL,
   [is_amended] [bit] NULL,
   [enc_name] [nvarchar](1024) NULL,
   [is_multisignature] [bit] NOT NULL,
   [is_inreview] [bit] NOT NULL,
   [smart_form_id] [varchar](50) NULL,
   [InformationBlockingReasonId] [int] NULL,
   [EncounterNoteTypeId] [int] NULL,
   [EncounterReasonSnomedCode] [varchar](10) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_enchanced_encounter] PRIMARY KEY CLUSTERED ([enc_id])
)

CREATE NONCLUSTERED INDEX [IX_enchanced_encounter] ON [dbo].[enchanced_encounter] ([dr_id], [enc_date] DESC, [patient_id], [added_by_dr_id])
CREATE NONCLUSTERED INDEX [ix_enchanced_encounter_dr_id_issigned_includes] ON [dbo].[enchanced_encounter] ([dr_id], [issigned]) INCLUDE ([added_by_dr_id], [chief_complaint], [enc_date], [enc_id], [last_modified_by], [patient_id], [type])
CREATE NONCLUSTERED INDEX [IX_enchanced_encounter-patient_id] ON [dbo].[enchanced_encounter] ([patient_id])

GO
