CREATE TABLE [dbo].[patient_assessment] (
   [ass_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [diagnosis] [varchar](15) NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_assessment] PRIMARY KEY CLUSTERED ([ass_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_assessment] ON [dbo].[patient_assessment] ([enc_id])

GO
