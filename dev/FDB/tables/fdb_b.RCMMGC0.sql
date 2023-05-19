CREATE TABLE [fdb_b].[RCMMGC0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [CMMC] [numeric](4,0) NOT NULL,
   [CMMC_RN] [numeric](1,0) NULL

   ,CONSTRAINT [RCMMGC0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [CMMC])
)

CREATE NONCLUSTERED INDEX [RCMMGC0_NX1] ON [fdb_b].[RCMMGC0] ([CMMC])

GO
