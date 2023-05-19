CREATE TABLE [fdb_a].[RETCHLH0] (
   [HICL_SEQNO] [numeric](6,0) NOT NULL,
   [ETC_ID] [numeric](8,0) NOT NULL,
   [ETC_REVISION_SEQNO] [numeric](5,0) NOT NULL,
   [ETC_CHANGE_TYPE_CODE] [varchar](1) NULL,
   [ETC_EFFECTIVE_DATE] [datetime] NULL

   ,CONSTRAINT [RETCHLH0_PK] PRIMARY KEY CLUSTERED ([HICL_SEQNO], [ETC_ID], [ETC_REVISION_SEQNO])
)

CREATE NONCLUSTERED INDEX [RETCHLH0_NX1] ON [fdb_a].[RETCHLH0] ([ETC_ID])

GO
