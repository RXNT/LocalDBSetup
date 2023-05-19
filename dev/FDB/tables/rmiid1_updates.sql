CREATE TABLE [dbo].[rmiid1_updates] (
   [MEDID] [numeric](8,0) NOT NULL,
   [ROUTED_DOSAGE_FORM_MED_ID] [numeric](8,0) NOT NULL,
   [MED_STRENGTH] [varchar](15) NULL,
   [MED_STRENGTH_UOM] [varchar](15) NULL,
   [MED_MEDID_DESC] [varchar](70) NOT NULL,
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
   [GENERIC_MEDID] [numeric](8,0) NULL
)


GO
