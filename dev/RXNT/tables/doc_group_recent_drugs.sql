CREATE TABLE [dbo].[doc_group_recent_drugs] (
   [dgrd_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [drug_id] [bigint] NOT NULL,
   [drug_prescribed_count] [bigint] NULL

   ,CONSTRAINT [PK_doc_group_recent_drugs] PRIMARY KEY CLUSTERED ([dgrd_id])
)


GO
