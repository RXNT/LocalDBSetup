CREATE TABLE [fdb_b].[RMINDC1] (
   [NDC] [varchar](11) NOT NULL,
   [MEDID] [numeric](8,0) NOT NULL

   ,CONSTRAINT [RMINDC1_PK] PRIMARY KEY CLUSTERED ([NDC])
)

CREATE NONCLUSTERED INDEX [RMINDC1_NX1] ON [fdb_b].[RMINDC1] ([MEDID])

GO
