CREATE TABLE [dbo].[patients_queue_to_external_application] (
   [pa_id] [bigint] NOT NULL,
   [dg_id] [bigint] NOT NULL,
   [ApplicationID] [bigint] NOT NULL,
   [rxnt_status_id] [int] NOT NULL,
   [queued_date] [datetime] NOT NULL,
   [completed_date] [datetime] NULL

   ,CONSTRAINT [PK_patients_queue_to_external_application] PRIMARY KEY CLUSTERED ([pa_id])
)


GO
