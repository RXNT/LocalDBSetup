CREATE TABLE [dbo].[patient_enc_plan_of_care] (
   [poc_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_plan_of_care] PRIMARY KEY CLUSTERED ([poc_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_enc_plan_of_care] ON [dbo].[patient_enc_plan_of_care] ([enc_id])

GO
