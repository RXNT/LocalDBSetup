CREATE TABLE [fdb_b].[RAPPLSL0] (
   [NDC] [varchar](11) NOT NULL,
   [NDA_IND] [numeric](1,0) NOT NULL,
   [ANDA_IND] [numeric](1,0) NOT NULL,
   [LISTING_SEQ_NO] [numeric](7,0) NOT NULL,
   [TRADENAME] [varchar](125) NOT NULL

   ,CONSTRAINT [RAPPLSL0_PK] PRIMARY KEY CLUSTERED ([NDC])
)


GO
