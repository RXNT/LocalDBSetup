CREATE TABLE [fdb_a].[RADIMIE4] (
   [DDI_CODEX] [numeric](5,0) NOT NULL,
   [ADI_EFFTC] [varchar](3) NOT NULL

   ,CONSTRAINT [RADIMIE4_PK] PRIMARY KEY CLUSTERED ([DDI_CODEX], [ADI_EFFTC])
)

CREATE NONCLUSTERED INDEX [RADIMIE4_NX1] ON [fdb_a].[RADIMIE4] ([ADI_EFFTC])

GO
