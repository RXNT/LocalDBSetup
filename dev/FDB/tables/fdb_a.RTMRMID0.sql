CREATE TABLE [fdb_a].[RTMRMID0] (
   [ROUTED_MED_ID] [numeric](8,0) NOT NULL,
   [TM_SOURCE_ID] [numeric](5,0) NULL,
   [TM_GROUP_ID] [numeric](5,0) NULL,
   [TM_IND] [numeric](1,0) NULL,
   [TM_ALT_ROUTED_MED_ID_DESC] [varchar](70) NULL

   ,CONSTRAINT [RTMRMID0_PK] PRIMARY KEY CLUSTERED ([ROUTED_MED_ID])
)


GO