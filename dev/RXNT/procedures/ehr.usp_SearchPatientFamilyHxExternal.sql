SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 23-Feb-2018
-- Description:	Search patient Family Hx External
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientFamilyHxExternal]
	@PatientId BIGINT
AS

BEGIN
	SELECT fhx.pfhe_fhxid, fhx.pfhe_pat_id,fhx.pfhe_member_relation_id,fhx.pfhe_problem,
	fhx.pfhe_icd9,fhx.pfhe_dr_id,fhx.pfhe_added_by_dr_id,fhx.pfhe_created_on,
	fhx.last_modified_on,fhx.last_modified_by,fhx.pfhe_enable,
	fhx.pfhe_icd9_description, fhx.pfhe_icd10, fhx.pfhe_icd10_description,
	 fhx.pfhe_snomed, fhx.pfhe_snomed_description
	FROM patient_family_hx_external fhx with(nolock)
	WHERE fhx.pfhe_pat_id = @PatientId
	ORDER BY fhx.pfhe_enable DESC,fhx.pfhe_created_on DESC, fhx.pfhe_fhxid DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
