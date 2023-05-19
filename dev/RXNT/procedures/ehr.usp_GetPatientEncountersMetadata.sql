SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/30/2022
-- Description:	Get patient encounter metadata using patient id and doctor group id
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientEncountersMetadata] 
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
	@DoctorGroupId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		enc_id,
		enc_date,
		chief_complaint
	FROM enchanced_encounter enc WITH(NOLOCK) 
	JOIN patients pat WITH(NOLOCK) on enc.patient_id = pat.pa_id
	WHERE enc.patient_id = @PatientId and pat.dg_id = @DoctorGroupId
	ORDER BY enc_date DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
