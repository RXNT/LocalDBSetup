CREATE TABLE [dbo].[RBDPGC0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [PS] [numeric](11,3) NOT NULL,
   [BDP_DATEC] [datetime] NOT NULL,
   [BDP_PRICE] [numeric](9,5) NULL

   ,CONSTRAINT [RBDPGC0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [PS], [BDP_DATEC])
)


GO
