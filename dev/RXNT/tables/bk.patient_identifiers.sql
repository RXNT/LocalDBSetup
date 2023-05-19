CREATE TABLE [bk].[patient_identifiers] (
   [pa_id] [bigint] NOT NULL,
   [pik_id] [bigint] NOT NULL,
   [value] [varchar](50) NULL,
   [created_date] [datetime] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
