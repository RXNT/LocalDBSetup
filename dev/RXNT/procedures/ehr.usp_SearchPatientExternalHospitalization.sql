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

CREATE PROCEDURE [ehr].[usp_SearchPatientExternalHospitalization]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT hosphx.phe_hosphxid, hosphx.phe_pat_id,hosphx.phe_problem,hosphx.phe_icd9,
	hosphx.phe_dr_id,hosphx.phe_added_by_dr_id,hosphx.phe_created_on,hosphx.last_modified_on,hosphx.last_modified_by,hosphx.phe_enable,
	hosphx.phe_icd9_description, hosphx.phe_icd10, hosphx.phe_icd10_description, 
	hosphx.phe_snomed, hosphx.phe_snomed_description,phe_source
	FROM patient_hospitalization_hx_external hosphx WITH(NOLOCK)
	WHERE hosphx.phe_pat_id = @PatientId
	ORDER BY hosphx.phe_enable DESC,hosphx.phe_created_on DESC, hosphx.phe_hosphxid DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
