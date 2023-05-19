CREATE TABLE [dbo].[patient_visit_appointment_detail] (
   [visit_id] [bigint] NOT NULL,
   [AppointmentId] [bigint] NULL,
   [MasterPatientId] [bigint] NULL,
   [MasterCompanyId] [bigint] NULL,
   [MasterLoginId] [bigint] NULL,
   [PersonResourceID] [bigint] NULL,
   [CreatedDate] [datetime2] NOT NULL,
   [CreatedBy] [bigint] NOT NULL,
   [LastModifiedDate] [datetime2] NULL,
   [LastModifiedBy] [bigint] NULL

   ,CONSTRAINT [PK_patient_visit_appointment_detail] PRIMARY KEY CLUSTERED ([visit_id])
)


GO
