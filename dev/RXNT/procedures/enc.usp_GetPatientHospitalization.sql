SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	To Search the patient Hospitalization Hx
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [enc].[usp_GetPatientHospitalization] --38835763 
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT hosphx.hosphxid, hosphx.pat_id,hosphx.problem,hosphx.icd9,hosphx.dr_id,hosphx.added_by_dr_id,hosphx.created_on,hosphx.last_modified_on,hosphx.last_modified_by,hosphx.enable,
	hosphx.icd9_description, hosphx.icd10, hosphx.icd10_description, hosphx.snomed, hosphx.snomed_description
	FROM patient_hospitalization_hx hosphx WITH(NOLOCK)
	WHERE hosphx.pat_id = @PatientId AND hosphx.enable=1 
	ORDER BY hosphx.enable DESC,hosphx.created_on DESC, hosphx.hosphxid DESC
	
	SELECT sochx.hospitalizationhx_other AS hosphx_other 
	FROM patient_social_hx sochx WITH(NOLOCK) 
	WHERE sochx.pat_id = @PatientId AND sochx.enable=1 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
