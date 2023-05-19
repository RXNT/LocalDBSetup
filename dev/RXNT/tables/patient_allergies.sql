CREATE TABLE [dbo].[patient_allergies] (
   [pa_allergy_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [allergy_id] [int] NOT NULL,
   [allergy_type] [smallint] NOT NULL,
   [reaction_string] [varchar](100) NULL,
   [comments] [varchar](100) NULL,
   [add_date] [smalldatetime] NOT NULL

   ,CONSTRAINT [PK_patient_allergies] PRIMARY KEY CLUSTERED ([pa_allergy_id])
)

CREATE UNIQUE NONCLUSTERED INDEX [UniqueAllergies] ON [dbo].[patient_allergies] ([pa_id], [allergy_id], [allergy_type])

GO
