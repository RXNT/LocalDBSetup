CREATE TABLE [fdb_b].[RPDMWT1] (
   [PDM_MNAGE] [numeric](4,0) NOT NULL,
   [PDM_MXAGE] [numeric](4,0) NOT NULL,
   [PDM_AGEDSC] [varchar](30) NULL,
   [PDM_M05WT] [numeric](5,2) NULL,
   [PDM_M25WT] [numeric](5,2) NULL,
   [PDM_M50WT] [numeric](5,2) NULL,
   [PDM_M75WT] [numeric](5,2) NULL,
   [PDM_M95WT] [numeric](5,2) NULL,
   [PDM_F05WT] [numeric](5,2) NULL,
   [PDM_F25WT] [numeric](5,2) NULL,
   [PDM_F50WT] [numeric](5,2) NULL,
   [PDM_F75WT] [numeric](5,2) NULL,
   [PDM_F95WT] [numeric](5,2) NULL

   ,CONSTRAINT [RPDMWT1_PK] PRIMARY KEY CLUSTERED ([PDM_MNAGE], [PDM_MXAGE])
)


GO
