CREATE TABLE [fdb_a].[RMMADMA1] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [MMA_MND] [numeric](9,3) NULL,
   [MMA_MNDU] [varchar](3) NULL,
   [MMA_MNU] [numeric](7,3) NULL,
   [MMA_MNUF] [varchar](2) NULL,
   [MMA_MXD] [numeric](9,3) NULL,
   [MMA_MXDU] [varchar](3) NULL,
   [MMA_MXU] [numeric](7,3) NULL,
   [MMA_MXUF] [varchar](2) NULL

   ,CONSTRAINT [RMMADMA1_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO])
)


GO
