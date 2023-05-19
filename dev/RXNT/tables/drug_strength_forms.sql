CREATE TABLE [dbo].[drug_strength_forms] (
   [dsf_id] [int] NOT NULL
      IDENTITY (1,1),
   [dsf_text] [varchar](100) NOT NULL,
   [dsf_order] [int] NOT NULL,
   [NCIt_unit_code] [varchar](10) NULL

   ,CONSTRAINT [PK_drug_strength_forms] PRIMARY KEY NONCLUSTERED ([dsf_id])
)


GO
