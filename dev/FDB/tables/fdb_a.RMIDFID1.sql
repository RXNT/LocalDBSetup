CREATE TABLE [fdb_a].[RMIDFID1] (
   [ROUTED_DOSAGE_FORM_MED_ID] [numeric](8,0) NOT NULL,
   [ROUTED_MED_ID] [numeric](8,0) NOT NULL,
   [MED_DOSAGE_FORM_ID] [numeric](5,0) NOT NULL,
   [MED_ROUTED_DF_MED_ID_DESC] [varchar](60) NOT NULL,
   [MED_STATUS_CD] [varchar](1) NOT NULL

   ,CONSTRAINT [RMIDFID1_PK] PRIMARY KEY CLUSTERED ([ROUTED_DOSAGE_FORM_MED_ID])
)

CREATE NONCLUSTERED INDEX [RMIDFID1_NX1] ON [fdb_a].[RMIDFID1] ([ROUTED_MED_ID])
CREATE NONCLUSTERED INDEX [RMIDFID1_NX2] ON [fdb_a].[RMIDFID1] ([MED_DOSAGE_FORM_ID])
CREATE NONCLUSTERED INDEX [RMIDFID1_NX3] ON [fdb_a].[RMIDFID1] ([MED_STATUS_CD])

GO