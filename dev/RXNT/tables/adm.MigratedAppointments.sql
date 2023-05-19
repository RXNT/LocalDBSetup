CREATE TABLE [adm].[MigratedAppointments] (
   [migrated_id] [bigint] NOT NULL
      IDENTITY (1,1),
   [event_id] [int] NOT NULL,
   [ExternalAppointmentId] [bigint] NULL,
   [request_id] [bigint] NOT NULL,
   [status] [int] NOT NULL,
   [retry_count] [int] NOT NULL,
   [CreatedOn] [datetime] NOT NULL,
   [LastEditedOn] [datetime] NULL

   ,CONSTRAINT [PK_MigratedAppointments] PRIMARY KEY CLUSTERED ([migrated_id])
)


GO
