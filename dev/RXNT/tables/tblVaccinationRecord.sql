CREATE TABLE [dbo].[tblVaccinationRecord] (
   [vac_rec_id] [bigint] NOT NULL
      IDENTITY (1,1),
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
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [VFC_Eligibility_Status] [varchar](10) NULL,
   [vfc_code] [varchar](10) NULL,
   [eligibility_category_code] [varchar](15) NULL,
   [route] [varchar](50) NULL,
   [route_code] [varchar](50) NULL,
   [vaccine_admin_status] [varchar](50) NULL,
   [action_code] [varchar](10) NULL,
   [vis_edition_date] [varchar](100) NULL,
   [external_vac_rec_id] [bigint] NULL,
   [visibility_hidden_to_patient] [bit] NULL

   ,CONSTRAINT [PK__tblVaccinationRe__503CB573] PRIMARY KEY CLUSTERED ([vac_rec_id])
)

CREATE NONCLUSTERED INDEX [IDX_tblVaccinationRecord_vac_pat_id] ON [dbo].[tblVaccinationRecord] ([vac_pat_id])
CREATE NONCLUSTERED INDEX [IX_tblVaccinationRecord] ON [dbo].[tblVaccinationRecord] ([vac_id], [vac_dr_id], [vac_pat_id], [vac_dt_admin])
CREATE UNIQUE NONCLUSTERED INDEX [UQ__tblVaccinationRecord__0000000000000041] ON [dbo].[tblVaccinationRecord] ([vac_rec_id])

GO
