CREATE TABLE [dbo].[patient_hpi] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [location] [varchar](255) NOT NULL,
   [severity] [tinyint] NOT NULL,
   [duration] [varchar](50) NOT NULL,
   [signs] [varchar](1000) NOT NULL,
   [symptoms] [varchar](1000) NOT NULL,
   [note] [varchar](225) NOT NULL

   ,CONSTRAINT [PK_patient_hpi] PRIMARY KEY CLUSTERED ([history_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_hpi] ON [dbo].[patient_hpi] ([enc_id])

GO
