CREATE TABLE [dbo].[alternatives] (
   [id] [int] NOT NULL
      IDENTITY (1,1),
   [acr_id] [int] NOT NULL,
   [source_ndc] [varchar](11) NOT NULL,
   [alternate_ndc] [varchar](11) NOT NULL,
   [form_status] [int] NOT NULL,
   [rel_value] [int] NULL,
   [text] [varchar](200) NULL

   ,CONSTRAINT [PK_alternatives] PRIMARY KEY CLUSTERED ([id])
)


GO
