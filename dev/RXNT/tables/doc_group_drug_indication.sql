CREATE TABLE [dbo].[doc_group_drug_indication] (
   [dg_drug_indication_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL,
   [ICD10] [varchar](50) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0730274DA1] PRIMARY KEY CLUSTERED ([dg_drug_indication_id])
)


GO
