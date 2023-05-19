CREATE TABLE [dbo].[scheduled_events_exclusions] (
   [see_id] [int] NOT NULL
      IDENTITY (1,1),
   [se_id] [int] NOT NULL,
   [exclusion_date] [datetime] NOT NULL

   ,CONSTRAINT [PK_scheduled_events_exclusions] PRIMARY KEY CLUSTERED ([see_id])
)


GO
