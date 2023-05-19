CREATE TABLE [dbo].[patient_documents_26224] (
   [document_id] [int] NOT NULL,
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [description] [varchar](225) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [cat_id] [smallint] NOT NULL,
   [owner_id] [bigint] NULL,
   [owner_type] [varchar](3) NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [comment] [varchar](500) NULL,
   [document_date] [datetime] NULL

   ,CONSTRAINT [PK_patient_documents_26224] PRIMARY KEY CLUSTERED ([document_id])
)


GO
