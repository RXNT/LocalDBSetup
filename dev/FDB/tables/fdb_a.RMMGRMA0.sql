CREATE TABLE [fdb_a].[RMMGRMA0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [MMGR_MND] [numeric](9,3) NULL,
   [MMGR_MNDU] [varchar](3) NULL,
   [MMGR_MNU] [numeric](7,3) NULL,
   [MMGR_MNUF] [varchar](2) NULL,
   [MMGR_MXD] [numeric](9,3) NULL,
   [MMGR_MXDU] [varchar](3) NULL,
   [MMGR_MXU] [numeric](7,3) NULL,
   [MMGR_MXUF] [varchar](2) NULL

   ,CONSTRAINT [RMMGRMA0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO])
)


GO
