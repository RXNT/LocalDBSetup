SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE  [support].[FDBReportMonthly]
(
	@StartDate DATETIME,
	@EndDate	DATETIME
)
AS
BEGIN

	DECLARE @ERXV1AppCode VARCHAR(10)='ERXV1'
	DECLARE @ERXV1AppId BIGINT
	SELECT @ERXV1AppId=ApplicationId FROM [RsynRxNTMasterApplicationsTable] WITH(NOLOCK) WHERE Code=@ERXV1AppCode

	
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
		SELECT COUNT(1) FROM doctors dr WITH(NOLOCK) 
		INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
		WHERE dr.prescribing_authority=4 AND dr.dr_enabled=1
		AND EXISTS(
			SELECT pres.dr_id,COUNT(pres.pres_id) 
			FROM prescriptions pres WITH(NOLOCK) 
			WHERE dr.dr_id=pres.dr_id AND pres.pres_prescription_type=1 AND pres.pres_approved_date IS NOT NULL
			AND pres.pres_approved_date BETWEEN @StartDate AND @EndDate
			AND pres.pres_approved_date BETWEEN M.Dates AND DATEADD(MONTH,1,M.Dates)
			GROUP BY pres.dr_id
			HAVING COUNT(pres.pres_id)>5
		) 
		AND EXISTS(
			SELECT * 
			FROM [RsynRxNTMasterCompanyExternalAppMapsTable] CEM WITH(NOLOCK) 
			INNER JOIN [RsynMasterCompanyModuleAccess] CMA  WITH(NOLOCK) ON CMA.CompanyId=CEM.CompanyId AND CMA.ApplicationId=@ERXV1AppId AND CMA.Active=1
			WHERE CEM.ExternalAppId=1 AND CEM.ExternalCompanyId=dg.dc_id
		)
	) TotalDoctors
	FROM Months M
	WHERE Dates<=@endDate
 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
