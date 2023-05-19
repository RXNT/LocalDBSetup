SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 25-Jan-2016
-- Description:	To get the patient Medical Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientMedicalHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT medhx.medhxid, medhx.pat_id,medhx.problem,medhx.icd9,medhx.dr_id,medhx.added_by_dr_id,medhx.created_on,medhx.last_modified_on,medhx.last_modified_by,medhx.enable,
	icd10, icd10_description, snomed
	FROM patient_medical_hx medhx WITH(NOLOCK)
	WHERE medhx.pat_id = @PatientId AND medhx.enable=1 
	ORDER BY medhx.created_on DESC 
	
	SELECT sochx.medicalhx_other
	FROM patient_social_hx sochx WITH(NOLOCK) 
	WHERE sochx.pat_id = @PatientId AND sochx.enable=1 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
