CREATE TABLE [dbo].[pharmacies] (
   [pharm_id] [int] NOT NULL
      IDENTITY (1,1),
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

   ,CONSTRAINT [PK_pharmacies] PRIMARY KEY NONCLUSTERED ([pharm_id])
)

CREATE NONCLUSTERED INDEX [_dta_index_pharmacies_23_526729029__K1_K13_2_6_8_9_10_20] ON [dbo].[pharmacies] ([pharm_id], [pharm_fax]) INCLUDE ([pharm_company_name], [pharm_address1], [pharm_city], [pharm_state], [pharm_zip], [ncpdp_numb])
CREATE NONCLUSTERED INDEX [_dta_index_pharmacies_7_934346443__K1_2_11_13] ON [dbo].[pharmacies] ([pharm_id]) INCLUDE ([pharm_company_name], [pharm_phone], [pharm_fax])
CREATE NONCLUSTERED INDEX [_dta_index_pharmacies_7_934346443__K1_K13_2_6_7_8_9_10_11] ON [dbo].[pharmacies] ([pharm_id], [pharm_fax]) INCLUDE ([pharm_address1], [pharm_address2], [pharm_city], [pharm_company_name], [pharm_phone], [pharm_state], [pharm_zip])
CREATE NONCLUSTERED INDEX [IX_pharmacies-pharm_enabled-pharm_pending_addition-pharm_company_name-pharm_zip-incld] ON [dbo].[pharmacies] ([pharm_enabled], [pharm_pending_addition], [pharm_company_name], [pharm_zip]) INCLUDE ([pharm_id], [pharm_address1], [pharm_address2], [pharm_city], [pharm_state], [pharm_phone], [pharm_fax], [pharm_participant], [ncpdp_numb])
CREATE NONCLUSTERED INDEX [IX_pharmacies-pharm_enabled-pharm_pending_addition-pharm_state-pharm_zip-incld] ON [dbo].[pharmacies] ([pharm_enabled], [pharm_pending_addition], [pharm_state], [pharm_zip]) INCLUDE ([pharm_id], [pharm_company_name], [pharm_address1], [pharm_address2], [pharm_city], [pharm_phone], [pharm_fax], [pharm_participant], [ncpdp_numb], [service_level])
CREATE CLUSTERED INDEX [pharmacies2] ON [dbo].[pharmacies] ([pharm_fax])
CREATE NONCLUSTERED INDEX [pharmacies3] ON [dbo].[pharmacies] ([pharm_id], [pharm_company_name], [pharm_address1], [pharm_city], [pharm_state], [pharm_zip], [pharm_phone])

GO
