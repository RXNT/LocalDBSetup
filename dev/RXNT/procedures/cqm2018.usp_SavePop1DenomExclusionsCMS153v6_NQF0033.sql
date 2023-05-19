SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the Denom Exclusions 
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenomExclusionsCMS153v6_NQF0033]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRows INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,@StartDate)
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.DenomExclusions = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS153v6_NQF0033] IPP WITH(NOLOCK)
	INNER JOIN [cqm2018].PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS153v6_NQF0033] as cqm with(NOLOCK) on pltc.Code = cqm.Code
	WHERE  IPP.RequestId = @RequestId AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0) 
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId=9 AND cqm.ValueSetId = 86
	AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND EXISTS (
		SELECT 1 FROM cqm2018.PatientDiagnosticStudyCodes pdsc  WITH(NOLOCK)
		INNER JOIN [cqm2018].[SysLookupCMS153v6_NQF0033] as cqm with(NOLOCK) on pdsc.Code = cqm.Code
		WHERE pdsc.PatientId = IPP.PatientId AND pdsc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND cqm.QDMCategoryId = 15 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId = 91
		AND DATEDIFF(day,pdsc.PerformedFromDate,pltc.PerformedFromDate) <= 7
	)
	 
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END	
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.DenomExclusions = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS153v6_NQF0033] IPP WITH(NOLOCK)
	INNER JOIN [cqm2018].PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS153v6_NQF0033] as cqm with(NOLOCK) on pltc.Code = cqm.Code
	WHERE IPP.RequestId = @RequestId AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0)
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId=9 AND cqm.ValueSetId = 86
	AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND EXISTS (
		SELECT 1 FROM cqm2018.PatientMedicationCodes pmc 
		INNER JOIN [cqm2018].[SysLookupCMS153v6_NQF0033] as cqm with(NOLOCK) on pmc.Code = cqm.Code
		WHERE pmc.PatientId = IPP.PatientId AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 81
		AND DATEDIFF(day,pmc.PerformedFromDate,pltc.PerformedFromDate) <= 7
	)
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
