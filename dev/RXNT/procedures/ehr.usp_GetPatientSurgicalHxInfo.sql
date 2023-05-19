SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/13/2022
-- Description:	Get Surgical History info for a Patient
-- =============================================

CREATE PROCEDURE [ehr].[usp_GetPatientSurgicalHxInfo] 
	@PatientId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		pat_hx_id,
		pat_id,
		has_nosurghx
	FROM patient_hx WITH (NOLOCK)
	WHERE pat_id = @PatientId

	SELECT TOP 1 surgeryhx_other
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
