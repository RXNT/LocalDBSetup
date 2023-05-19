CREATE TABLE [fdb_a].[RMEDRIN0] (
   [ROUTED_MED_ID] [numeric](8,0) NOT NULL,
   [HIC_SEQN] [numeric](6,0) NOT NULL,
   [INACTV_NOT_PRES_CNT] [numeric](6,0) NULL,
   [INACTV_PRES_CNT] [numeric](6,0) NULL

   ,CONSTRAINT [RMEDRIN0_PK] PRIMARY KEY CLUSTERED ([ROUTED_MED_ID], [HIC_SEQN])
)


GO
