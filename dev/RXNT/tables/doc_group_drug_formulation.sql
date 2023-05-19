CREATE TABLE [dbo].[doc_group_drug_formulation] (
   [dg_drug_formulation_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0724B59AF5] PRIMARY KEY CLUSTERED ([dg_drug_formulation_id])
)


GO
