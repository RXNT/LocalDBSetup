CREATE TABLE [bk].[patient_profile] (
   [profile_id] [int] NOT NULL,
   [patient_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [entry_date] [datetime] NOT NULL,
   [last_update_date] [datetime] NOT NULL,
   [last_update_dr_id] [int] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
