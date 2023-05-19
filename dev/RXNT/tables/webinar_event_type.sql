CREATE TABLE [dbo].[webinar_event_type] (
   [EventTypeID] [int] NOT NULL
      IDENTITY (1,1),
   [EventType] [varchar](max) NULL

   ,CONSTRAINT [PK_webinar_event_type] PRIMARY KEY CLUSTERED ([EventTypeID])
)


GO
