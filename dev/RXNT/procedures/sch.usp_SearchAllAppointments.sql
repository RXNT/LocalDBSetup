SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Rasheed
-- Create date	: 21-SEP-2015
-- Description	: to fetch doctor appointments
-- Modified By	: 
-- Modified Date:
-- =============================================
CREATE PROCEDURE [sch].[usp_SearchAllAppointments]
@dc_id AS BIGINT,
@dg_id AS BIGINT,
@dr_id AS BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT
		SCH.event_id,
	  SCH.reason,
	  SCH.dr_id,
	  SCH.ext_link_id,
	  SCH.detail_header,
	  sch.event_start_date,
	  sch.event_end_date,
	  SCH.status,
	  SCH.note,
	  SCH.dtCalled,
	  SCH.dtCheckIn,
	  SCH.dtCheckedOut,
	  SCH.dtintake,
	  SCH.room_id,
	  ISNULL(DR.dr_last_name, '') + ' ' + ISNULL(DR.dr_first_name, '') + ' ' + ISNULL(DR.dr_middle_initial, '') AS DoctorFullName,
	  SCHT.type_text,
	  SCHT.color,
	  '#000000' AS back_color,
	  DATEDIFF(MINUTE, sch.event_start_date, sch.event_end_date) AS duration,
	  SCHR.room_name,
	  DG.dg_id,
	  DG.dc_id,
	  ISNULL(DR.time_difference, 0) AS time_difference
	FROM scheduler_main SCH WITH (NOLOCK)
	LEFT OUTER JOIN scheduler_types SCHT WITH (NOLOCK) ON SCH.type = SCHT.scheduler_type_id
	LEFT OUTER JOIN scheduler_rooms SCHR WITH (NOLOCK) ON SCH.room_id = SCHR.room_id
	INNER JOIN patients PAT WITH (NOLOCK) ON SCH.ext_link_id = PAT.pa_id
	INNER JOIN doctors DR WITH (NOLOCK) ON SCH.dr_id = DR.dr_id
	INNER JOIN doc_groups DG WITH (NOLOCK) ON DR.dg_id = DG.dg_id
	WHERE SCH.dr_id = @dr_id
	AND DR.dg_id = @dg_id
	AND DG.dc_id = @dc_id
	AND
	--PAT.dg_id = @dg_id AND											
	(recurrence IS NULL
	OR LEN(recurrence) < 2)
	AND ext_link_id > 0
	AND sch.event_start_date > '2015-01-01'
 END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
