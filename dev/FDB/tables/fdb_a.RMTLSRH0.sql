CREATE TABLE [fdb_a].[RMTLSRH0] (
   [MTL_PREV_SPEC_LAB_ID] [numeric](8,0) NOT NULL,
   [MTL_REPL_SPEC_LAB_ID] [numeric](8,0) NOT NULL,
   [MTL_SPEC_LAB_ID_REPL_EFF_DT] [datetime] NULL

   ,CONSTRAINT [RMTLSRH0_PK] PRIMARY KEY CLUSTERED ([MTL_PREV_SPEC_LAB_ID], [MTL_REPL_SPEC_LAB_ID])
)


GO