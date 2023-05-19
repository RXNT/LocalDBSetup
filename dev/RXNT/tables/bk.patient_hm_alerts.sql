CREATE TABLE [bk].[patient_hm_alerts] (
   [rule_prf_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [rule_id] [int] NOT NULL,
   [dt_performed] [smalldatetime] NULL,
   [dr_performed_by] [int] NULL,
   [notes] [varchar](max) NULL,
   [due_date] [datetime] NULL,
   [rxnt_status_id] [int] NULL,
   [date_added] [datetime] NULL,
   [last_edited_on] [datetime] NULL,
   [last_edited_by] [int] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
