CREATE TABLE [bk].[patient_notes] (
   [note_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [note_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [void] [bit] NOT NULL,
   [note_text] [varchar](5000) NULL,
   [partner_id] [tinyint] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [note_html] [varchar](max) NULL
)


GO
