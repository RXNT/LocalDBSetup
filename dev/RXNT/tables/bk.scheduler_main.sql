CREATE TABLE [bk].[scheduler_main] (
   [event_id] [int] NOT NULL,
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
   [created_date] [datetime] NOT NULL,
   [active] [bit] NULL,
   [last_modified_date] [datetime] NULL,
   [last_modified_by] [int] NULL,
   [pa_merge_reqid] [bigint] NULL,
   [PatientUnmergeRequestId] [bigint] NULL
)


GO
