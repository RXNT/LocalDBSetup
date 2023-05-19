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

CREATE PROCEDURE [ehr].[usp_SearchPatientExternalMedicalHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT med.pme_medhxid, med.pme_pat_id,med.pme_problem,med.pme_icd9,
	med.pme_dr_id,med.pme_added_by_dr_id,med.pme_created_on,med.pme_enable,
	med.pme_icd9_description, med.pme_icd10, med.pme_icd10_description, 
	med.pme_snomed, med.pme_snomed_description,med.last_modified_date,pme_source, med.visibility_hidden_to_patient
	FROM patient_medical_hx_external med WITH(NOLOCK)
	WHERE med.pme_pat_id = @PatientId
	ORDER BY med.pme_enable DESC,med.pme_created_on DESC, med.pme_medhxid DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
