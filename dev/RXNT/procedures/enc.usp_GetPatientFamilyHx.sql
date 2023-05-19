SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 25-Jan-2016
-- Description:	To get the patient Family Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientFamilyHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT fhx.fhxid, fhx.pat_id,fhx.member_relation_id,fhx.problem,fhx.icd9,fhx.dr_id,fhx.added_by_dr_id,fhx.created_on,fhx.last_modified_on,fhx.last_modified_by,fhx.enable,
	icd10, icd10_description, snomed,fhx.LivingStatus
	FROM patient_family_hx fhx WITH(NOLOCK)
	WHERE fhx.pat_id = @PatientId AND fhx.enable=1 
	ORDER BY fhx.created_on DESC 
	
	SELECT sochx.familyhx_other
	FROM patient_social_hx sochx WITH(NOLOCK) 
	WHERE sochx.pat_id = @PatientId AND sochx.enable=1 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
