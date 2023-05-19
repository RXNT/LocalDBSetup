CREATE TABLE [dbo].[patient_enc_plan_of_care_template] (
   [poc_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_plan_of_care_template] PRIMARY KEY CLUSTERED ([poc_id])
)


GO
