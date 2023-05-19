CREATE TABLE [dbo].[lab_result_details] (
   [lab_result_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_result_info_id] [int] NOT NULL,
   [value_type] [tinyint] NOT NULL,
   [obs_ident] [varchar](3000) NOT NULL,
   [obs_text] [varchar](1000) NOT NULL,
   [obs_cod_sys] [varchar](100) NOT NULL,
   [alt_obs_ident] [varchar](100) NULL,
   [alt_obs_text] [varchar](1000) NULL,
   [alt_cod_sys] [varchar](100) NULL,
   [obs_sub_id] [varchar](100) NULL,
   [obs_value] [varchar](max) NULL,
   [coding_unit_ident] [varchar](100) NULL,
   [coding_unit_text] [varchar](1000) NULL,
   [coding_unit_sys] [varchar](100) NULL,
   [ref_range] [varchar](500) NULL,
   [abnormal_flags] [smallint] NOT NULL,
   [obs_result_status] [smallint] NOT NULL,
   [dt_last_change] [datetime] NOT NULL,
   [obs_date_time] [datetime] NOT NULL,
   [prod_id] [varchar](500) NULL,
   [notes] [varchar](max) NULL,
   [has_embedded_data] [bit] NOT NULL,
   [org_name] [varchar](500) NULL,
   [org_id] [varchar](500) NULL,
   [org_addr1] [varchar](500) NULL,
   [org_city] [varchar](500) NULL,
   [org_state] [varchar](500) NULL,
   [org_zip] [varchar](500) NULL,
   [org_dr_first] [varchar](500) NULL,
   [org_dr_last] [varchar](500) NULL,
   [org_dr_mi] [varchar](500) NULL,
   [org_dr_title] [varchar](500) NULL,
   [file_name] [varchar](500) NULL,
   [file_uploaded_dt] [datetime] NULL,
   [file_uploaded_category_id] [int] NULL,
   [org_country] [varchar](20) NULL,
   [org_dr_prefix] [varchar](10) NULL,
   [org_dr_suffix] [varchar](10) NULL,
   [org_dr_id] [varchar](20) NULL,
   [org_dr_id_namespace_id] [varchar](35) NULL,
   [org_dr_id_uid] [varchar](20) NULL,
   [org_dr_id_uid_type] [varchar](20) NULL,
   [org_dr_type_code] [varchar](10) NULL,
   [org_type] [varchar](20) NULL

   ,CONSTRAINT [PK_lab_result_details] PRIMARY KEY CLUSTERED ([lab_result_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_lab_result_details_7_283252164__K2] ON [dbo].[lab_result_details] ([lab_result_info_id])

GO
