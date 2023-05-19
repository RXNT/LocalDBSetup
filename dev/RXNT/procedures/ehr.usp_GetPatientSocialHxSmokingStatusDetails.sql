SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/13/2022
-- Description:	Get Patient Smoking Hx Status Details 
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientSocialHxSmokingStatusDetails]
	-- Add the parameters for the stored procedure here
	@PatientFlagDetailId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		pfd.pa_flag_id AS PatientFlagDetailId,
		pfd.flag_id AS FlagId,
		pfd.pa_id AS PatientId,
		ATS.Code AS Code,
		ATS.Description AS Description,
		pssd.StartDate,
		pssd.EndDate,
		SLC.Code AS SNOMED
	FROM dbo.patient_flag_details pfd WITH (NOLOCK)
	LEFT JOIN ehr.PatientSmokingStatusDetail pssd WITH (NOLOCK) ON pfd.pa_flag_id = pssd.Pa_Flag_Id
	INNER JOIN ehr.ApplicationTableConstants ATS WITH (NOLOCK) ON CONVERT(VARCHAR(12), pfd.flag_id) = ATS.Code
	INNER JOIN ehr.ApplicationTables AT WITH (NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId
	LEFT JOIN ehr.SysLookupCodes SLC WITH (NOLOCK) ON SLC.ApplicationTableConstantCode = ATS.Code
		AND ATS.ApplicationTableConstantId = SLC.ApplicationTableConstantId
	WHERE
		pfd.pa_flag_id = @PatientFlagDetailId
		AND pfd.pa_id = @PatientId
		AND AT.Code = 'SMOKE'
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
