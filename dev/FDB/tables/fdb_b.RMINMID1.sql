CREATE TABLE [fdb_b].[RMINMID1] (
   [MED_NAME_ID] [numeric](8,0) NOT NULL,
   [MED_NAME] [varchar](30) NOT NULL,
   [MED_NAME_TYPE_CD] [varchar](1) NOT NULL,
   [MED_STATUS_CD] [varchar](1) NOT NULL

   ,CONSTRAINT [RMINMID1_PK] PRIMARY KEY CLUSTERED ([MED_NAME_ID])
)

CREATE NONCLUSTERED INDEX [RMINMID1_NX1] ON [fdb_b].[RMINMID1] ([MED_NAME_TYPE_CD])
CREATE NONCLUSTERED INDEX [RMINMID1_NX2] ON [fdb_b].[RMINMID1] ([MED_STATUS_CD])
CREATE NONCLUSTERED INDEX [RMINMID1_NX3] ON [fdb_b].[RMINMID1] ([MED_NAME])

GO
