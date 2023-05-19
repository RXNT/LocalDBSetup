SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
EHR/PM 
All active users of EHR/eRx who have written either 5 prescription or encounters for a quarter (start and end)date) and who have added new diagnosis for a given quarter (start and end date)
*/
CREATE PROCEDURE  [support].[IMOBasedDiagnosisReport]
(
	@StartDate DATETIME,
	@EndDate	DATETIME
)
AS
BEGIN
	
	
DECLARE @ERXV1AppCode VARCHAR(10)='ERXV1'
DECLARE @ERXV1AppId BIGINT
SELECT @ERXV1AppId=ApplicationId FROM RxNTMaster.rxn.Applications WITH(NOLOCK) WHERE Code=@ERXV1AppCode
 

SELECT * FROM(
	SELECT dr.* FROM doctors dr WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE dr.dr_enabled=1 
	AND EXISTS(
		SELECT pres.dr_id,COUNT(pres.pres_id) 
		FROM prescriptions pres WITH(NOLOCK) 
		WHERE dr.dr_id=pres.dr_id AND pres.pres_prescription_type=1 AND pres.pres_approved_date IS NOT NULL
		AND pres.pres_approved_date BETWEEN @StartDate AND @EndDate
		GROUP BY pres.dr_id
		HAVING COUNT(pres.pres_id)>5
	)  

	AND EXISTS(SELECT TOP 1 * FROM patient_active_diagnosis pad WITH(NOLOCK)
	WHERE pad.added_by_dr_id=dr.dr_id AND pad.date_added BETWEEN @StartDate AND @EndDate)
	UNION

	SELECT dr.* FROM doctors dr WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE dr.dr_enabled=1
	AND EXISTS(
		SELECT TOP 1 enc.enc_id
		FROM enchanced_encounter enc WITH(NOLOCK) 
		WHERE dr.dr_id=enc.dr_id AND enc.issigned=1 
		AND enc.dtsigned BETWEEN @StartDate AND @EndDate
	)  


	AND EXISTS(SELECT TOP 1 * FROM patient_active_diagnosis pad WITH(NOLOCK)
	WHERE pad.added_by_dr_id=dr.dr_id AND pad.date_added BETWEEN @StartDate AND @EndDate)
) a;


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
