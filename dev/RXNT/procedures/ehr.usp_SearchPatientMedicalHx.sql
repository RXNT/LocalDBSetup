SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 25-Jan-2016
-- Description:	To Search the patient Medical Hx
-- Description:	Remove icd9
-- Modified By: JahabarYusuff M
-- Modified Date: 31-Nov-2022
-- =============================================
CREATE   PROCEDURE [ehr].[usp_SearchPatientMedicalHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT medhx.medhxid, medhx.pat_id,medhx.problem,medhx.dr_id,medhx.added_by_dr_id,medhx.created_on,medhx.last_modified_on,medhx.last_modified_by,medhx.enable,
	medhx.icd10, medhx.icd10_description,
	 medhx.snomed, medhx.snomed_description ,medhx.source, medhx.visibility_hidden_to_patient
	FROM patient_medical_hx medhx WITH(NOLOCK)
	WHERE medhx.pat_id = @PatientId
	ORDER BY medhx.enable DESC,medhx.created_on DESC, medhx.medhxid DESC
	
	SELECT pat_hx_id,pat_id,has_nomedx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId	

	SELECT TOP 1 medicalhx_other FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1 ORDER BY sochxid DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
