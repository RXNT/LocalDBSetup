CREATE TABLE [dbo].[patient_hospitalization_hx_external] (
   [phe_hosphxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [phe_pat_id] [bigint] NOT NULL,
   [phe_problem] [varchar](max) NULL,
   [phe_icd9] [varchar](50) NULL,
   [phe_dr_id] [bigint] NULL,
   [phe_added_by_dr_id] [bigint] NULL,
   [phe_created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [phe_comments] [varchar](max) NULL,
   [phe_enable] [bit] NOT NULL,
   [phe_icd9_description] [varchar](max) NULL,
   [phe_icd10] [varchar](max) NULL,
   [phe_icd10_description] [varchar](max) NULL,
   [phe_snomed] [varchar](max) NULL,
   [phe_snomed_description] [varchar](max) NULL,
   [phe_source] [varchar](100) NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK_patient_hospitalization_hx_external] PRIMARY KEY CLUSTERED ([phe_hosphxid])
)


GO
