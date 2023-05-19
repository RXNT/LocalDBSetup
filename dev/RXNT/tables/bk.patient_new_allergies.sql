CREATE TABLE [bk].[patient_new_allergies] (
   [pa_allergy_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NULL,
   [allergy_type] [smallint] NULL,
   [add_date] [datetime] NOT NULL,
   [comments] [varchar](2000) NULL,
   [reaction_string] [varchar](225) NULL,
   [status] [tinyint] NULL,
   [dr_modified_user] [int] NULL,
   [disable_date] [datetime] NULL,
   [source_type] [varchar](3) NULL,
   [allergy_description] [varchar](500) NULL,
   [record_source] [varchar](500) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
