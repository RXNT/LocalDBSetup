CREATE TABLE [bk].[enchanced_encounter] (
   [enc_id] [int] NOT NULL,
   [patient_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [enc_date] [datetime] NOT NULL,
   [enc_text] [ntext] NOT NULL,
   [chief_complaint] [nvarchar](1024) NOT NULL,
   [type] [varchar](1024) NOT NULL,
   [issigned] [bit] NOT NULL,
   [dtsigned] [datetime] NULL,
   [case_id] [int] NULL,
   [loc_id] [int] NULL,
   [last_modified_date] [datetime] NOT NULL,
   [last_modified_by] [int] NULL,
   [datasets_selection] [varchar](500) NULL,
   [type_of_visit] [char](10) NULL,
   [clinical_summary_first_date] [datetime] NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [encounter_version] [varchar](10) NULL
)


GO
