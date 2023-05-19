CREATE TABLE [dbo].[PARTNER_ACCOUNTS] (
   [PARTNER_ID] [int] NOT NULL
      IDENTITY (1,1),
   [PARTNER_NAME] [varchar](50) NOT NULL,
   [PARTNER_USERNAME] [varchar](20) NOT NULL,
   [PARTNER_PASSWORD] [varchar](100) NULL,
   [SALT] [varchar](20) NOT NULL,
   [ENABLED] [bit] NOT NULL,
   [admin_company_id] [int] NOT NULL,
   [isSingleSignOn] [bit] NULL

   ,CONSTRAINT [PK_PARTNER_ACCOUNTS] PRIMARY KEY CLUSTERED ([PARTNER_ID])
)


GO
