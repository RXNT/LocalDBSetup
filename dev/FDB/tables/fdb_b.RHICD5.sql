CREATE TABLE [fdb_b].[RHICD5] (
   [HIC_SEQN] [numeric](6,0) NOT NULL,
   [HIC] [varchar](6) NULL,
   [HIC_DESC] [varchar](50) NULL,
   [HIC_ROOT] [numeric](6,0) NULL,
   [HIC_POTENTIALLY_INACTV_IND] [numeric](1,0) NULL,
   [ING_STATUS_CD] [numeric](1,0) NULL

   ,CONSTRAINT [RHICD5_PK] PRIMARY KEY CLUSTERED ([HIC_SEQN])
)

CREATE NONCLUSTERED INDEX [RHICD5_NX2] ON [fdb_b].[RHICD5] ([HIC])
CREATE NONCLUSTERED INDEX [RHICD5_NX3] ON [fdb_b].[RHICD5] ([HIC_ROOT])

GO
