SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 23-Mar-2015
-- Description	: to fetch scheduler data migration request appointments
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [adm].[usp_SearchSchedulerDataMigrationAppointments]
@dg_id AS BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT SCH.event_id, SCH.reason, SCHT.type_text, SCH.dr_id, SCH.ext_link_id, sch.event_start_date, sch.event_end_date, SCH.status, SCH.note,
	ISNULL(DR.dr_last_name,'')	+ ' ' + ISNULL(DR.dr_first_name,'') + ' ' + ISNULL(DR.dr_middle_initial,'') As DoctorFullName
	FROM scheduler_main SCH WITH(NOLOCK)  
	LEFT OUTER JOIN scheduler_types SCHT  WITH(NOLOCK) ON SCH.type = SCHT.scheduler_type_id 
	INNER JOIN doctors DR WITH(NOLOCK) ON SCH.dr_id=DR.dr_id  
	INNER JOIN [adm].[SchedulerDataMigrationRequests] SDMR WITH(NOLOCK) ON SDMR.dg_id = DR.dg_id 
	LEFT OUTER JOIN [adm].[MigratedAppointments] MA WITH(NOLOCK) ON MA.request_id = SDMR.request_id AND SCH.event_id = MA.event_id 
	WHERE SDMR.status = 1 AND  
	SDMR.migrated_on IS NULL AND 
	(MA.event_id IS NULL  OR ISNULL(MA.retry_count,0)<3 AND MA.status=3) AND
	SDMR.dg_id=@dg_id AND 
	(recurrence IS NULL OR LEN(recurrence) < 2) AND ext_link_id >0
 
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
