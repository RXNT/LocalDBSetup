CREATE TABLE [fdb_a].[RMEDNIN0] (
   [MED_NAME_ID] [numeric](8,0) NOT NULL,
   [HIC_SEQN] [numeric](6,0) NOT NULL,
   [INACTV_NOT_PRES_CNT] [numeric](6,0) NULL,
   [INACTV_PRES_CNT] [numeric](6,0) NULL

   ,CONSTRAINT [RMEDNIN0_PK] PRIMARY KEY CLUSTERED ([MED_NAME_ID], [HIC_SEQN])
)


GO
