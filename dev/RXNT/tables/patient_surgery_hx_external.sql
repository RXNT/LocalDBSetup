CREATE TABLE [dbo].[patient_surgery_hx_external] (
   [pse_surghxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pse_pat_id] [bigint] NOT NULL,
   [pse_problem] [varchar](max) NULL,
   [pse_icd9] [varchar](50) NULL,
   [pse_dr_id] [bigint] NULL,
   [pse_added_by_dr_id] [bigint] NULL,
   [pse_created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [pse_comments] [varchar](max) NULL,
   [pse_enable] [bit] NOT NULL,
   [pse_icd9_description] [varchar](max) NULL,
   [pse_icd10] [varchar](max) NULL,
   [pse_icd10_description] [varchar](max) NULL,
   [pse_snomed] [varchar](max) NULL,
   [pse_snomed_description] [varchar](max) NULL,
   [pse_source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_surgery_hx_external] PRIMARY KEY CLUSTERED ([pse_surghxid])
)


GO
