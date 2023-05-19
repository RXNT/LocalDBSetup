CREATE TABLE [bk].[patient_active_meds_external] (
   [pame_id] [int] NOT NULL,
   [pame_pa_id] [int] NOT NULL,
   [pame_drug_id] [int] NOT NULL,
   [pame_date_added] [datetime] NOT NULL,
   [pame_compound] [bit] NOT NULL,
   [pame_comments] [varchar](255) NULL,
   [pame_status] [tinyint] NULL,
   [pame_drug_name] [varchar](200) NULL,
   [pame_dosage] [varchar](255) NULL,
   [pame_duration_amount] [varchar](15) NULL,
   [pame_duration_unit] [varchar](80) NULL,
   [pame_drug_comments] [varchar](255) NULL,
   [pame_numb_refills] [int] NULL,
   [pame_use_generic] [int] NULL,
   [pame_days_supply] [smallint] NULL,
   [pame_prn] [bit] NULL,
   [pame_prn_description] [varchar](50) NULL,
   [pame_date_start] [datetime] NULL,
   [pame_date_end] [datetime] NULL,
   [pame_source_name] [varchar](500) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [external_id] [varchar](100) NULL,
   [is_from_ccd] [bit] NULL
)


GO
