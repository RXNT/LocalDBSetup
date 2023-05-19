SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SearchPatientProcedures]
	@PatientId			INT,
	@DoctorCompanyId	INT
AS
BEGIN
	SELECT	description as description, date_performed_to as datePerformed,
			ISNULL(d.dr_first_name,'')+' '+ISNULL(dr_last_name,'') as person, pp.status as status,type as type
			FROM [dbo].[patient_procedures] pp WITH(NOLOCK)
			INNER JOIN patients p WITH(NOLOCK) ON p.pa_id = pp.pa_id
			LEFT OUTER JOIN doctors d WITH(NOLOCK) ON d.dr_id = p.dr_id		
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = p.dg_id
			WHERE dg.dc_id = @DoctorCompanyId AND pp.pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
