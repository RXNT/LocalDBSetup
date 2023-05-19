CREATE TABLE [dbo].[lab_partners] (
   [lab_partner_id] [int] NOT NULL,
   [partner_name] [varchar](100) NOT NULL,
   [partner_address] [varchar](100) NOT NULL,
   [partner_city] [varchar](50) NOT NULL,
   [partner_state] [varchar](2) NOT NULL,
   [partner_zip] [varchar](10) NOT NULL,
   [partner_phone] [varchar](20) NOT NULL,
   [partner_fax] [varchar](20) NOT NULL,
   [partner_participant] [bigint] NOT NULL,
   [partner_enabled] [bit] NOT NULL,
   [partner_sendapp_text] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_lab_partners] PRIMARY KEY CLUSTERED ([lab_partner_id])
)


GO
