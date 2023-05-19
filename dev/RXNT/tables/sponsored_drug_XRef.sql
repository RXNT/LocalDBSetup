CREATE TABLE [dbo].[sponsored_drug_XRef] (
   [sponsor_id] [int] NOT NULL,
   [equiv_drug_id] [int] NOT NULL,
   [sponsored_drug_id] [int] NOT NULL

   ,CONSTRAINT [PK_sponsored_drug_XRef] PRIMARY KEY CLUSTERED ([sponsor_id], [equiv_drug_id], [sponsored_drug_id])
)


GO
