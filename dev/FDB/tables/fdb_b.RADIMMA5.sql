CREATE TABLE [fdb_b].[RADIMMA5] (
   [DDI_CODEX] [numeric](5,0) NOT NULL,
   [DDI_DES] [varchar](60) NULL,
   [DDI_SL] [varchar](1) NULL,
   [DDI_MONOX] [numeric](5,0) NULL,
   [DDI_PGEDI] [varchar](9) NULL,
   [DDI_TREE] [numeric](5,0) NULL,
   [DDI_MFGI] [varchar](1) NULL,
   [DDI_TRIALI] [varchar](1) NULL,
   [DDI_CASEI] [varchar](1) NULL,
   [DDI_ABSI] [varchar](1) NULL,
   [DDI_IVASI] [varchar](1) NULL,
   [DDI_REVI] [varchar](1) NULL

   ,CONSTRAINT [RADIMMA5_PK] PRIMARY KEY CLUSTERED ([DDI_CODEX])
)

CREATE NONCLUSTERED INDEX [RADIMMA5_NX1] ON [fdb_b].[RADIMMA5] ([DDI_SL])
CREATE NONCLUSTERED INDEX [RADIMMA5_NX2] ON [fdb_b].[RADIMMA5] ([DDI_MONOX])

GO
