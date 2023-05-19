CREATE TABLE [dbo].[patient_past_history] (
   [history_id] [int] NOT NULL
      IDENTITY (1,1),
   [enc_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [pa_id] [int] NOT NULL,
   [added_by_dr_id] [int] NOT NULL,
   [added_date] [datetime] NOT NULL,
   [text] [text] NOT NULL

   ,CONSTRAINT [PK_patient_past_history] PRIMARY KEY CLUSTERED ([history_id])
)


GO
