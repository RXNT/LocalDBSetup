CREATE TABLE [dbo].[doc_companies] (
   [dc_id] [int] NOT NULL
      IDENTITY (1,1),
   [dc_name] [varchar](80) NULL,
   [partner_id] [int] NOT NULL,
   [protocol_enabled] [bit] NULL,
   [SHOW_EMAIL] [smallint] NULL,
   [dc_host_id] [int] NOT NULL,
   [admin_company_id] [int] NOT NULL,
   [emr_modules] [int] NOT NULL,
   [dc_settings] [smallint] NOT NULL,
   [is_custom_tester] [bit] NULL,
   [dc_tin] [varchar](50) NULL,
   [EnableRulesEngine] [bit] NULL,
   [EnableV2EncounterTemplate] [bit] NOT NULL,
   [no_formulary] [bit] NULL,
   [EnableExternalVitals] [bit] NULL,
   [IsPatientInformationBlockingEnabled] [bit] NULL,
   [IsBannerAdsDisabled] [bit] NULL,
   [ModifiedDate] [datetime2] NULL

   ,CONSTRAINT [PK_doc_companies] PRIMARY KEY CLUSTERED ([dc_id])
)


GO
