CREATE TABLE [dbo].[drug_fdb_strength_units] (
   [dsu_fdb_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsu_text] [varchar](100) NOT NULL,
   [dsu_id] [int] NULL

   ,CONSTRAINT [PK_drug_fdb_strength_units] PRIMARY KEY NONCLUSTERED ([dsu_fdb_id])
   ,CONSTRAINT [UQ__drug_fdb__0EE344594A401E12] UNIQUE NONCLUSTERED ([dsu_text])
)


GO
