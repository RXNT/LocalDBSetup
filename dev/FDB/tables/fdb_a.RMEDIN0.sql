CREATE TABLE [fdb_a].[RMEDIN0] (
   [MEDID] [numeric](8,0) NOT NULL,
   [HIC_SEQN] [numeric](6,0) NOT NULL,
   [INACTV_NOT_PRES_CNT] [numeric](6,0) NULL,
   [INACTV_PRES_CNT] [numeric](6,0) NULL

   ,CONSTRAINT [RMEDIN0_PK] PRIMARY KEY CLUSTERED ([MEDID], [HIC_SEQN])
)


GO
