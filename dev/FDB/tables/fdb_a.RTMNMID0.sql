CREATE TABLE [fdb_a].[RTMNMID0] (
   [MED_NAME_ID] [numeric](8,0) NOT NULL,
   [TM_SOURCE_ID] [numeric](5,0) NULL,
   [TM_GROUP_ID] [numeric](5,0) NULL,
   [TM_IND] [numeric](1,0) NULL,
   [TM_ALT_MED_NAME_DESC] [varchar](70) NULL

   ,CONSTRAINT [RTMNMID0_PK] PRIMARY KEY CLUSTERED ([MED_NAME_ID])
)


GO
