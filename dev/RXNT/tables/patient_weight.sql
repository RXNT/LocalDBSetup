CREATE TABLE [dbo].[patient_weight] (
   [pa_wt_id] [int] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [pa_wgt] [float] NOT NULL,
   [age] [int] NOT NULL,
   [date_added] [datetime] NOT NULL,
   [added_by] [int] NOT NULL,
   [added_for] [int] NOT NULL,
   [record_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_patien_weight] PRIMARY KEY CLUSTERED ([pa_wt_id])
)


GO
