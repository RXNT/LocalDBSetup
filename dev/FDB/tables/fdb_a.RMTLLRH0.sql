CREATE TABLE [fdb_a].[RMTLLRH0] (
   [MTL_PREV_LAB_ID] [numeric](8,0) NOT NULL,
   [MTL_REPL_LAB_ID] [numeric](8,0) NOT NULL,
   [MTL_LAB_ID_REPL_EFF_DT] [datetime] NULL

   ,CONSTRAINT [RMTLLRH0_PK] PRIMARY KEY CLUSTERED ([MTL_PREV_LAB_ID], [MTL_REPL_LAB_ID])
)


GO
