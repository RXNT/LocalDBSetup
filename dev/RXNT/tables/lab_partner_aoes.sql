CREATE TABLE [dbo].[lab_partner_aoes] (
   [lab_partner_aoes_id] [int] NOT NULL
      IDENTITY (1,1),
   [external_lab_id] [varchar](100) NOT NULL,
   [partner_aoe_id] [varchar](100) NOT NULL,
   [partner_aoe_type] [varchar](100) NOT NULL,
   [partner_aoe_label] [varchar](1000) NOT NULL,
   [partner_aoe_menu] [varchar](4000) NOT NULL,
   [partner_aoe_radios] [varchar](4000) NOT NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NOT NULL,
   [last_modified_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL

   ,CONSTRAINT [PK_lab_partner_aoes] PRIMARY KEY CLUSTERED ([lab_partner_aoes_id])
)


GO
