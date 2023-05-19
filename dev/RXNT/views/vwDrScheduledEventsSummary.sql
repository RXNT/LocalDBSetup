SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  VIEW [dbo].[vwDrScheduledEventsSummary]
AS
SELECT     se_id, next_fire_date, event_type, for_user_id, entry_user_id, event_text, repeat_unit, repeat_interval, repeat_count, first_fire_date
FROM         dbo.scheduled_events
WHERE     (event_type = 65536 OR
                      event_type = 131072 OR
                      event_type = 196608)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
