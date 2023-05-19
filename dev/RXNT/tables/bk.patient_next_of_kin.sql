CREATE TABLE [bk].[patient_next_of_kin] (
   [pa_id] [bigint] NULL,
   [kin_relation_code] [varchar](3) NULL,
   [kin_first] [varchar](35) NULL,
   [kin_middle] [varchar](35) NULL,
   [kin_last] [varchar](35) NULL,
   [kin_address1] [varchar](35) NULL,
   [kin_city] [varchar](35) NULL,
   [kin_state] [varchar](2) NULL,
   [kin_zip] [varchar](20) NULL,
   [kin_country] [varchar](10) NULL,
   [kin_phone] [varchar](20) NULL,
   [kin_email] [varchar](50) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
