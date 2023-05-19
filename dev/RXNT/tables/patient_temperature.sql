CREATE TABLE [dbo].[patient_temperature] (
   [pa_temp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_temp] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK__patient_temperat__66B6D1CE] PRIMARY KEY CLUSTERED ([pa_temp_id])
)


GO
