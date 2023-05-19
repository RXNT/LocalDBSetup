SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 08-Jul-2016
-- Description:	Search patient Family Hx
-- Modified By: JahabarYusuff M(member_relation_id field process null to 0)
-- Modified Date: 26-Apr-2019
-- Description:	Remove icd9
-- Modified By: JahabarYusuff M
-- Modified Date: 31-Nov-2022
-- =============================================
CREATE   PROCEDURE [ehr].[usp_SearchPatientFamilyHx]
	@PatientId BIGINT
AS

BEGIN
	SELECT fhx.fhxid, fhx.pat_id,ISNULL(fhx.member_relation_id, 0 ) member_relation_id,fhx.problem,fhx.dr_id,fhx.added_by_dr_id,fhx.created_on,fhx.last_modified_on,fhx.last_modified_by,fhx.enable,
	  fhx.icd10, fhx.icd10_description, fhx.snomed, fhx.snomed_description,fhx.LivingStatus, fhx.visibility_hidden_to_patient
	FROM patient_family_hx fhx with(nolock)
	WHERE fhx.pat_id = @PatientId
	ORDER BY fhx.enable DESC,fhx.created_on DESC, fhx.fhxid DESC
	
	SELECT pat_hx_id,pat_id,has_nofhx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId
	
	SELECT TOP 1 familyhx_other FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1 ORDER BY sochxid DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
