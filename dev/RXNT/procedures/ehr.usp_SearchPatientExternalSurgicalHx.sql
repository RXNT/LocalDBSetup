SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 7-Feb-2018
-- Description:	To Search the patient Surgical Hx
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_SearchPatientExternalSurgicalHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT surg.pse_surghxid, surg.pse_pat_id,surg.pse_problem,surg.pse_icd9,
	surg.pse_dr_id,surg.pse_added_by_dr_id,surg.pse_created_on,surg.pse_enable,
	surg.pse_icd9_description, surg.pse_icd10, surg.pse_icd10_description, 
	surg.pse_snomed, surg.pse_snomed_description,surg.last_modified_on,surg.pse_source
	FROM patient_surgery_hx_external surg WITH(NOLOCK)
	WHERE surg.pse_pat_id = @PatientId
	ORDER BY surg.pse_enable DESC,surg.pse_created_on DESC, surg.pse_surghxid DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
