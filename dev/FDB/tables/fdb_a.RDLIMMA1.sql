CREATE TABLE [fdb_a].[RDLIMMA1] (
   [DLIM_DRUG_GRP_ID] [numeric](5,0) NOT NULL,
   [MTL_SPEC_LAB_ID] [numeric](8,0) NOT NULL,
   [DLIM_INTER_TYP_CODE] [varchar](2) NOT NULL,
   [DLIM_DOC_LEVEL_CODE] [varchar](2) NOT NULL,
   [DLIM_MONOGRAPH_ID] [numeric](8,0) NOT NULL

   ,CONSTRAINT [RDLIMMA1_PK] PRIMARY KEY CLUSTERED ([DLIM_DRUG_GRP_ID], [MTL_SPEC_LAB_ID])
)


GO