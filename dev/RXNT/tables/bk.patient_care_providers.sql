CREATE TABLE [bk].[patient_care_providers] (
   [id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [prv_fav_id] [int] NOT NULL,
   [enable] [bit] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
