CREATE TABLE [bk].[patient_procedures] (
   [procedure_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [date_performed] [smalldatetime] NULL,
   [type] [varchar](50) NULL,
   [status] [varchar](50) NULL,
   [code] [varchar](50) NULL,
   [description] [varchar](250) NULL,
   [notes] [varchar](255) NULL,
   [record_modified_date] [datetime] NULL,
   [date_performed_to] [smalldatetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
