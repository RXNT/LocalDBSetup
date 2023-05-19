CREATE TABLE [dbo].[patient_encounters] (
   [enc_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [encounter_date] [datetime] NOT NULL,
   [chief_complaint] [varchar](2000) NOT NULL,
   [enc_reason] [varchar](30) NOT NULL,
   [added_by_dr_id] [int] NOT NULL

   ,CONSTRAINT [PK_patient_encounters] PRIMARY KEY CLUSTERED ([enc_id])
)

CREATE NONCLUSTERED INDEX [IX_patient_encounters] ON [dbo].[patient_encounters] ([pa_id], [dr_id])

GO
