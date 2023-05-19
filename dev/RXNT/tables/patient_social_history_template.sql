CREATE TABLE [dbo].[patient_social_history_template] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [template_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_social_history_template] PRIMARY KEY CLUSTERED ([history_id])
)


GO
