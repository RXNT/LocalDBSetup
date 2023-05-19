SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 25-Jan-2016
-- Description:	To get the patient Surgery Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetPatientSurgeryHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT surhx.surghxid, surhx.pat_id,surhx.problem,surhx.icd9,surhx.dr_id,surhx.added_by_dr_id,surhx.created_on,surhx.last_modified_on,surhx.last_modified_by,surhx.enable,
	icd10, icd10_description, snomed
	FROM patient_surgery_hx surhx WITH(NOLOCK)
	WHERE surhx.pat_id = @PatientId AND surhx.enable=1 
	ORDER BY surhx.created_on DESC 
	
	SELECT sochx.surgeryhx_other 
	FROM patient_social_hx sochx WITH(NOLOCK) 
	WHERE sochx.pat_id = @PatientId AND sochx.enable=1 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
