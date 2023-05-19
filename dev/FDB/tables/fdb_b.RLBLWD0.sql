CREATE TABLE [fdb_b].[RLBLWD0] (
   [LBL_WARN] [varchar](4) NOT NULL,
   [LBL_TEXTSN] [numeric](2,0) NOT NULL,
   [LBL_DESC] [varchar](55) NULL,
   [LBLGNDR] [varchar](1) NULL,
   [LBLAGE] [varchar](1) NULL,
   [LBLPREG] [varchar](1) NULL,
   [LBLINFO] [varchar](1) NULL

   ,CONSTRAINT [RLBLWD0_PK] PRIMARY KEY CLUSTERED ([LBL_WARN], [LBL_TEXTSN])
)


GO
