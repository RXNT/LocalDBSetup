CREATE TABLE [fdb_a].[RHIC2D3] (
   [HIC2_SEQN] [numeric](6,0) NOT NULL,
   [HIC2] [varchar](2) NOT NULL,
   [HIC2_DESC] [varchar](50) NULL,
   [HIC2_ROOT] [numeric](6,0) NULL

   ,CONSTRAINT [RHIC2D3_PK] PRIMARY KEY CLUSTERED ([HIC2_SEQN])
)

CREATE NONCLUSTERED INDEX [RHIC2D3_NX1] ON [fdb_a].[RHIC2D3] ([HIC2])
CREATE NONCLUSTERED INDEX [RHIC2D3_NX2] ON [fdb_a].[RHIC2D3] ([HIC2_ROOT])

GO
