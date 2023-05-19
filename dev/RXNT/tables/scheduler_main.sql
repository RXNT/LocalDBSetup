CREATE TABLE [dbo].[scheduler_main] (
   [event_id] [int] NOT NULL
      IDENTITY (1,1),
   [event_start_date] [datetime] NOT NULL,
   [dr_id] [int] NOT NULL,
   [type] [smallint] NOT NULL,
   [ext_link_id] [int] NOT NULL,
   [note] [varchar](100) NOT NULL,
   [detail_header] [varchar](200) NOT NULL,
   [event_end_date] [datetime] NOT NULL,
   [is_new_pat] [bit] NOT NULL,
   [recurrence] [varchar](1024) NULL,
   [recurrence_parent] [int] NULL,
   [status] [tinyint] NOT NULL,
   [dtCheckIn] [datetime] NULL,
   [dtCalled] [datetime] NULL,
   [dtCheckedOut] [datetime] NULL,
   [dtintake] [smalldatetime] NULL,
   [case_id] [int] NULL,
   [room_id] [int] NULL,
   [reason] [varchar](125) NULL,
   [is_confirmed] [bit] NULL,
   [discharge_disposition_code] [varchar](2) NULL,
   [is_delete_attempt] [bit] NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL

   ,CONSTRAINT [PK_scheduler_main] PRIMARY KEY NONCLUSTERED ([event_id])
)

CREATE CLUSTERED INDEX [DRID] ON [dbo].[scheduler_main] ([dr_id])
CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[scheduler_main] ([event_start_date], [dr_id], [ext_link_id], [event_end_date], [type], [case_id], [room_id])
CREATE NONCLUSTERED INDEX [IX_scheduler_main-ext_link_id] ON [dbo].[scheduler_main] ([ext_link_id])

GO
