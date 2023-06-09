CREATE TABLE [fdb_b].[RMIRMID1] (
   [ROUTED_MED_ID] [numeric](8,0) NOT NULL,
   [MED_NAME_ID] [numeric](8,0) NOT NULL,
   [MED_ROUTE_ID] [numeric](5,0) NOT NULL,
   [MED_ROUTED_MED_ID_DESC] [varchar](60) NOT NULL,
   [MED_STATUS_CD] [varchar](1) NOT NULL

   ,CONSTRAINT [RMIRMID1_PK] PRIMARY KEY CLUSTERED ([ROUTED_MED_ID])
)

CREATE NONCLUSTERED INDEX [RMIRMID1_NX1] ON [fdb_b].[RMIRMID1] ([MED_NAME_ID])
CREATE NONCLUSTERED INDEX [RMIRMID1_NX2] ON [fdb_b].[RMIRMID1] ([MED_ROUTE_ID])
CREATE NONCLUSTERED INDEX [RMIRMID1_NX3] ON [fdb_b].[RMIRMID1] ([MED_STATUS_CD])

GO
