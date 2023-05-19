SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_SearchPatientMedications]
	@PatientId			BIGINT,
	@DoctorCompanyId	BIGINT
AS
BEGIN
	SELECT	r.MED_MEDID_DESC as drugName, dosage as dosage, duration_unit as units, numb_refills as refills,
			days_supply as supplies, 
			CASE WHEN date_start>'1901-01-01 00:00:00.000' THEN CONVERT(VARCHAR(20),date_start,101) ELSE NULL END as startDate, 
			CASE WHEN date_end>'1901-01-01 00:00:00.000' THEN CONVERT(VARCHAR(20),date_end,101) ELSE NULL END  as endDate
			FROM patient_active_meds pmh WITH(NOLOCK)
			INNER JOIN RMIID1 r WITH(NOLOCK) ON r.MEDID = pmh.drug_id
			INNER JOIN patients p WITH(NOLOCK) ON p.pa_id = pmh.pa_id			
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = p.dg_id
			WHERE dg.dc_id = @DoctorCompanyId AND pmh.pa_id=@PatientId
END	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
