CREATE TABLE [dbo].[TempAppointmentsCheckinTimeUTCToEST] (
   [id] [bigint] NOT NULL
      IDENTITY (1,1),
   [event_id] [bigint] NOT NULL,
   [AppointmentId] [bigint] NOT NULL,
   [dtCheckInUTC] [datetime] NULL,
   [dtCheckInEST] [datetime] NULL,
   [V2CheckInTime] [datetime2] NULL,
   [dtCalledUTC] [datetime] NULL,
   [dtCalledEST] [datetime] NULL,
   [V2CallInTime] [datetime2] NULL,
   [dtCheckedOutUTC] [datetime] NULL,
   [dtCheckedOutEST] [datetime] NULL,
   [V2CheckOutTime] [datetime2] NULL,
   [IsProcessed] [bit] NULL

   ,CONSTRAINT [PK_TempAppointmentsCheckinTimeUTCToEST] PRIMARY KEY CLUSTERED ([id])
)


GO
