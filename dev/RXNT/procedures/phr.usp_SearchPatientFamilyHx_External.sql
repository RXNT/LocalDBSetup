SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 22-02-2018
-- Description:	Search patient Family Hx External
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	get Patient Falimy hx from EHR
-- =============================================
CREATE   PROCEDURE [phr].[usp_SearchPatientFamilyHx_External]
	@PatientId BIGINT
AS

BEGIN
	SELECT fhx.fhxid as pfhe_fhxid, fhx.pat_id as pfhe_pat_id,ISNULL(fhx.member_relation_id, 0 ) pfhe_member_relation_id,
	fhx.problem as pfhe_problem,fhx.dr_id as pfhe_dr_id,fhx.added_by_dr_id as pfhe_added_by_dr_id,fhx.created_on as pfhe_created_on,fhx.last_modified_on as last_modified_on,
	fhx.last_modified_by,fhx.enable as pfhe_enable,
	 fhx.icd10 as pfhe_icd10, fhx.icd10_description as pfhe_icd10_description, fhx.snomed as pfhe_snomed, fhx.snomed_description as pfhe_snomed_description ,fhx.visibility_hidden_to_patient
	FROM patient_family_hx fhx with(nolock)
	WHERE fhx.pat_id = @PatientId
	UNION
	SELECT fhx.pfhe_fhxid, fhx.pfhe_pat_id,fhx.pfhe_member_relation_id,fhx.pfhe_problem,
	 fhx.pfhe_dr_id,fhx.pfhe_added_by_dr_id,fhx.pfhe_created_on,
	fhx.last_modified_on,fhx.last_modified_by,fhx.pfhe_enable,
	 fhx.pfhe_icd10, fhx.pfhe_icd10_description,
	 fhx.pfhe_snomed, fhx.pfhe_snomed_description, 0 as visibility_hidden_to_patient
	FROM patient_family_hx_external fhx with(nolock)
	WHERE fhx.pfhe_pat_id = @PatientId
	ORDER BY pfhe_enable DESC,pfhe_created_on DESC, pfhe_fhxid DESC	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
