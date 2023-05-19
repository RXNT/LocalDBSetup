CREATE TABLE [dbo].[REVDMVX0_EXT_VOCAB_MVX_DESC] (
   [EVD_MVX_CD] [varchar](10) NOT NULL,
   [EVD_MVX_CD_DESC] [varchar](100) NOT NULL,
   [EVD_MVX_CD_STATUS] [varchar](30) NULL,
   [EVD_MVX_LAST_UPDATE_DT] [datetime] NOT NULL

   ,CONSTRAINT [REVDMVX0_PK] PRIMARY KEY CLUSTERED ([EVD_MVX_CD])
)


GO