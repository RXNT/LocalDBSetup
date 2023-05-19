CREATE TABLE [bk].[patient_family_hx] (
   [fhxid] [bigint] NOT NULL,
   [pat_id] [bigint] NOT NULL,
   [member_relation_id] [int] NULL,
   [problem] [varchar](max) NULL,
   [icd9] [varchar](50) NULL,
   [dr_id] [bigint] NULL,
   [added_by_dr_id] [bigint] NULL,
   [created_on] [datetime] NULL,
   [last_modified_on] [datetime] NULL,
   [last_modified_by] [bigint] NULL,
   [comments] [varchar](max) NULL,
   [enable] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [icd10] [varchar](max) NULL,
   [icd9_description] [varchar](max) NULL,
   [icd10_description] [varchar](max) NULL,
   [snomed] [varchar](max) NULL,
   [snomed_description] [varchar](max) NULL
)


GO
