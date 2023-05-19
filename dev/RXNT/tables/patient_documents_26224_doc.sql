CREATE TABLE [dbo].[patient_documents_26224_doc] (
   [Id] [bigint] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [pat_id] [bigint] NULL,
   [FileName] [varchar](255) NULL

   ,CONSTRAINT [PK_patient_documents_26224_doc] PRIMARY KEY CLUSTERED ([Id])
)


GO
