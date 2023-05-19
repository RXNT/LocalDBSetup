CREATE TABLE [dbo].[REVDNCM0_NDC_CVX_MVX_LINK] (
   [NDC] [varchar](11) NOT NULL,
   [LBLRID] [varchar](6) NOT NULL,
   [MFG] [varchar](15) NOT NULL,
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [BN] [varchar](30) NOT NULL,
   [NDCFI] [varchar](1) NOT NULL,
   [OBSDTEC] [datetime] NULL,
   [REPACK] [varchar](1) NOT NULL,
   [LN60] [varchar](60) NOT NULL,
   [MEDID] [numeric](8,0) NOT NULL,
   [MED_MEDID_DESC] [varchar](70) NOT NULL,
   [GENERIC_MEDID] [numeric](8,0) NOT NULL,
   [GENERIC_MEDID_DESC] [varchar](70) NOT NULL,
   [EVD_CVX_CD] [varchar](10) NOT NULL,
   [EVD_CVX_CD_DESC_SHORT] [varchar](100) NOT NULL,
   [EVD_CVX_CD_DESC_LONG] [varchar](255) NOT NULL,
   [EVD_CVX_CD_USAGE] [numeric](2,0) NOT NULL,
   [EVD_CVX_CD_USAGE_DESC_SHORT] [varchar](100) NOT NULL,
   [EVD_CVX_CD_STATUS] [varchar](30) NULL,
   [EVD_MVX_CD] [varchar](10) NOT NULL,
   [EVD_MVX_CD_DESC] [varchar](100) NOT NULL,
   [EVD_MVX_CD_STATUS] [varchar](30) NULL

   ,CONSTRAINT [REVDNCM0_PK] PRIMARY KEY CLUSTERED ([NDC])
)


GO
