CREATE TABLE [bk].[patient_immunization_registry_settings] (
   [pa_id] [bigint] NOT NULL,
   [publicity_code] [varchar](2) NULL,
   [publicity_code_effective_date] [datetime] NULL,
   [registry_status] [varchar](2) NULL,
   [registry_status_effective_date] [datetime] NULL,
   [entered_by] [bigint] NULL,
   [dr_id] [bigint] NULL,
   [entered_on] [datetime] NULL,
   [modified_on] [datetime] NULL,
   [protection_indicator] [varchar](1) NULL,
   [protection_indicator_effective_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
