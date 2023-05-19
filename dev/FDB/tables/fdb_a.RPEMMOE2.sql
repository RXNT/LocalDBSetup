CREATE TABLE [fdb_a].[RPEMMOE2] (
   [PEMONO] [numeric](4,0) NOT NULL,
   [PEMONOE_SN] [numeric](3,0) NOT NULL,
   [PEMTXTEI] [varchar](1) NULL,
   [PEMTXTE] [varchar](76) NULL,
   [PEMGNDR] [varchar](1) NULL,
   [PEMAGE] [varchar](1) NULL

   ,CONSTRAINT [RPEMMOE2_PK] PRIMARY KEY CLUSTERED ([PEMONO], [PEMONOE_SN])
)


GO
