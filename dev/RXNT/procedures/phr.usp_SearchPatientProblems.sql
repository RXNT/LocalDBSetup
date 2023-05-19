SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SearchPatientProblems]
	@PatientId			INT,
	@DoctorCompanyId	INT
AS
BEGIN
	SELECT	icd9_description as diagnosis, onset as onset, pad.status as status, severity as severity
			FROM patient_active_diagnosis pad WITH(NOLOCK)
			INNER JOIN patients p WITH(NOLOCK) ON p.pa_id = pad.pa_id		
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = p.dg_id
			WHERE dg.dc_id = @DoctorCompanyId AND pad.pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
