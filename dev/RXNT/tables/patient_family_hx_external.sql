CREATE TABLE [dbo].[patient_family_hx_external] (
   [pfhe_fhxid] [bigint] NOT NULL
      IDENTITY (1,1),
   [pfhe_pat_id] [bigint] NOT NULL,
   [pfhe_member_relation_id] [int] NULL,
   [pfhe_problem] [varchar](max) NULL,
   [pfhe_icd9] [varchar](50) NULL,
   [pfhe_dr_id] [bigint] NULL,
   [pfhe_added_by_dr_id] [bigint] NULL,
   [pfhe_created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [pfhe_comments] [varchar](max) NULL,
   [pfhe_enable] [bit] NOT NULL,
   [pfhe_active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pfhe_icd10] [varchar](max) NULL,
   [pfhe_icd9_description] [varchar](max) NULL,
   [pfhe_icd10_description] [varchar](max) NULL,
   [pfhe_snomed] [varchar](max) NULL,
   [pfhe_snomed_description] [varchar](max) NULL

   ,CONSTRAINT [PK_patient_family_hx_external] PRIMARY KEY CLUSTERED ([pfhe_fhxid])
)


GO
