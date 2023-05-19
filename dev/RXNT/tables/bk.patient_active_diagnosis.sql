CREATE TABLE [bk].[patient_active_diagnosis] (
   [pad] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [icd9] [varchar](100) NOT NULL,
   [added_by_dr_id] [int] NULL,
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
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [icd9_desc] [varchar](255) NULL,
   [icd10_desc] [varchar](255) NULL,
   [icd10] [varchar](100) NULL,
   [snomed_code] [varchar](100) NULL,
   [snomed_desc] [varchar](255) NULL,
   [diagnosis_sequence] [int] NULL
)


GO
