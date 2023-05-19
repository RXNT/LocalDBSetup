SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	05-SEPT-2018
Description			:	This procedure is used to Save Patient Email Log Info
Last Modified By	:   Ayja Weems
Last Modifed Date	:   26-Jan-2023
Last Modification   :   Return active access log data & email type code
=======================================================================================
*/

CREATE PROCEDURE [dbo].[usp_LoadPatientPortalRegistrationInfo]
	@DoctorCompanyId		BIGINT,
	@PatientId				BIGINT,
	@LoggedInUserId			BIGINT=0
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @UserTimeDifference AS INT=0
	IF (ISNULL(@LoggedInUserId ,0) > 0)
	BEGIN
		SELECT TOP 1 @UserTimeDifference = ISNULL(time_difference,0) FROM doctors WITH(NOLOCK)
		WHERE dr_id=@LoggedInUserId
	END
	SELECT TOP 1 DATEADD(HOUR, -@UserTimeDifference, log.CreatedDate) AS CreatedDate,
        atc.Code
	FROM [phr].[PatientEmailLogs] log
    INNER JOIN [RxNT].[ehr].[ApplicationTableConstants] atc on atc.ApplicationTableConstantId = log.Type
	WHERE	log.PatientId=@PatientId AND
			log.DoctorCompanyId=@DoctorCompanyId AND
			log.Active=1 
			ORDER BY CreatedDate DESC
   -- Get the Login Details of Patient
	SELECT TOP 1 DATEADD(HOUR, -@UserTimeDifference, phr_access_datetime) AS LastLoginDate
    FROM [patient_phr_access_log] 
    WHERE pa_id=@PatientId AND active = 1
	ORDER BY phr_access_datetime DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
