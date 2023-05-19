CREATE TABLE [fdb_a].[RMTLSYN0] (
   [MTL_LAB_ID_SYNID] [numeric](8,0) NOT NULL,
   [LAB_ID] [numeric](8,0) NOT NULL,
   [MTL_LAB_ID_SYN_NMTYP_CODE] [varchar](2) NOT NULL,
   [MTL_LAB_ID_SYN_CODE_DESC] [varchar](100) NULL,
   [MTL_LAB_ID_SYN_STATUS] [varchar](1) NULL

   ,CONSTRAINT [RMTLSYN0_PK] PRIMARY KEY CLUSTERED ([MTL_LAB_ID_SYNID])
)


GO
