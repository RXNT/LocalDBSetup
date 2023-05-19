CREATE TABLE [fdb_b].[RMMGDMA0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [MMG_MND] [numeric](9,3) NULL,
   [MMG_MNDU] [varchar](3) NULL,
   [MMG_MNU] [numeric](7,3) NULL,
   [MMG_MNUF] [varchar](2) NULL,
   [MMG_MXD] [numeric](9,3) NULL,
   [MMG_MXDU] [varchar](3) NULL,
   [MMG_MXU] [numeric](7,3) NULL,
   [MMG_MXUF] [varchar](2) NULL

   ,CONSTRAINT [RMMGDMA0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO])
)


GO
