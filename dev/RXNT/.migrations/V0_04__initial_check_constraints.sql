﻿ALTER TABLE [dbo].[doc_group_freetext_meds] WITH CHECK ADD CONSTRAINT [IgnoreFDBDrugId] CHECK  ([drug_id]>(999999))
GO
ALTER TABLE [dbo].[real_world_testing_log] WITH CHECK ADD CONSTRAINT [CK__real_worl__event__name] CHECK  ([event_name]='UnKnown' OR [event_name]='QRDA Generated' OR [event_name]='PHR Health Summary Email' OR [event_name]='New Immunization Record' OR [event_name]='Bulk CCD Requests' OR [event_name]='Bulk CCD Requests by Timeframe' OR [event_name]='Patient API - All Data Request' OR [event_name]='Immunization History Received' OR [event_name]='Patient API - Data Category Request' OR [event_name]='Patient API - Patient Selection' OR [event_name]='Direct Email CCD - Received' OR [event_name]='Direct Email CCD - Sent' OR [event_name]='Direct Email Received' OR [event_name]='Direct Email Sent' OR [event_name]='Invalid CCD Received')
GO
ALTER TABLE [dbo].[real_world_testing_log] WITH CHECK ADD CONSTRAINT [CK__real_worl__event__status] CHECK  ([event_status]='UnKnown' OR [event_status]='Fail' OR [event_status]='Success')
GO
