SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	To Search the patient Hospitalization Hx
-- Description:	Remove icd9
-- Modified By: JahabarYusuff M
-- Modified Date: 31-Nov-2022
-- =============================================

CREATE   PROCEDURE [ehr].[usp_SearchPatientHospitalizationHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT hosphx.hosphxid, hosphx.pat_id,hosphx.problem,hosphx.dr_id,hosphx.added_by_dr_id,hosphx.created_on,hosphx.last_modified_on,hosphx.last_modified_by,hosphx.enable,
	 hosphx.icd10, hosphx.icd10_description, hosphx.snomed, hosphx.snomed_description,hosphx.source, hosphx.visibility_hidden_to_patient
	FROM patient_hospitalization_hx hosphx WITH(NOLOCK)
	WHERE hosphx.pat_id = @PatientId AND enable=1
	ORDER BY hosphx.enable DESC,hosphx.created_on DESC, hosphx.hosphxid DESC
	
	SELECT pat_hx_id,pat_id,has_nohosphx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId	

	SELECT TOP 1 hospitalizationhx_other FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1 ORDER BY sochxid DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
