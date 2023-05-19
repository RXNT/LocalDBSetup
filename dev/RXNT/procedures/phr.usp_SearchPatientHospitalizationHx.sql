SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	To Search the patient Hospitalization Hx
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	get Patient Hospitalization hx from EHR
-- =============================================

CREATE   PROCEDURE [phr].[usp_SearchPatientHospitalizationHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT hosphx.phe_hosphxid, hosphx.phe_pat_id,hosphx.phe_problem, 
	hosphx.phe_dr_id,hosphx.phe_added_by_dr_id,hosphx.phe_created_on,hosphx.last_modified_on,
	hosphx.last_modified_by,hosphx.phe_enable,
	 hosphx.phe_icd10, hosphx.phe_icd10_description, hosphx.phe_snomed,
	 hosphx.phe_snomed_description, 0 as visibility_hidden_to_patient
	FROM patient_hospitalization_hx_external hosphx WITH(NOLOCK)
	WHERE hosphx.phe_pat_id = @PatientId
	UNION
	SELECT hosphx.hosphxid as phe_hosphxid, hosphx.pat_id as phe_pat_id,hosphx.problem as phe_problem, hosphx.dr_id as phe_dr_id,
	hosphx.added_by_dr_id as phe_added_by_dr_id,hosphx.created_on as phe_created_on,hosphx.last_modified_on,hosphx.last_modified_by,hosphx.enable as phe_enable,
	 hosphx.icd10, hosphx.icd10_description, hosphx.snomed as phe_snomed, hosphx.snomed_description as phe_snomed_description , hosphx.visibility_hidden_to_patient
	FROM patient_hospitalization_hx hosphx WITH(NOLOCK)
	WHERE hosphx.pat_id = @PatientId AND enable=1
	ORDER BY phe_enable DESC,phe_created_on DESC, phe_hosphxid DESC
	
	SELECT pat_hx_id,pat_id,has_nohosphx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
