SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/14/2022
-- Description:	Get Hospitalization Hx Info from Patient Id
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientHospitalizationHxInfo]
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT pat_hx_id,
		pat_id,
		has_nohosphx
	FROM patient_hx WITH (NOLOCK)
	WHERE pat_id = @PatientId

	SELECT TOP 1 hospitalizationhx_other
	FROM patient_social_hx WITH (NOLOCK)
	WHERE pat_id = @PatientId
		AND enable = 1
	ORDER BY sochxid DESC

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
