CREATE TABLE [fdb_b].[ROBCNDC0] (
   [NDC] [varchar](11) NOT NULL,
   [OBC3] [varchar](3) NOT NULL,
   [GCN] [numeric](5,0) NOT NULL,
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [GTI] [varchar](1) NOT NULL

   ,CONSTRAINT [ROBCNDC0_PK] PRIMARY KEY CLUSTERED ([NDC])
)


GO
