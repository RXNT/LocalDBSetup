SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 31-OCT-2016
-- Description:	To get the patient Social Hx Smoking Status
-- Last Modified By	:   JahabarYusuff M
-- Description			:	Load SNOMED Code
-- Last Modifed Date	:	08-Nov-2022
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientSocialHxSmokingStatus]  
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
		pssd.EndDate,SLC.Code as SNOMED,pfd.visibility_hidden_to_patient
	FROM dbo.patient_flag_details pfd WITH(NOLOCK)
	LEFT JOIN ehr.PatientSmokingStatusDetail pssd WITH(NOLOCK) ON pfd.pa_flag_id=pssd.Pa_Flag_Id
	INNER JOIN ehr.ApplicationTableConstants ATS WITH(NOLOCK) ON CONVERT(VARCHAR(12), pfd.flag_id) = ATS.Code
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId=ATS.ApplicationTableId
	LEFT join ehr.SysLookupCodes SLC WITH(NOLOCK) ON SLC.ApplicationTableConstantCode = ATS.Code  AND ATS.ApplicationTableConstantId = SLC.ApplicationTableConstantId
	WHERE pfd.pa_id = @PatientId AND  AT.Code='SMOKE'
	ORDER BY pfd.pa_flag_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
