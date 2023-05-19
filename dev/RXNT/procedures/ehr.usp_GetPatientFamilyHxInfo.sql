SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/14/2022
-- Description:	Get Patient Family Hx Info
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientFamilyHxInfo] 
	@PatientId BIGINT
AS
BEGIN
	SELECT pat_hx_id,
		pat_id,
		has_nofhx
	FROM patient_hx WITH (NOLOCK)
	WHERE pat_id = @PatientId

	SELECT TOP 1 familyhx_other
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
