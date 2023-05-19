CREATE TABLE [dbo].[ins_formulary_codes] (
   [ifc_id] [int] NOT NULL
      IDENTITY (1,1),
   [ifc_code] [varchar](30) NOT NULL,
   [ifc_desc] [varchar](100) NULL

   ,CONSTRAINT [PK_ins_formulary_codes] PRIMARY KEY NONCLUSTERED ([ifc_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [NoDups] ON [dbo].[ins_formulary_codes] ([ifc_code])

GO
