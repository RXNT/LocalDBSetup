CREATE TABLE [fdb_a].[RATCGC0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [ATC] [varchar](7) NOT NULL,
   [ATC_VER] [numeric](6,0) NULL

   ,CONSTRAINT [RATCGC0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [ATC])
)

CREATE NONCLUSTERED INDEX [RATCGC0_NX1] ON [fdb_a].[RATCGC0] ([ATC])

GO
