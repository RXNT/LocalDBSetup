CREATE TABLE [dbo].[doc_group_lost_documents] (
   [lost_document_id] [int] NOT NULL
      IDENTITY (1,1),
   [dg_id] [int] NOT NULL,
   [pa_first] [varchar](50) NULL,
   [pa_last] [varchar](50) NULL,
   [pa_sex] [varchar](1) NULL,
   [pa_dob] [smalldatetime] NULL,
   [pa_ssn] [varchar](20) NULL,
   [pa_zip] [varchar](20) NULL,
   [additional_info] [varchar](1024) NULL,
   [error_msg] [varchar](1024) NULL,
   [document_path] [varchar](1024) NULL

   ,CONSTRAINT [PK_doc_group_lost_documents] PRIMARY KEY CLUSTERED ([lost_document_id])
)


GO
