CREATE TABLE [dbo].[patient_ethnicity_details] (
   [pa_ethnicity_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [ethnicity_id] [int] NOT NULL,
   [ethnicity_text] [varchar](50) NULL,
   [dr_id] [int] NULL,
   [date_added] [smalldatetime] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_ethnicity_details] PRIMARY KEY CLUSTERED ([pa_ethnicity_id])
)


GO
