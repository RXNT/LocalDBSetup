CREATE TABLE [dbo].[RBLP0] (
   [GCN] [numeric](5,0) NOT NULL,
   [PS] [numeric](11,3) NOT NULL,
   [BLP_DATEC] [datetime] NOT NULL,
   [BLP_PRICE] [numeric](9,5) NULL

   ,CONSTRAINT [RBLP0_PK] PRIMARY KEY CLUSTERED ([GCN], [PS], [BLP_DATEC])
)


GO
