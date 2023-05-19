SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 20-Jul-2016
-- Description:	To Search the patient Surgery Hx
-- Description:	Remove icd9
-- Modified By: JahabarYusuff M
-- Modified Date: 31-Nov-2022
-- =============================================

CREATE   PROCEDURE [ehr].[usp_SearchPatientSurgicalHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT surhx.surghxid, surhx.pat_id,surhx.problem, surhx.dr_id,surhx.added_by_dr_id,surhx.created_on,surhx.last_modified_on,surhx.last_modified_by,surhx.enable,
	  surhx.icd10, surhx.icd10_description, surhx.snomed, surhx.snomed_description,surhx.source, surhx.visibility_hidden_to_patient
	FROM patient_surgery_hx surhx WITH(NOLOCK)
	WHERE surhx.pat_id = @PatientId
	ORDER BY surhx.enable DESC,surhx.created_on DESC, surhx.surghxid DESC
	
	SELECT pat_hx_id,pat_id,has_nosurghx FROM 
	patient_hx WITH(NOLOCK) where pat_id = @PatientId	

	
	SELECT TOP 1 surgeryhx_other FROM patient_social_hx WITH(NOLOCK) WHERE pat_id=@PatientId AND enable=1 ORDER BY sochxid DESC
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
