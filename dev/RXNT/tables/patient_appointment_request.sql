CREATE TABLE [dbo].[patient_appointment_request] (
   [pat_appt_req_id] [int] NOT NULL
      IDENTITY (1,1),
   [pat_id] [int] NOT NULL,
   [dg_id] [int] NOT NULL,
   [req_appt_date] [varchar](20) NOT NULL,
   [req_appt_time] [varchar](20) NOT NULL,
   [primary_reason] [varchar](max) NOT NULL,
   [is_completed] [bit] NOT NULL,
   [created_datetime] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_patient_appointment_request] PRIMARY KEY CLUSTERED ([pat_appt_req_id])
)


GO
