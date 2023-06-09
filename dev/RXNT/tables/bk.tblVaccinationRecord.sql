CREATE TABLE [bk].[tblVaccinationRecord] (
   [vac_rec_id] [bigint] NOT NULL,
   [vac_id] [int] NOT NULL,
   [vac_pat_id] [int] NOT NULL,
   [vac_dt_admin] [datetime] NOT NULL,
   [vac_lot_no] [nvarchar](50) NOT NULL,
   [vac_site] [nvarchar](100) NOT NULL,
   [vac_dose] [nvarchar](225) NOT NULL,
   [vac_exp_date] [datetime] NOT NULL,
   [vac_dr_id] [int] NOT NULL,
   [vac_reaction] [nvarchar](512) NULL,
   [vac_remarks] [nvarchar](512) NULL,
   [vac_name] [varchar](150) NULL,
   [vis_date] [smalldatetime] NULL,
   [vis_given_date] [smalldatetime] NULL,
   [record_modified_date] [datetime] NULL,
   [vac_site_code] [varchar](10) NULL,
   [vac_dose_unit_code] [varchar](20) NULL,
   [vac_administered_code] [varchar](2) NULL,
   [vac_administered_by] [bigint] NULL,
   [vac_entered_by] [bigint] NULL,
   [substance_refusal_reason_code] [varchar](2) NULL,
   [disease_code] [varchar](10) NULL,
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL,
   [VFC_Eligibility_Status] [varchar](10) NULL,
   [vfc_code] [varchar](10) NULL
)


GO
