CREATE TABLE [fdb_a].[RMIID1] (
   [MEDID] [numeric](8,0) NOT NULL,
   [ROUTED_DOSAGE_FORM_MED_ID] [numeric](8,0) NOT NULL,
   [MED_STRENGTH] [varchar](15) NULL,
   [MED_STRENGTH_UOM] [varchar](15) NULL,
   [MED_MEDID_DESC] [varchar](210) NOT NULL,
   [GCN_SEQNO] [numeric](6,0) NOT NULL,
   [MED_GCNSEQNO_ASSIGN_CD] [varchar](1) NOT NULL,
   [MED_NAME_SOURCE_CD] [varchar](1) NOT NULL,
   [MED_REF_FED_LEGEND_IND] [varchar](1) NOT NULL,
   [MED_REF_DEA_CD] [varchar](1) NOT NULL,
   [MED_REF_MULTI_SOURCE_CD] [varchar](1) NOT NULL,
   [MED_REF_GEN_DRUG_NAME_CD] [varchar](1) NOT NULL,
   [MED_REF_GEN_COMP_PRICE_CD] [varchar](1) NOT NULL,
   [MED_REF_GEN_SPREAD_CD] [varchar](1) NOT NULL,
   [MED_REF_INNOV_IND] [varchar](1) NOT NULL,
   [MED_REF_GEN_THERA_EQU_CD] [varchar](1) NOT NULL,
   [MED_REF_DESI_IND] [varchar](1) NOT NULL,
   [MED_REF_DESI2_IND] [varchar](1) NOT NULL,
   [MED_STATUS_CD] [varchar](1) NOT NULL,
   [GENERIC_MEDID] [numeric](8,0) NULL,
   [GCN_STRING] [varchar](10) NULL

   ,CONSTRAINT [RMIID1_PK] PRIMARY KEY CLUSTERED ([MEDID])
)

CREATE NONCLUSTERED INDEX [_dta_index_RMIID1_12_71671303__K1_9_12] ON [fdb_a].[RMIID1] ([MEDID]) INCLUDE ([MED_REF_FED_LEGEND_IND], [MED_REF_GEN_DRUG_NAME_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX1] ON [fdb_a].[RMIID1] ([ROUTED_DOSAGE_FORM_MED_ID])
CREATE NONCLUSTERED INDEX [RMIID1_NX10] ON [fdb_a].[RMIID1] ([MED_REF_GEN_COMP_PRICE_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX11] ON [fdb_a].[RMIID1] ([MED_REF_GEN_SPREAD_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX12] ON [fdb_a].[RMIID1] ([MED_REF_INNOV_IND])
CREATE NONCLUSTERED INDEX [RMIID1_NX13] ON [fdb_a].[RMIID1] ([MED_REF_GEN_THERA_EQU_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX14] ON [fdb_a].[RMIID1] ([MED_REF_DESI_IND])
CREATE NONCLUSTERED INDEX [RMIID1_NX15] ON [fdb_a].[RMIID1] ([MED_REF_DESI2_IND])
CREATE NONCLUSTERED INDEX [RMIID1_NX16] ON [fdb_a].[RMIID1] ([MED_STATUS_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX2] ON [fdb_a].[RMIID1] ([GCN_SEQNO])
CREATE NONCLUSTERED INDEX [RMIID1_NX3] ON [fdb_a].[RMIID1] ([GENERIC_MEDID])
CREATE NONCLUSTERED INDEX [RMIID1_NX4] ON [fdb_a].[RMIID1] ([MED_GCNSEQNO_ASSIGN_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX5] ON [fdb_a].[RMIID1] ([MED_NAME_SOURCE_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX6] ON [fdb_a].[RMIID1] ([MED_REF_FED_LEGEND_IND])
CREATE NONCLUSTERED INDEX [RMIID1_NX7] ON [fdb_a].[RMIID1] ([MED_REF_DEA_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX8] ON [fdb_a].[RMIID1] ([MED_REF_MULTI_SOURCE_CD])
CREATE NONCLUSTERED INDEX [RMIID1_NX9] ON [fdb_a].[RMIID1] ([MED_REF_GEN_DRUG_NAME_CD])

GO
