CREATE TABLE [bk].[patient_documents] (
   [document_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [description] [varchar](225) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [cat_id] [smallint] NOT NULL,
   [owner_id] [bigint] NULL,
   [owner_type] [varchar](3) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
