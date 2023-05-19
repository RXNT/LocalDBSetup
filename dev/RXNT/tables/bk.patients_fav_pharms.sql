CREATE TABLE [bk].[patients_fav_pharms] (
   [pa_id] [int] NOT NULL,
   [pharm_id] [int] NOT NULL,
   [pharm_use_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
