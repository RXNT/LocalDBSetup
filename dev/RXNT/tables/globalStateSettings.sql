CREATE TABLE [dbo].[globalStateSettings] (
   [SSID] [int] NOT NULL
      IDENTITY (1,1),
   [StateCode] [varchar](2) NULL,
   [SET_FullStateName] [varchar](50) NULL,
   [SET_TemplateReady] [varchar](10) NULL,
   [SET_PrescMaxDosageLen] [varchar](3) NULL,
   [SET_PrescMaxCommentsLen] [varchar](3) NULL,
   [SET_PrnPresPaperCopyVertPix] [varchar](4) NULL

   ,CONSTRAINT [PK_globalStateSettings] PRIMARY KEY CLUSTERED ([SSID])
)


GO
