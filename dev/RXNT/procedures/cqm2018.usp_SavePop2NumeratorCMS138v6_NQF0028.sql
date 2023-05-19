SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the numerator for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop2NumeratorCMS138v6_NQF0028]
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
	
	
	IF OBJECT_ID('tempdb..#tempCMS138v6_NQF0028') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempCMS138v6_NQF0028
    END
	
	SELECT DISTINCT IPP.PatientId,prc.PerformedFromDate  INTO #tempCMS138v6_NQF0028
	FROM cqm2018.DoctorCQMCalcPop2CMS138v6_NQF0028 IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientRiskCategoryOrAssessmentCodes prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	INNER JOIN cqm2018.SysLookupCMS138v6_NQF0028 cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE IPP.RequestId = @RequestId AND cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 9 AND cqm_r.ValueSetId = 167
	AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND pfd.flag_id IN (-5,-4,-2,-1,5)
	
	
	UPDATE TOP(@MaxRows) num
	SET Numerator = 1 
	FROM [cqm2018].[DoctorCQMCalcPop2CMS138v6_NQF0028] num WITH(NOLOCK) where
	num.RequestId = @RequestId AND (num.Numerator IS NULL OR num.Numerator = 0)
	AND num.PatientId IN (
		SELECT DISTINCT pat.PatientId from #tempCMS138v6_NQF0028  pat
		INNER JOIN [cqm2018].PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = pat.PatientId
		INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.MedicationId IS NOT NULL
		WHERE pmc.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
		AND pmc.DoctorId = @DoctorId AND QDMCategoryId = 5 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 166
		UNION 
		SELECT DISTINCT pat.PatientId from #tempCMS138v6_NQF0028  pat
		INNER JOIN [cqm2018].PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = pat.PatientId
		INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.PrescriptionId IS NOT NULL
		WHERE pmc.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
		AND pmc.DoctorId = @DoctorId AND QDMCategoryId = 5 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 166
		UNION
		SELECT DISTINCT pat.PatientId from #tempCMS138v6_NQF0028  pat
		INNER JOIN [cqm2018].PatientInterventionCodes pic WITH(NOLOCK) ON pic.PatientId = pat.PatientId
		INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON pic.Code = cqm.code 
		WHERE pic.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
		AND pic.DoctorId = @DoctorId AND QDMCategoryId = 4
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
