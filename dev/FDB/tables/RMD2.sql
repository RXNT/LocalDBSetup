CREATE TABLE [dbo].[RMD2] (
   [NDC] [varchar](11) NOT NULL,
   [MDT_ID] [varchar](2) NOT NULL,
   [MDT_BC] [varchar](11) NULL,
   [MDT_BCDTE] [datetime] NULL,
   [MDT_FI] [varchar](1) NULL,
   [MDT_FIDTE] [datetime] NULL,
   [MDT_GBC] [varchar](11) NULL,
   [MDT_GBCDTE] [datetime] NULL,
   [MDT_COV] [varchar](1) NULL,
   [MDT_PA] [varchar](1) NULL,
   [MDT_RFL] [varchar](1) NULL,
   [MDT_COP] [varchar](1) NULL,
   [MDT_BU] [varchar](2) NULL,
   [MDT_PS] [numeric](11,3) NULL,
   [MDT_QBU] [varchar](10) NULL,
   [MDT_MINC] [varchar](1) NULL,
   [MDT_MIN] [numeric](11,3) NULL,
   [MDT_MAXC] [varchar](1) NULL,
   [MDT_MAX] [numeric](11,3) NULL,
   [MDT_FEE] [varchar](1) NULL,
   [MDT_SLC10] [varchar](10) NULL,
   [MDT_LTC] [varchar](1) NULL,
   [MDT_FREQ] [varchar](1) NULL,
   [MDT_CODE1] [varchar](1) NULL,
   [MDT_SUB] [varchar](1) NULL

   ,CONSTRAINT [RMD2_PK] PRIMARY KEY CLUSTERED ([NDC], [MDT_ID])
)

CREATE NONCLUSTERED INDEX [RMD2_NX1] ON [dbo].[RMD2] ([MDT_ID])

GO
