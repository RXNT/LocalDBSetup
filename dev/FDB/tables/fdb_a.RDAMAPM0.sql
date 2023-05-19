CREATE TABLE [fdb_a].[RDAMAPM0] (
   [DAM_CONCEPT_ID] [numeric](8,0) NOT NULL,
   [DAM_CONCEPT_ID_TYP] [numeric](3,0) NOT NULL,
   [DAM_CONCEPT_ID_DESC] [varchar](50) NULL

   ,CONSTRAINT [RDAMAPM0_PK] PRIMARY KEY CLUSTERED ([DAM_CONCEPT_ID], [DAM_CONCEPT_ID_TYP])
)


GO