CREATE TABLE [bk].[patient_electronic_forms] (
   [electronic_form_id] [int] NULL,
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [description] [varchar](255) NULL,
   [type] [int] NULL,
   [is_reviewed_by_prescriber] [bit] NOT NULL
)


GO
