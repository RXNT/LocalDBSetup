CREATE TABLE [bk].[patient_flag_details] (
   [pa_flag_id] [bigint] NOT NULL,
   [pa_id] [int] NOT NULL,
   [flag_id] [int] NOT NULL,
   [flag_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
