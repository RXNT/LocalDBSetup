CREATE TABLE [dbo].[patient_bglucose] (
   [pa_glc_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_glucose] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_bglucose] PRIMARY KEY CLUSTERED ([pa_glc_id])
)


GO
