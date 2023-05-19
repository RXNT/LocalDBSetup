CREATE TABLE [dbo].[patient_assessment_template] (
   [ass_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [diagnosis] [varchar](15) NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_assessment_template] PRIMARY KEY CLUSTERED ([ass_id])
)


GO
