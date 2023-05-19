CREATE TABLE [fdb_b].[RMTLPRH0] (
   [MTL_PREV_PANEL_ID] [numeric](5,0) NOT NULL,
   [MTL_REPL_PANEL_ID] [numeric](5,0) NOT NULL,
   [MTL_PANEL_ID_REPL_EFF_DT] [datetime] NULL

   ,CONSTRAINT [RMTLPRH0_PK] PRIMARY KEY CLUSTERED ([MTL_PREV_PANEL_ID], [MTL_REPL_PANEL_ID])
)


GO
