CREATE TABLE [bk].[patient_consent] (
   [consent_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
