CREATE TABLE [dbo].[patient_encounter_template] (
   [template_id] [int] NOT NULL
      IDENTITY (1,1),
   [dr_id] [int] NOT NULL,
   [enc_reason] [varchar](30) NOT NULL,
   [chief_complaint] [varchar](2000) NOT NULL,
   [template_name] [varchar](100) NOT NULL,
   [last_update_dr_id] [int] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [doc_grp_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_encounter_template] PRIMARY KEY CLUSTERED ([template_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_encounter_template] ON [dbo].[patient_encounter_template] ([dr_id])
CREATE NONCLUSTERED INDEX [IX_patient_encounter_template_1] ON [dbo].[patient_encounter_template] ([doc_grp_id])

GO
