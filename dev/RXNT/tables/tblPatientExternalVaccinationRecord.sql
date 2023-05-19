CREATE TABLE [dbo].[tblPatientExternalVaccinationRecord] (
   [vac_rec_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [vac_id] [int] NOT NULL,
   [message_control_id] [varchar](100) NOT NULL,
   [vac_pat_id] [int] NOT NULL,
   [vac_dt_admin] [datetime] NULL,
   [vac_lot_no] [varchar](50) NULL,
   [vac_site] [varchar](100) NULL,
   [vac_dose] [varchar](225) NULL,
   [vac_exp_date] [datetime] NULL,
   [request_id] [int] NULL,
   [vac_reaction] [varchar](512) NULL,
   [vac_remarks] [varchar](512) NULL,
   [vac_name] [varchar](150) NULL,
   [vac_base_name] [varchar](150) NULL,
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
   [vfc_eligibility_status] [varchar](10) NULL,
   [vfc_code] [varchar](10) NULL,
   [eligibility_category_code] [varchar](15) NULL,
   [route] [varchar](50) NULL,
   [route_code] [varchar](50) NULL,
   [vaccine_admin_status] [varchar](50) NULL,
   [action_code] [varchar](10) NULL,
   [vis_edition_date] [varchar](100) NULL,
   [cvx_code] [varchar](10) NULL,
   [mvx_code] [varchar](10) NULL,
   [manufacturer_name] [varchar](100) NULL,
   [is_reconciled] [bit] NULL,
   [reconciled_by] [int] NULL,
   [reconciled_at] [datetime] NULL

   ,CONSTRAINT [PK__tblPatientExternalVaccinationRe__503CB573] PRIMARY KEY CLUSTERED ([vac_rec_id])
)

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20220228-150752] ON [dbo].[tblPatientExternalVaccinationRecord] ([message_control_id])

GO
