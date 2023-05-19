SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
Create TRIGGER scheduled_events_DTrig ON dbo.scheduled_events FOR DELETE AS
DELETE scheduled_events_exclusions 
FROM deleted, scheduled_events_exclusions 
WHERE deleted.se_id = scheduled_events_exclusions.se_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[scheduled_events_DTrig] ON [dbo].[scheduled_events]
GO

GO
