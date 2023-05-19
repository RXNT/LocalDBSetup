CREATE TABLE [dbo].[ScriptGuideDrugIDs] (
   [sg_id] [int] NOT NULL,
   [drug_id] [int] NOT NULL,
   [sg_drug_xrefid] [int] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK_ScriptGuideDrugIDs] PRIMARY KEY CLUSTERED ([sg_drug_xrefid])
)

CREATE UNIQUE NONCLUSTERED INDEX [SGToDrugIDNoDupes] ON [dbo].[ScriptGuideDrugIDs] ([sg_id], [drug_id])

GO
