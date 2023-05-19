CREATE TABLE [bk].[interaction_warning_log] (
   [int_warn_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [response] [tinyint] NOT NULL,
   [date] [smalldatetime] NOT NULL,
   [warning_source] [smallint] NULL,
   [reason] [varchar](255) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
