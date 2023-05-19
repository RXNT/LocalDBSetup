CREATE TABLE [dbo].[patient_medical_hx_external] (
   [pme_medhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pme_pat_id] [bigint] NOT NULL,
   [pme_problem] [varchar](max) NULL,
   [pme_icd9] [varchar](50) NULL,
   [pme_dr_id] [bigint] NULL,
   [pme_added_by_dr_id] [bigint] NULL,
   [pme_created_on] [datetime] NULL,
   [pme_last_modified_on] [datetime] NULL,
   [pme_last_modified_by] [bigint] NULL,
   [pme_comments] [varchar](max) NULL,
   [pme_enable] [bit] NOT NULL,
   [pme_active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pme_icd9_description] [varchar](max) NULL,
   [pme_icd10] [varchar](max) NULL,
   [pme_icd10_description] [varchar](max) NULL,
   [pme_snomed] [varchar](max) NULL,
   [pme_snomed_description] [varchar](max) NULL,
   [pme_source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_medical_hx_external] PRIMARY KEY CLUSTERED ([pme_medhxid])
)


GO
