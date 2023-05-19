CREATE TABLE [dbo].[tblVaccineVISToURL] (
   [vis_url_id] [int] NOT NULL
      IDENTITY (1,1),
   [vis_concept_id] [int] NOT NULL,
   [vis_pdf_url] [varchar](500) NOT NULL,
   [vis_html_url] [varchar](500) NOT NULL,
   [is_active] [bit] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineVISToURL] PRIMARY KEY CLUSTERED ([vis_url_id])
)


GO
