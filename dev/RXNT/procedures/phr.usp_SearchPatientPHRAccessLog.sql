SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Prabhash
Create date			:	07-December-2017
Description			:	Search patient activity log
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SearchPatientPHRAccessLog]
(
	@DoctorCompanyId    BIGINT          = NULL,
	@PatientId          BIGINT          = NULL,
    @Type               BIGINT    		= NULL,
    @StartDate          DATETIME        = NULL,
    @EndDate            DATETIME        = NULl
)
AS
BEGIN
	SELECT	PPAL.phr_access_log_id,
			PPAL.phr_access_type, 
			PPAL.phr_access_Description, 
			PPAL.phr_access_datetime,
			PPAL.PatientRepresentativeId,
			PR.FirstName,
			PR.LastName,
			PR.MiddleInitial
	FROM	dbo.patient_phr_access_log PPAL WITH (NOLOCK)
			LEFT JOIN phr.PatientRepresentatives PR WITH(NOLOCK) ON PPAL.PatientRepresentativeId = PR.PatientRepresentativeId
    WHERE  (PPAL.phr_access_type = @Type OR ISNULL(@Type, 0) = 0) AND
			(PPAL.pa_id = @PatientId OR ISNULL(@PatientId, 0) = 0) AND
			((@StartDate IS NULL AND @EndDate IS NULL) OR ( DATEADD(D, 0, DATEDIFF(D, 0, PPAL.phr_access_datetime)) BETWEEN DATEADD(D, 0, DATEDIFF(D, 0, @StartDate)) AND DATEADD(D, 0, DATEDIFF(D, 0, @EndDate))))
	ORDER BY PPAL.phr_access_datetime DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
