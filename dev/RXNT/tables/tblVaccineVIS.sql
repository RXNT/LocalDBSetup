CREATE TABLE [dbo].[tblVaccineVIS] (
   [vis_concept_id] [int] NOT NULL
      IDENTITY (1,1),
   [vis_concept_name] [varchar](100) NOT NULL,
   [vis_edition_date] [datetime] NOT NULL,
   [vis_encoded_text] [varchar](50) NOT NULL,
   [vis_concept_code] [varchar](50) NOT NULL,
   [vis_edition_status] [varchar](50) NOT NULL,
   [vis_last_updated_date] [datetime] NOT NULL,
   [created_by] [int] NULL,
   [created_date] [datetime] NULL,
   [updated_by] [int] NULL,
   [updated_date] [datetime] NULL

   ,CONSTRAINT [PK_tblVaccineVIS] PRIMARY KEY CLUSTERED ([vis_concept_id])
)


GO
