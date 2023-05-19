SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the numerator for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS138v6_NQF0028]
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
	IF OBJECT_ID('tempdb..#DoctorCQMCalcPop1CMS138v6_NQF0028') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempCMS138v6_NQF0028
    END
	-- Numerator first condition
	--UPDATE TOP(@MaxRows) IPP
	--SET IPP.Numerator = 1
	SELECT IPP.CalcId
	INTO #DoctorCQMCalcPop1CMS138v6_NQF0028
	FROM [cqm2018].[DoctorCQMCalcPop1CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN [cqm2018].[PatientRiskCategoryOrAssessmentCodes] prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE  IPP.RequestId = @RequestId AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 9 AND cqm_r.ValueSetId = 167
	AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.Numerator = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN #DoctorCQMCalcPop1CMS138v6_NQF0028 IPP_Temp WITH(NOLOCK) ON IPP_Temp.CalcId = IPP.CalcId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END
	DROP TABLE #DoctorCQMCalcPop1CMS138v6_NQF0028
	SELECT @AffectedRows;
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
