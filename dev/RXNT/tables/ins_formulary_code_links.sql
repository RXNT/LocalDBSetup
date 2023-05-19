CREATE TABLE [dbo].[ins_formulary_code_links] (
   [ifcl_id] [int] NOT NULL
      IDENTITY (1,1),
   [if_id] [int] NOT NULL,
   [ifc_id] [int] NOT NULL

   ,CONSTRAINT [PK_ins_formulary_code_links] PRIMARY KEY NONCLUSTERED ([ifcl_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [IF_IFC_No_Dups] ON [dbo].[ins_formulary_code_links] ([if_id], [ifc_id])

GO
