CREATE TABLE [bk].[patient_phr_access_log] (
   [phr_access_log_id] [bigint] NOT NULL,
   [pa_id] [bigint] NOT NULL,
   [phr_access_type] [int] NOT NULL,
   [phr_access_description] [varchar](1024) NOT NULL,
   [phr_access_datetime] [datetime] NOT NULL,
   [phr_access_from_ip] [varchar](50) NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
