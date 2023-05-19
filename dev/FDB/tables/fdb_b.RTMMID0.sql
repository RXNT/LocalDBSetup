CREATE TABLE [fdb_b].[RTMMID0] (
   [MEDID] [numeric](8,0) NOT NULL,
   [TM_SOURCE_ID] [numeric](5,0) NULL,
   [TM_GROUP_ID] [numeric](5,0) NULL,
   [TM_IND] [numeric](1,0) NULL,
   [TM_ALT_MEDID_DESC] [varchar](70) NULL

   ,CONSTRAINT [RTMMID0_PK] PRIMARY KEY CLUSTERED ([MEDID])
)


GO
