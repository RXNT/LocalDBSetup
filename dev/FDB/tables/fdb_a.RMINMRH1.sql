CREATE TABLE [fdb_a].[RMINMRH1] (
   [MED_REPL_NAME_ID] [numeric](8,0) NOT NULL,
   [MED_PREV_NAME_ID] [numeric](8,0) NOT NULL,
   [MED_NAME_ID_REPL_EFF_DT] [datetime] NOT NULL

   ,CONSTRAINT [RMINMRH1_PK] PRIMARY KEY CLUSTERED ([MED_REPL_NAME_ID], [MED_PREV_NAME_ID])
)

CREATE NONCLUSTERED INDEX [RMINMRH1_NX1] ON [fdb_a].[RMINMRH1] ([MED_PREV_NAME_ID])

GO
