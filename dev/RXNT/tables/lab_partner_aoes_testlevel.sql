CREATE TABLE [dbo].[lab_partner_aoes_testlevel] (
   [lab_partner_aoes_testlevel_id] [int] NOT NULL
      IDENTITY (1,1),
   [lab_partner_aoes_id] [int] NOT NULL,
   [external_lab_id] [varchar](100) NOT NULL,
   [partner_aoe_id] [varchar](100) NOT NULL,
   [partner_test_id] [varchar](100) NOT NULL,
   [active] [bit] NOT NULL,
   [last_modified_by] [int] NOT NULL,
   [last_modified_date] [datetime] NOT NULL,
   [created_date] [datetime] NOT NULL,
   [created_by] [int] NOT NULL

   ,CONSTRAINT [PK_lab_partner_aoes_testlevel] PRIMARY KEY CLUSTERED ([lab_partner_aoes_testlevel_id])
)


GO
