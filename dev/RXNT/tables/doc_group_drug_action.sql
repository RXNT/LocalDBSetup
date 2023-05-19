CREATE TABLE [dbo].[doc_group_drug_action] (
   [dg_drug_action_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [bigint] NULL,
   [code] [varchar](10) NULL,
   [description] [varchar](100) NULL

   ,CONSTRAINT [PK__doc_grou__3214EC0720E50A11] PRIMARY KEY CLUSTERED ([dg_drug_action_id])
)


GO
