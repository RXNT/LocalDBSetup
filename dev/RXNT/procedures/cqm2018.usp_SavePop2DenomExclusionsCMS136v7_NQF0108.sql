SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop2DenomExclusionsCMS136v7_NQF0108]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId;
	
	WITH InitialADHDMedication(pa_id,PerformedFromDate,PerformedToDate)
	AS
	(
		SELECT DISTINCT pmc.PatientId, pmc.PerformedFromDate,pmc.PerformedToDate
		FROM cqm2018.PatientMedicationCodes pmc with(NOLOCK)
		INNER JOIN cqm2018.SysLookupCMS136v7_NQF0108 cqm WITH(NOLOCK) ON cqm.code = pmc.Code		
		INNER JOIN cqm2018.DoctorCQMCalcPop2CMS136v7_NQF0108 IPP WITH(NOLOCK) on IPP.PatientId = pmc.PatientId AND IPP.RequestId = @RequestId
		WHERE pmc.DoctorId = @DoctorId	
		AND cqm.QDMCategoryId = 5  AND cqm.ValueSetId = 22
		AND DATEDIFF(DAY,@StartDate,pmc.PerformedFromDate) BETWEEN -90 AND 60	
		AND pmc.MedicationId IS NULL 	
	)
	
	UPDATE TOP(@MaxRowCount) IPP
	SET DenomExclusions = 1
	FROM cqm2018.DoctorCQMCalcPop2CMS136v7_NQF0108 IPP
	INNER JOIN (
		SELECT DISTINCT PatientId 
		FROM cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK)
		INNER JOIN cqm2018.SysLookUpCMS136v7_NQF0108 cqm WITH(NOLOCK) on cqm.code = pdc.code	
		WHERE pdc.DoctorId = @DoctorId AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 35
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		
		UNION 
		
		SELECT DISTINCT PatientId 
		FROM cqm2018.PatientInterventionCodes pic WITH(NOLOCK)
		INNER JOIN cqm2018.SysLookUpCMS136v7_NQF0108 cqm  WITH(NOLOCK)on cqm.code = pic.code	
		WHERE pic.DoctorId = @DoctorId AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId = 31
		AND (
			pic.PerformedFromDate BETWEEN @StartDate AND @EndDate
			OR
			pic.PerformedToDate BETWEEN @StartDate AND @EndDate
		)
		
		UNION 
		
		SELECT DISTINCT pmc.PatientId
		FROM cqm2018.PatientMedicationCodes pmc  WITH(NOLOCK)
		INNER JOIN InitialADHDMedication M ON M.pa_id=pmc.PatientId
		INNER JOIN cqm2018.[SysLookUpCMS136v7_NQF0108] cqm  WITH(NOLOCK) on cqm.code = pmc.Code	
		WHERE pmc.DoctorId = @DoctorId 
		AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 22 AND
		pmc.PerformedFromDate < pmc.PerformedFromDate AND DATEDIFF(DAY,pmc.PerformedFromDate,M.PerformedFromDate) <= 120
	
	) res  ON res.PatientId=IPP.PatientId		
	WHERE IPP.DoctorId = @DoctorId
	AND IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0 AND IPP.RequestId = @RequestId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END
	
	SELECT @AffectedRows;


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
