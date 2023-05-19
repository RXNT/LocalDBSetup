CREATE TABLE [dbo].[webinar_transmittals] (
   [transmit_id] [int] NOT NULL
      IDENTITY (1,1),
   [webinar_id] [int] NOT NULL,
   [start_time] [smalldatetime] NOT NULL,
   [type] [tinyint] NOT NULL,
   [is_processed] [bit] NOT NULL

   ,CONSTRAINT [PK_webinar_transmittals] PRIMARY KEY CLUSTERED ([transmit_id])
)

CREATE NONCLUSTERED INDEX [IX_webinar_transmittals] ON [dbo].[webinar_transmittals] ([is_processed], [webinar_id], [start_time])

GO
