CREATE TABLE [dbo].[pharmacy_partner_config] (
   [pharm_participant] [int] NOT NULL,
   [version] [varchar](50) NOT NULL,
   [erx_url] [varchar](100) NULL,
   [erx_login] [varchar](50) NULL,
   [erx_password] [varchar](50) NULL,
   [admin_url] [varchar](100) NULL,
   [admin_login] [varchar](50) NULL,
   [admin_password] [varchar](50) NULL,
   [admin_portal_id] [varchar](50) NULL,
   [admin_account_id] [varchar](50) NULL,
   [pharmacy_download_url] [varchar](100) NULL,
   [pharmacy_download_login] [varchar](50) NULL,
   [pharmacy_download_password] [varchar](50) NULL,
   [data_provider_id] [varchar](50) NULL

   ,CONSTRAINT [PK_pharmacy_partner_config] PRIMARY KEY CLUSTERED ([pharm_participant], [version])
)


GO
