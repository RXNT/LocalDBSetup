CREATE TABLE [fdb_b].[RDAMGRH0] (
   [REPL_DAM_ALRGN_GRP] [numeric](6,0) NOT NULL,
   [PREV_DAM_ALRGN_GRP] [numeric](6,0) NOT NULL,
   [DAM_ALRGN_GRP_REPL_EFF_DT] [datetime] NULL

   ,CONSTRAINT [RDAMGRH0_PK] PRIMARY KEY CLUSTERED ([REPL_DAM_ALRGN_GRP], [PREV_DAM_ALRGN_GRP])
)


GO
