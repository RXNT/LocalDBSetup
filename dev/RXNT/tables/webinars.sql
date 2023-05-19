CREATE TABLE [dbo].[webinars] (
   [event_id] [int] NOT NULL
      IDENTITY (1,1),
   [event_start] [smalldatetime] NOT NULL,
   [event_end] [smalldatetime] NOT NULL,
   [sales_person] [smallint] NOT NULL,
   [slots_left] [smallint] NOT NULL,
   [confcallno] [varchar](25) NOT NULL,
   [accesscode] [varchar](25) NOT NULL,
   [meetingid] [varchar](25) NOT NULL,
   [meetingURL] [varchar](2000) NOT NULL,
   [activeFlag] [bit] NOT NULL,
   [eventtype_id] [int] NOT NULL

   ,CONSTRAINT [PK_webinars] PRIMARY KEY CLUSTERED ([event_id])
)

CREATE NONCLUSTERED INDEX [IX_MAIN] ON [dbo].[webinars] ([event_id], [event_start], [event_end])

GO
