CREATE TABLE [bk].[patient_active_diagnosis_external] (
   [pde_id] [int] NOT NULL,
   [pde_pa_id] [int] NOT NULL,
   [pde_source_name] [varchar](200) NOT NULL,
   [pde_icd9] [varchar](100) NOT NULL,
   [pde_added_by_dr_id] [int] NULL,
   [pde_date_added] [datetime] NOT NULL,
   [pde_icd9_description] [varchar](200) NOT NULL,
   [pde_enabled] [tinyint] NOT NULL,
   [pde_onset] [datetime] NULL,
   [pde_severity] [varchar](50) NULL,
   [pde_status] [varchar](10) NULL,
   [pde_type] [smallint] NULL,
   [pde_record_modified_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [is_from_ccd] [bit] NULL
)


GO
