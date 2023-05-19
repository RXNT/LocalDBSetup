CREATE TABLE [dbo].[drug_strength_units] (
   [dsu_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsu_text] [varchar](100) NOT NULL,
   [dsu_order] [int] NOT NULL,
   [NCIt_unit_code] [varchar](10) NULL

   ,CONSTRAINT [PK_drug_strength_units] PRIMARY KEY NONCLUSTERED ([dsu_id])
)


GO
