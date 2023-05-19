SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	To Search the patient Medical Hx
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	get Patient medical hx from EHR
-- =============================================

CREATE   PROCEDURE [phr].[usp_SearchPatientMedicalHx_External]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT med.pme_medhxid, med.pme_pat_id,med.pme_problem,
	med.pme_dr_id,med.pme_added_by_dr_id,med.pme_created_on,med.pme_enable,
	 med.pme_icd10, med.pme_icd10_description, med.pme_snomed,
	 med.pme_snomed_description,med.last_modified_date, 0  as visibility_hidden_to_patient
	FROM patient_medical_hx_external med WITH(NOLOCK)
	WHERE med.pme_pat_id = @PatientId
	UNION
   SELECT medhx.medhxid as pme_medhxid, medhx.pat_id as pme_pat_id,medhx.problem as pme_problem,
   medhx.dr_id as pme_dr_id,medhx.added_by_dr_id as pme_added_by_dr_id,medhx.created_on as pme_created_on,medhx.enable as pme_enable,
	 medhx.icd10 as pme_icd10, medhx.icd10_description as pme_icd10_description,
	 medhx.snomed as pme_snomed_description, medhx.snomed_description as pme_snomed_description , medhx.last_modified_on as last_modified_date,medhx.visibility_hidden_to_patient
	FROM patient_medical_hx medhx WITH(NOLOCK)
	WHERE medhx.pat_id = @PatientId

	ORDER BY pme_enable DESC,pme_created_on DESC, pme_medhxid DESC
	
	SELECT pat_hx_id,pat_id,has_nohosphx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
