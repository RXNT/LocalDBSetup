CREATE TABLE [fdb_a].[RPDMMA0] (
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [PDM_MNAGE] [numeric](4,0) NOT NULL,
   [PDM_MXAGE] [numeric](4,0) NOT NULL,
   [PDM_MND] [numeric](12,6) NULL,
   [PDM_MNDU] [varchar](2) NULL,
   [PDM_MNU] [numeric](12,6) NULL,
   [PDM_MNUF] [varchar](2) NULL,
   [PDM_MXD] [numeric](12,6) NULL,
   [PDM_MXDU] [varchar](2) NULL,
   [PDM_MXU] [numeric](12,6) NULL,
   [PDM_MXUF] [varchar](2) NULL,
   [PDM_NTED] [numeric](12,6) NULL,
   [PDM_NTEDU] [varchar](2) NULL,
   [PDM_NTEU] [numeric](12,6) NULL,
   [PDM_NTEUF] [varchar](2) NULL

   ,CONSTRAINT [RPDMMA0_PK] PRIMARY KEY CLUSTERED ([GCN_SEQNO], [PDM_MNAGE], [PDM_MXAGE])
)

CREATE NONCLUSTERED INDEX [RPDMMA0_NX1] ON [fdb_a].[RPDMMA0] ([PDM_MNDU])
CREATE NONCLUSTERED INDEX [RPDMMA0_NX2] ON [fdb_a].[RPDMMA0] ([PDM_MNUF])
CREATE NONCLUSTERED INDEX [RPDMMA0_NX3] ON [fdb_a].[RPDMMA0] ([PDM_MXDU])
CREATE NONCLUSTERED INDEX [RPDMMA0_NX4] ON [fdb_a].[RPDMMA0] ([PDM_MXUF])
CREATE NONCLUSTERED INDEX [RPDMMA0_NX5] ON [fdb_a].[RPDMMA0] ([PDM_NTEDU])
CREATE NONCLUSTERED INDEX [RPDMMA0_NX6] ON [fdb_a].[RPDMMA0] ([PDM_NTEUF])

GO