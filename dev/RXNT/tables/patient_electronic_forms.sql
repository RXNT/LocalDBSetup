CREATE TABLE [dbo].[patient_electronic_forms] (
   [electronic_form_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [src_dr_id] [int] NOT NULL,
   [upload_date] [datetime] NOT NULL,
   [title] [varchar](80) NOT NULL,
   [filename] [varchar](255) NOT NULL,
   [description] [varchar](255) NULL,
   [type] [int] NULL,
   [is_reviewed_by_prescriber] [bit] NOT NULL

   ,CONSTRAINT [PK_patient_consent_forms] PRIMARY KEY CLUSTERED ([electronic_form_id])
)


GO
