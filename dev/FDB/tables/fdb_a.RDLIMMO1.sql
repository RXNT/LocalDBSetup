CREATE TABLE [fdb_a].[RDLIMMO1] (
   [DLIM_MONOGRAPH_ID] [numeric](8,0) NOT NULL,
   [DLIM_TEXT_SEQNO] [numeric](5,0) NOT NULL,
   [DLIM_TEXT_TYP_CODE] [varchar](2) NULL,
   [DLIM_TEXT] [varchar](255) NULL

   ,CONSTRAINT [RDLIMMO1_PK] PRIMARY KEY CLUSTERED ([DLIM_MONOGRAPH_ID], [DLIM_TEXT_SEQNO])
)


GO
