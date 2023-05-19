SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 23-Feb-2018
-- Description:	To get the patient Social Hx Smoking Status
-- Last Modified By	:   JahabarYusuff M
-- Description			:	Load SNOMED Code
-- Last Modifed Date	:	08-Nov-2022
-- =============================================
CREATE   PROCEDURE [phr].[usp_GetPatientSocialHxSmokingStatus]    
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT 
		pssd.PatientSmokingStatusDetailExtId, 
		pssd.PatientId as PatientId,
		ATS.Code as Code,
		ATS.Description as Description,
		pssd.StartDate,
		pssd.EndDate,
		pssd.Active,SLC.Code as SNOMED, 0 as visibility_hidden_to_patient
	FROM ehr.PatientSmokingStatusDetailExternal pssd WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTableConstants ATS WITH(NOLOCK) ON CONVERT(VARCHAR(12), pssd.SmokingStatusCode) = ATS.Code
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId=ATS.ApplicationTableId
	LEFT JOIN ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATS.Code  AND ATS.ApplicationTableConstantId = SLC.ApplicationTableConstantId

	WHERE pssd.PatientId= @PatientId AND  AT.Code='SMOKE'
	UNION 
	SELECT 
		pfd.pa_flag_id as PatientSmokingStatusDetailExtId, 
		pfd.pa_id as PatientId,
		ATS.Code as Code,
		ATS.Description as Description,
		pssd.StartDate,
		pssd.EndDate,
		pssd.Active,SLC.Code as SNOMED, pfd.visibility_hidden_to_patient
	FROM dbo.patient_flag_details pfd WITH(NOLOCK)
	LEFT JOIN ehr.PatientSmokingStatusDetail pssd WITH(NOLOCK) ON pfd.pa_flag_id=pssd.Pa_Flag_Id
	INNER JOIN ehr.ApplicationTableConstants ATS WITH(NOLOCK) ON CONVERT(VARCHAR(12), pfd.flag_id) = ATS.Code
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId=ATS.ApplicationTableId
	LEFT join ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATS.Code  AND ATS.ApplicationTableConstantId = SLC.ApplicationTableConstantId
	WHERE pfd.pa_id = @PatientId AND  AT.Code='SMOKE'

	ORDER BY PatientSmokingStatusDetailExtId DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
