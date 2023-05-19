SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	To Search the patient Surgical Hx
-- Modified By: JahabarYusuff M
-- Modified Date: 07-Nov-2022
-- Description:	get Patient Surgical hx from EHR
-- =============================================

CREATE   PROCEDURE [phr].[usp_SearchPatientSurgicalHx_External]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 SELECT surg.pse_surghxid, surg.pse_pat_id,surg.pse_problem,
	surg.pse_dr_id,surg.pse_added_by_dr_id,surg.pse_created_on,surg.pse_enable,
	  surg.pse_icd10, surg.pse_icd10_description, surg.pse_snomed,
	 surg.pse_snomed_description,surg.last_modified_on, 0 as visibility_hidden_to_patient
	FROM patient_surgery_hx_external surg WITH(NOLOCK)
	WHERE surg.pse_pat_id = @PatientId
 
	UNION
	SELECT surhx.surghxid as pse_surghxid, surhx.pat_id as pse_pat_id,surhx.problem as pse_problem, surhx.dr_id as pse_dr_id,surhx.added_by_dr_id as  pse_added_by_dr_id,
	surhx.created_on as pse_created_on, surhx.enable as pse_enable,
	 surhx.icd10 as pse_icd10, surhx.icd10_description as pse_icd10_description, surhx.snomed as pse_snomed, surhx.snomed_description as pse_snomed_description, surhx.last_modified_on as last_modified_on,surhx.visibility_hidden_to_patient
	FROM patient_surgery_hx surhx WITH(NOLOCK)
	WHERE surhx.pat_id = @PatientId
	ORDER BY pse_enable DESC,pse_created_on DESC, pse_surghxid DESC
	
	SELECT pat_hx_id,pat_id,has_nohosphx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
