CREATE TABLE [fdb_b].[RETCHCL0] (
   [HICL_SEQNO] [numeric](6,0) NOT NULL,
   [ETC_ID] [numeric](8,0) NOT NULL

   ,CONSTRAINT [RETCHCL0_PK] PRIMARY KEY CLUSTERED ([HICL_SEQNO], [ETC_ID])
)

CREATE NONCLUSTERED INDEX [RETCHCL0_NX1] ON [fdb_b].[RETCHCL0] ([ETC_ID])

GO
