CREATE TABLE [dbo].[patient_bp] (
   [pa_bp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_sys] [float] NOT NULL,
   [pa_dys] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_bp] PRIMARY KEY CLUSTERED ([pa_bp_id])
)


GO
