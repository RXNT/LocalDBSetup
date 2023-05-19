CREATE TABLE [fdb_a].[RDFIMGC0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [FDCDE] [numeric](3,0) NOT NULL

   ,CONSTRAINT [RDFIMGC0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [FDCDE])
)

CREATE NONCLUSTERED INDEX [RDFIMGC0_NX1] ON [fdb_a].[RDFIMGC0] ([FDCDE])

GO
