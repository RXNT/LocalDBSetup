CREATE TABLE [dbo].[patient_chart_restricted_users] (
   [pcru_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [pa_id] [int] NOT NULL,
   [dr_id] [int] NOT NULL,
   [isRestricted] [bit] NULL

   ,CONSTRAINT [PK_patient_chart_restricted_users] PRIMARY KEY NONCLUSTERED ([pcru_id])
)


GO
