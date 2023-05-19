SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE  [support].[FDBReport] 
(
	@StartDate DATETIME,
	@EndDate	DATETIME
)
AS
BEGIN
	
	DECLARE @ERXV1AppCode VARCHAR(10)='ERXV1'
	DECLARE @ERXV1AppId BIGINT
	SELECT @ERXV1AppId=ApplicationId FROM RxNTMaster.rxn.Applications WITH(NOLOCK) WHERE Code=@ERXV1AppCode

	SELECT dr.* FROM doctors dr WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE dr.prescribing_authority=4 AND dr.dr_enabled=1
	AND EXISTS(
		SELECT pres.dr_id,COUNT(pres.pres_id) 
		FROM prescriptions pres WITH(NOLOCK) 
		WHERE dr.dr_id=pres.dr_id AND pres.pres_prescription_type=1 AND pres.pres_approved_date IS NOT NULL
		AND pres.pres_approved_date BETWEEN @StartDate AND @EndDate
		GROUP BY pres.dr_id
		HAVING COUNT(pres.pres_id)>5
	) 
	AND EXISTS(
		SELECT * 
		FROM RxNTMaster.mse.CompanyExternalAppMaps CEM WITH(NOLOCK) 
		INNER JOIN  RxNTMaster.msa.CompanyModuleAccess CMA  WITH(NOLOCK) ON CMA.CompanyId=CEM.CompanyId AND CMA.ApplicationId=@ERXV1AppId AND CMA.Active=1
		WHERE CEM.ExternalAppId=1 AND CEM.ExternalCompanyId=dg.dc_id
	)

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
