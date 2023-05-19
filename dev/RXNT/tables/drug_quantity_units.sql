CREATE TABLE [dbo].[drug_quantity_units] (
   [dqu_id] [int] NOT NULL
      IDENTITY (1,1),
   [dqu_text] [varchar](100) NOT NULL,
   [dqu_order] [int] NOT NULL,
   [NCIt_unit_code] [varchar](10) NULL

   ,CONSTRAINT [PK_drug_quantity_units] PRIMARY KEY NONCLUSTERED ([dqu_id])
)


GO
