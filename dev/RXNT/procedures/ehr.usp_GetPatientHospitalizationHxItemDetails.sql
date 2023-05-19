SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/14/2022
-- Description:	Get Hospitalization Hx Details from Hospitalization Hx Id
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientHospitalizationHxItemDetails]
	@PatientId BIGINT,
	@HospitalizationHxId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		hosphx.hosphxid,
		hosphx.pat_id,
		hosphx.problem,
		hosphx.dr_id,
		hosphx.added_by_dr_id,
		hosphx.created_on,
		hosphx.last_modified_on,
		hosphx.last_modified_by,
		hosphx.enable,
		hosphx.icd10,
		hosphx.icd10_description,
		hosphx.snomed,
		hosphx.snomed_description,
		hosphx.source
	FROM patient_hospitalization_hx hosphx WITH (NOLOCK)
	WHERE hosphx.pat_id = @PatientId
		AND hosphx.hosphxid = @HospitalizationHxId
		AND enable = 1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
