CREATE TABLE [dbo].[patient_documents_category] (
   [cat_id] [int] NOT NULL
      IDENTITY (1,1),
   [title] [varchar](255) NOT NULL,
   [dg_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_documents_category] PRIMARY KEY CLUSTERED ([cat_id])
)


GO
