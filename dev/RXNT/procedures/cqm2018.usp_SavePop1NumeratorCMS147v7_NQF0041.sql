SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the numerator for the measure

-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS147v7_NQF0041]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRowCount INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	UPDATE TOP(@MaxRowCount) cqm2018.DoctorCQMCalcPOP1CMS147v7_NQF0041
	SET Numerator = 1 
	FROM [cqm2018].[DoctorCQMCalcPOP1CMS147v7_NQF0041] pat WITH(NOLOCK)
	INNER JOIN cqm2018.PatientProcedureCodes ppc_s WITH(NOLOCK) ON ppc_s.PatientId = pat.PatientId
	INNER JOIN cqm2018.[SysLookupCMS147v7_NQF0041] cqm WITH(NOLOCK) on cqm.Code = ppc_s.Code
	WHERE cqm.QDMCategoryId = 10 AND cqm.ValueSetId = 56 
	AND ppc_s.PerformedFromDate BETWEEN @StartDate AND @EndDate 
	AND DATEDIFF(DAY,ppc_s.PerformedFromDate,@StartDate) BETWEEN -153 AND 89
	AND pat.Numerator IS NULL OR pat.Numerator = 0 
	AND (pat.DenomExceptions=0 OR pat.DenomExceptions IS NULL)  	
	

	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END

	UPDATE TOP(@MaxRowCount) cqm2018.DoctorCQMCalcPOP1CMS147v7_NQF0041
	SET Numerator = 1
	FROM cqm2018.DoctorCQMCalcPOP1CMS147v7_NQF0041 pat WITH(NOLOCK)
	INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) on pmc.PatientId = pat.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS147v7_NQF0041] cqm WITH(NOLOCK) ON pmc.Code = cqm.code
	WHERE cqm.QDMCategoryId = 8 AND cqm.ValueSetId = 58
	AND pmc.PerformedFromDate between @StartDate AND @EndDate 
	AND DATEDIFF(DAY,pmc.PerformedFromDate ,@StartDate) BETWEEN -153 AND 89
	AND pat.Numerator IS NULL OR pat.Numerator = 0
	AND (pat.DenomExceptions=0 OR pat.DenomExceptions IS NULL) 
	
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
