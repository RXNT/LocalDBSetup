CREATE TABLE [dbo].[lab_pat_details] (
   [lab_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [ext_pat_id] [varchar](1000) NULL,
   [lab_pat_id] [varchar](1000) NOT NULL,
   [alt_pat_id] [varchar](1000) NULL,
   [pa_first] [varchar](200) NOT NULL,
   [pa_last] [varchar](200) NOT NULL,
   [pa_middle] [varchar](200) NOT NULL,
   [pa_dob] [datetime] NOT NULL,
   [pa_sex] [varchar](3) NOT NULL,
   [pa_address1] [varchar](200) NOT NULL,
   [pa_city] [varchar](200) NOT NULL,
   [pa_state] [varchar](5) NOT NULL,
   [pa_zip] [varchar](200) NOT NULL,
   [pa_acctno] [varchar](200) NOT NULL,
   [spm_status] [varchar](200) NULL,
   [fasting] [varchar](200) NOT NULL,
   [notes] [varchar](max) NULL,
   [pa_suffix] [varchar](10) NULL,
   [pa_race] [varchar](35) NULL,
   [pa_alternate_race] [varchar](35) NULL,
   [lab_patid_namespace_id] [varchar](25) NULL,
   [lab_patid_type_code] [varchar](25) NULL,
   [lab_pat_id_uid] [varchar](20) NULL,
   [lab_pat_id_uid_type] [varchar](20) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_lab_pat_details] PRIMARY KEY CLUSTERED ([lab_id], [pat_id])
)


GO
