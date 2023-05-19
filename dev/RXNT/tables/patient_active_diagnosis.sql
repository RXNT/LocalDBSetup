CREATE TABLE [dbo].[patient_active_diagnosis] (
   [pad] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [icd9] [varchar](100) NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [icd9_description] [varchar](255) NULL,
   [enabled] [tinyint] NOT NULL,
   [onset] [datetime] NULL,
   [severity] [varchar](50) NULL,
   [status] [varchar](10) NULL,
   [type] [smallint] NULL,
   [record_modified_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [record_source] [varchar](500) NULL,
   [status_date] [datetime] NULL,
   [code_type] [varchar](50) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [icd9_desc] [varchar](255) NULL,
   [icd10_desc] [varchar](255) NULL,
   [icd10] [varchar](100) NULL,
   [snomed_code] [varchar](100) NULL,
   [snomed_desc] [varchar](255) NULL,
   [diagnosis_sequence] [int] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_active_diagnosis] PRIMARY KEY CLUSTERED ([pad], [pa_id])
)

CREATE NONCLUSTERED INDEX [idx_PatientActiveDiagnosis_AddedBy_DateAdded] ON [dbo].[patient_active_diagnosis] ([added_by_dr_id], [date_added]) INCLUDE ([icd10], [icd9], [pa_id], [pad], [snomed_code])
CREATE NONCLUSTERED INDEX [IX_patient_active_diagnosis_icd9] ON [dbo].[patient_active_diagnosis] ([pa_id], [icd9])
CREATE NONCLUSTERED INDEX [IX_patient_active_diagnosis-icd9_description-enabled] ON [dbo].[patient_active_diagnosis] ([icd9_description], [enabled]) INCLUDE ([pa_id])

GO
