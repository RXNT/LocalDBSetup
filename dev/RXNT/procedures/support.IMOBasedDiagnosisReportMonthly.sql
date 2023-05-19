SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
EHR/PM 
All active users of EHR/eRx who have written either 5 prescription or encounters for a quarter (start and end)date) and who have added new diagnosis for a given quarter (start and end date)
Break down the number for each month
*/
CREATE PROCEDURE  [support].[IMOBasedDiagnosisReportMonthly]
(
	@StartDate DATETIME,
	@EndDate	DATETIME
)
AS
BEGIN
	
	
DECLARE @ERXV1AppCode VARCHAR(10)='ERXV1'
DECLARE @ERXV1AppId BIGINT
SELECT @ERXV1AppId=ApplicationId FROM RxNTMaster.rxn.Applications WITH(NOLOCK) WHERE Code=@ERXV1AppCode
 
/*==============================================================================================================================*/
/*
EHR/PM 
All active users of EHR/eRx who have written either 5 prescription or encounters for a quarter (start and end)date) and who have added new diagnosis for a given quarter (start and end date)
Break down the number for each month
*/
 

 ;WITH Months AS
 (
     SELECT CONVERT(DATE, @startDate) AS Dates
  
     UNION ALL
  
     SELECT DATEADD(MONTH, 1, Dates)
     FROM Months
     WHERE CONVERT(DATE, Dates) <= CONVERT(DATE, @endDate)
 )
 SELECT DATENAME(MONTH,Dates) + ' ' + DATENAME(YEAR, Dates) [Month],
 (
	(SELECT COUNT(DISTINCT dr_id) FROM 
		(
			SELECT dr.* FROM Months, doctors dr WITH(NOLOCK) 
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
			WHERE dr.dr_enabled=1
			AND EXISTS(
				SELECT pres.dr_id,COUNT(pres.pres_id) 
				FROM prescriptions pres WITH(NOLOCK) 
				WHERE dr.dr_id=pres.dr_id AND pres.pres_prescription_type=1 AND pres.pres_approved_date IS NOT NULL
				AND pres.pres_approved_date BETWEEN @StartDate AND @EndDate AND pres.pres_approved_date BETWEEN M.Dates AND DATEADD(MONTH,1,M.Dates)
				GROUP BY pres.dr_id
				HAVING COUNT(pres.pres_id)>5
			)  

			AND EXISTS(SELECT TOP 1 * FROM patient_active_diagnosis pad WITH(NOLOCK)
			WHERE pad.added_by_dr_id=dr.dr_id AND pad.date_added BETWEEN @StartDate AND @EndDate AND pad.date_added BETWEEN M.Dates AND DATEADD(MONTH,1,M.Dates))
			UNION

			SELECT dr.* FROM doctors dr WITH(NOLOCK) 
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
			WHERE dr.dr_enabled=1
			AND EXISTS(
				SELECT TOP 1 enc.enc_id
				FROM enchanced_encounter enc WITH(NOLOCK) 
				WHERE dr.dr_id=enc.dr_id AND enc.issigned=1 
				AND enc.dtsigned BETWEEN @StartDate AND @EndDate AND enc.dtsigned BETWEEN M.Dates AND DATEADD(MONTH,1,M.Dates)
			)  


			AND EXISTS(SELECT TOP 1 * FROM patient_active_diagnosis pad WITH(NOLOCK)
			WHERE pad.added_by_dr_id=dr.dr_id AND pad.date_added BETWEEN @StartDate AND @EndDate AND pad.date_added BETWEEN M.Dates AND DATEADD(MONTH,1,M.Dates))
		) a
	)
) TotalDoctors
FROM Months M
WHERE Dates<=@endDate
-- OPTION (maxrecursion 0)





END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
