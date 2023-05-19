CREATE TABLE [fdb_a].[RPEMOGC0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [PEMONO] [numeric](4,0) NOT NULL

   ,CONSTRAINT [RPEMOGC0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [PEMONO])
)

CREATE NONCLUSTERED INDEX [RPEMOGC0_NX1] ON [fdb_a].[RPEMOGC0] ([PEMONO])

GO