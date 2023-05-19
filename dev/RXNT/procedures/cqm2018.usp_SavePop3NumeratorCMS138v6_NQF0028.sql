SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 12-May-2017
-- Description:	To save the numerator for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop3NumeratorCMS138v6_NQF0028]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRows INT = 1000
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
    IF OBJECT_ID('tempdb..#tempDoctorCQMCalcPop3CMS138v6_NQF00281') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempDoctorCQMCalcPop3CMS138v6_NQF00281
    END
    IF OBJECT_ID('tempdb..#tempDoctorCQMCalcPop3CMS138v6_NQF00282') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempDoctorCQMCalcPop3CMS138v6_NQF00282
    END
    IF OBJECT_ID('tempdb..#tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients
    END
    
    
	
	SELECT DISTINCT IPP.PatientId,prc.PerformedFromDate  INTO #tempCMS138v6_NQF0028
	FROM cqm2018.DoctorCQMCalcPop3CMS138v6_NQF0028 IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientRiskCategoryOrAssessmentCodes prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	INNER JOIN cqm2018.SysLookupCMS138v6_NQF0028 cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE IPP.RequestId = @RequestId AND cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 9 AND cqm_r.ValueSetId = 167
	AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate 
	
	--Update Tobacco Non-User Assesment
	--UPDATE TOP(@MaxRows) IPP
	--SET IPP.Numerator = 1 
	SELECT IPP.CalcId 
	INTO #tempDoctorCQMCalcPop3CMS138v6_NQF00281
	FROM [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientRiskCategoryOrAssessmentCodes  prc WITH(NOLOCK) ON IPP.PatientId=prc.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON prc.Code = cqm.code 
	WHERE IPP.RequestId = @RequestId AND IPP.Denominator=1 AND cqm.ValueSetId=167
	AND  IPP.Numerator = 0
	AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND pfd.flag_id IN (6,7)
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.Numerator = 1 
	FROM [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN #tempDoctorCQMCalcPop3CMS138v6_NQF00281 IPP_Temp ON IPP.CalcId=IPP_Temp.CalcId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > 0
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	
	SELECT DISTINCT pat.PatientId 
	INTO #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients
	from #tempCMS138v6_NQF0028  pat
	INNER JOIN [cqm2018].PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = pat.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.MedicationId IS NOT NULL
	WHERE pmc.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
	AND pmc.DoctorId = @DoctorId AND QDMCategoryId = 5 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 166
	
	INSERT INTO #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients(PatientId)
	SELECT DISTINCT pat.PatientId 
	from #tempCMS138v6_NQF0028  pat
	INNER JOIN [cqm2018].PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = pat.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.PrescriptionId IS NOT NULL
	LEFT OUTER JOIN #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients tPat ON pat.PatientId=tPat.PatientId
	WHERE pmc.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
	AND tPat.PatientId IS NULL
	AND pmc.DoctorId = @DoctorId AND QDMCategoryId = 5 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 166
	
	INSERT INTO #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients(PatientId)
	SELECT DISTINCT pat.PatientId 
	from #tempCMS138v6_NQF0028  pat
	INNER JOIN [cqm2018].PatientInterventionCodes pic WITH(NOLOCK) ON pic.PatientId = pat.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) ON pic.Code = cqm.code 
	LEFT OUTER JOIN #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients tPat ON pat.PatientId=tPat.PatientId
	WHERE pic.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
	AND tPat.PatientId IS NULL
	AND pic.DoctorId = @DoctorId AND QDMCategoryId = 4
	--Update Tobacco User Assesment
	--UPDATE TOP(@MaxRows) IPP
	--SET IPP.Numerator = 1 
	SELECT IPP.CalcId
	INTO #tempDoctorCQMCalcPop3CMS138v6_NQF00282
	FROM [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientRiskCategoryOrAssessmentCodes  prc WITH(NOLOCK) ON IPP.PatientId=prc.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	INNER JOIN #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients tPat ON IPP.PatientId=tPat.PatientId
	where IPP.RequestId = @RequestId AND  IPP.Numerator = 0 AND pfd.flag_id IN (-5,-4,-2,-1,5)
	 
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.Numerator = 1 
	FROM [cqm2018].[DoctorCQMCalcPop3CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN #tempDoctorCQMCalcPop3CMS138v6_NQF00282 IPP_Temp WITH(NOLOCK) ON IPP.CalcId=IPP_Temp.CalcId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows += @tempRowCount;
	 END
	
	SELECT @AffectedRows;
	DROP TABLE #tempCMS138v6_NQF0028
	DROP TABLE #tempDoctorCQMCalcPop3CMS138v6_NQF00281
	DROP TABLE #tempDoctorCQMCalcPop3CMS138v6_NQF00282
	DROP TABLE #tempDoctorCQMCalcPop3CMS138v6_NQF0028Patients
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
