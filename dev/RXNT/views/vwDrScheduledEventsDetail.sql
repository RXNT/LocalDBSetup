SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   VIEW [dbo].[vwDrScheduledEventsDetail]
AS
SELECT     dbo.scheduled_events.se_id, dbo.scheduled_events.next_fire_date, dbo.scheduled_events.event_type, dbo.scheduled_events.for_user_id, 
                      dbo.scheduled_events.entry_user_id, dbo.scheduled_events.event_text, dbo.scheduled_events.repeat_unit, dbo.scheduled_events.repeat_interval, 
                      dbo.scheduled_events.repeat_count, dbo.scheduled_events.first_fire_date, dbo.prescription_details.drug_name, dbo.prescription_details.dosage, 
                      dbo.patients.pa_id,dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, dbo.prescription_details.pd_id, dbo.scheduled_events.fire_count
FROM         dbo.prescriptions INNER JOIN
                      dbo.prescription_details ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id INNER JOIN
                      dbo.patients ON dbo.prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
                      dbo.scheduled_events ON dbo.prescription_details.pd_id = dbo.scheduled_events.pd_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
