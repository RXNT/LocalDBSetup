CREATE TABLE [fdb_b].[RDFIMMO0] (
   [FDCDE] [numeric](3,0) NOT NULL,
   [FDCDE_SN] [numeric](3,0) NOT NULL,
   [TXTCDE] [varchar](1) NULL,
   [FDTXT] [varchar](76) NULL

   ,CONSTRAINT [RDFIMMO0_PK] PRIMARY KEY CLUSTERED ([FDCDE], [FDCDE_SN])
)


GO
