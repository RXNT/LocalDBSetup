CREATE TABLE [dbo].[hospice_drug_relatedness] (
   [hospice_drug_relatedness_id] [int] NOT NULL,
   [Code] [varchar](50) NOT NULL,
   [Description] [varchar](255) NOT NULL,
   [Active] [bit] NOT NULL

   ,CONSTRAINT [PK_hospice_drug_relatedness] PRIMARY KEY CLUSTERED ([hospice_drug_relatedness_id])
)


GO
