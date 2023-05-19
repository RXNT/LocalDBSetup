CREATE TABLE [dbo].[patient_respiration] (
   [pa_resp_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_resp_rate] [int] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patient_respiration] PRIMARY KEY CLUSTERED ([pa_resp_id])
)


GO
