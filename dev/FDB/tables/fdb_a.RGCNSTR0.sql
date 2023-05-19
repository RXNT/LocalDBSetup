CREATE TABLE [fdb_a].[RGCNSTR0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [HIC_SEQN] [numeric](6,0) NOT NULL,
   [STRENGTH_STATUS_CODE] [numeric](1,0) NULL,
   [STRENGTH] [numeric](19,6) NULL,
   [STRENGTH_UOM_ID] [numeric](8,0) NULL,
   [STRENGTH_TYP_CODE] [numeric](1,0) NULL,
   [VOLUME] [numeric](19,6) NULL,
   [VOLUME_UOM_ID] [numeric](8,0) NULL,
   [ALT_STRENGTH] [numeric](19,6) NULL,
   [ALT_STRENGTH_UOM_ID] [numeric](8,0) NULL,
   [ALT_STRENGTH_TYP_CODE] [numeric](1,0) NULL,
   [TIME_VALUE] [numeric](6,3) NULL,
   [TIME_UOM_ID] [numeric](8,0) NULL,
   [RANGE_MAX] [numeric](19,6) NULL,
   [RANGE_MIN] [numeric](19,6) NULL

   ,CONSTRAINT [RGCNSTR0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [HIC_SEQN])
)


GO
