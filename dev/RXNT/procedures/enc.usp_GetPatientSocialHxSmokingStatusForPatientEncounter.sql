SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [enc].[usp_GetPatientSocialHxSmokingStatusForPatientEncounter]    
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT 
		pfd.pa_flag_id as PatientFlagDetailId, 
		pfd.flag_id as FlagId,
		pfd.pa_id as PatientId,
		ATS.Code as Code,
		ATS.Description as Description,
		pssd.StartDate,
		pssd.EndDate
	FROM patient_flag_details pfd WITH(NOLOCK)
	LEFT JOIN ehr.PatientSmokingStatusDetail pssd ON pfd.pa_flag_id=pssd.Pa_Flag_Id
	INNER JOIN ehr.ApplicationTableConstants ATS ON CONVERT(VARCHAR(12), pfd.flag_id) = ATS.Code
	INNER JOIN ehr.ApplicationTables AT ON AT.ApplicationTableId=ATS.ApplicationTableId
	WHERE pfd.pa_id = @PatientId AND  AT.Code='SMOKE'
	ORDER BY pfd.pa_flag_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
