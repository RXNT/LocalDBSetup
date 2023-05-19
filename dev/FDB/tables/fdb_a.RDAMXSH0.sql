CREATE TABLE [fdb_a].[RDAMXSH0] (
   [REPL_DAM_ALRGN_XSENSE] [numeric](4,0) NOT NULL,
   [PREV_DAM_ALRGN_XSENSE] [numeric](4,0) NOT NULL,
   [DAM_ALRGN_XSENSE_REPL_EFF_DT] [datetime] NULL

   ,CONSTRAINT [RDAMXSH0_PK] PRIMARY KEY CLUSTERED ([REPL_DAM_ALRGN_XSENSE], [PREV_DAM_ALRGN_XSENSE])
)


GO