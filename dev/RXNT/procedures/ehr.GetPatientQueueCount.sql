SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 10-May-2016
-- Description:	Get Patient Consent for the user
-- =============================================

CREATE PROCEDURE [ehr].[GetPatientQueueCount]
	@UserId BIGINT,
	@DoctorGroupId BIGINT
AS
BEGIN
	SELECT COUNT(1) AS Count
	FROM scheduler_main a WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) on a.dr_id=dr.dr_id 
	LEFT OUTER JOIN scheduler_rooms b WITH(NOLOCK) ON a.room_id = b.room_id 
	WHERE event_start_date > DATEADD(hh, -DATEPART(hh, GETDATE()), GETDATE()) and event_end_date <= DATEADD(hh, -DATEPART(hh, GETDATE()+1), GETDATE() + 1) 
	and dr.dg_id = @DoctorGroupId  
                            
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
