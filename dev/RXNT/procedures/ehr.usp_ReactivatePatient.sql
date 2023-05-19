SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 15-Sep-2017
-- Description:	Reactivate Patients
-- Modified By: 
-- Modified Date: 
-- =============================================

CREATE PROCEDURE [ehr].[usp_ReactivatePatient]
	 @DoctorCompanyId BIGINT,
	 @PatientId BIGINT
AS
BEGIN

	DELETE PFD
	FROM patient_flag_details pfd WITH(NOLOCK)
	INNER JOIN [dbo].[patient_flags] pf WITH(NOLOCK) ON pfd.flag_id=pf.flag_id
	INNER JOIN patients pat WITH(NOLOCK) ON pfd.pa_id=pat.pa_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=pat.dg_id
	WHERE dg.dc_id = @DoctorCompanyId AND pfd.pa_id=@PatientId AND pf.flag_title = 'Discharged'

	UPDATE patients 
	SET dg_id=-dg_id 
	WHERE pa_id=@PatientId AND dg_id<0
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
