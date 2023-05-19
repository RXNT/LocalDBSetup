CREATE TABLE [bk].[patient_visit] (
   [visit_id] [int] NOT NULL,
   [appt_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [dtCreate] [smalldatetime] NOT NULL,
   [dtEnd] [smalldatetime] NOT NULL,
   [enc_id] [int] NOT NULL,
   [chkout_notes] [varchar](max) NULL,
   [vital_id] [int] NULL,
   [reason] [varchar](255) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [clinical_notes] [varchar](max) NULL
)


GO
