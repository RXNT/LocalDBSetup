CREATE TABLE [fdb_b].[RDAMAGD1] (
   [DAM_ALRGN_GRP] [numeric](6,0) NOT NULL,
   [DAM_ALRGN_GRP_DESC] [varchar](50) NULL,
   [DAM_GRP_POTENTIALLY_INACTV_IND] [numeric](1,0) NULL,
   [DAM_ALRGN_GRP_STATUS_CD] [numeric](1,0) NULL

   ,CONSTRAINT [RDAMAGD1_PK] PRIMARY KEY CLUSTERED ([DAM_ALRGN_GRP])
)


GO