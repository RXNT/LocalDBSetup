CREATE TABLE [dbo].[pharmacies_backup_31_2019] (
   [pharm_id] [int] NOT NULL,
   [pharm_company_name] [varchar](80) NOT NULL,
   [pharm_store_numb] [varchar](36) NOT NULL,
   [pharm_lic_numb] [varchar](50) NOT NULL,
   [pharm_dea_numb] [varchar](30) NOT NULL,
   [pharm_address1] [varchar](50) NOT NULL,
   [pharm_address2] [varchar](50) NOT NULL,
   [pharm_city] [varchar](50) NOT NULL,
   [pharm_state] [varchar](50) NOT NULL,
   [pharm_zip] [varchar](20) NOT NULL,
   [pharm_phone] [varchar](30) NOT NULL,
   [pharm_phone_reception] [varchar](30) NOT NULL,
   [pharm_fax] [varchar](30) NOT NULL,
   [pharm_email] [varchar](50) NOT NULL,
   [pharm_notify_fax] [bit] NOT NULL,
   [pharm_notify_email] [bit] NOT NULL,
   [pharm_enabled] [bit] NOT NULL,
   [pharm_create_date] [datetime] NOT NULL,
   [pharm_participant] [int] NOT NULL,
   [ncpdp_numb] [varchar](10) NOT NULL,
   [disp_type] [int] NULL,
   [enable_dummy_code] [bit] NOT NULL,
   [sfi_is_sfi] [bit] NULL,
   [sfi_pharmid] [varchar](50) NULL,
   [pharm_added_by_dr_id] [int] NOT NULL,
   [pharm_pending_addition] [bit] NOT NULL,
   [SS_VERSION] [int] NOT NULL,
   [service_level] [int] NULL,
   [pharm_fax_email] [varchar](50) NULL,
   [NPI] [varchar](20) NULL,
   [pharm_crossstreet] [varchar](35) NULL

   ,CONSTRAINT [PK_pharmacies_backup_31_2019] PRIMARY KEY NONCLUSTERED ([pharm_id])
)


GO
