SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 13-NOV-2022
-- Description:	To save the numerator for the measure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop1NumeratorCMS138v10_NQF0028]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRows INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2022].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,@StartDate)
	
	-- Numerator first condition
	IF OBJECT_ID('tempdb..#usp_SavePop1NumeratorCMS138v10_NQF0028_1') IS NOT NULL DROP TABLE #usp_SavePop1NumeratorCMS138v10_NQF0028_1

	
	SELECT TOP(@MaxRows) IPP.CalcId
	INTO #usp_SavePop1NumeratorCMS138v10_NQF0028_1
	FROM [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN [cqm2022].[PatientRiskCategoryOrAssessmentCodes] prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id 
--	INNER JOIN [cqm2022].[SysLookupCMS138v10_NQF0028] cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE  IPP.RequestId = @RequestId  AND ISNULL(IPP.Numerator,0) = 0 AND dg.dg_id IN (SELECT dgdc.dg_id FROM doc_groups dgdc WITH(NOLOCK) WHERE dgdc.dc_id = @DoctorCompanyId)
	AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND EXISTS(SELECT TOP 1* FROM  [cqm2022].[SysLookupCMS138v10_NQF0028] cqm_r WITH(NOLOCK) WHERE cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 25 AND cqm_r.ValueSetId = 167 AND cqm_r.Code = prc.Code)
	--AND cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 13 AND cqm_r.ValueSetId = 167
	

	UPDATE TOP(@MaxRows) IPP
	SET IPP.Numerator = 1
	FROM [cqm2022].[DoctorCQMCalcPop1CMS138v10_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN #usp_SavePop1NumeratorCMS138v10_NQF0028_1 T1 WITH(NOLOCK) ON T1.CalcId=IPP.CalcId
	 
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END
	
	SELECT @AffectedRows;
	IF OBJECT_ID('tempdb..#usp_SavePop1NumeratorCMS138v10_NQF0028_1') IS NOT NULL DROP TABLE #usp_SavePop1NumeratorCMS138v10_NQF0028_1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
