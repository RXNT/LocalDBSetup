SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 12-May-2022
-- Description:	To save the numerator for the measure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop3NumeratorCMS138v10_NQF0028]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRows INT = 10
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
	
	
	IF OBJECT_ID('tempdb..#tempCMS138v10_NQF0028') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempCMS138v10_NQF0028
    END
	
	SELECT DISTINCT IPP.PatientId,prc.PerformedFromDate  INTO #tempCMS138v10_NQF0028
	FROM cqm2022.DoctorCQMCalcPop3CMS138v10_NQF0028 IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientRiskCategoryOrAssessmentCodes prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	--INNER JOIN cqm2022.SysLookupCMS138v10_NQF0028 cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE IPP.RequestId = @RequestId AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND dg.dc_id = @DoctorCompanyId
	AND EXISTS(SELECT TOP 1 * FROM  cqm2022.SysLookupCMS138v10_NQF0028 cqm_r WITH(NOLOCK) WHERE cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 25 AND cqm_r.ValueSetId = 167 AND cqm_r.Code = prc.Code)
	--AND cqm_r.QDMCategoryId = 17 AND cqm_r.CodeSystemId = 13 AND cqm_r.ValueSetId = 167
	 
	
	--Update Tobacco Non-User Assesment
	UPDATE TOP(@MaxRows) IPP
	SET IPP.Numerator = 1 
	FROM [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientRiskCategoryOrAssessmentCodes  prc WITH(NOLOCK) ON IPP.PatientId=prc.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_id=IPP.PatientId AND pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	WHERE IPP.RequestId = @RequestId 
	AND prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate 
	AND  dg.dc_id= @DoctorCompanyId AND IPP.Denominator=1
	AND ISNULL(IPP.Numerator,0) = 0 
	AND pfd.flag_id IN (6,7) AND EXISTS(SELECT * FROM [cqm2022].[SysLookupCMS138v10_NQF0028] cqm WITH(NOLOCK) WHERE cqm.ValueSetId=167 AND prc.Code = cqm.code )
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > 0
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Update Tobacco User Assesment
	UPDATE TOP(@MaxRows) IPP
	SET IPP.Numerator = 1 
	FROM [cqm2022].[DoctorCQMCalcPop3CMS138v10_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientRiskCategoryOrAssessmentCodes  prc WITH(NOLOCK) ON IPP.PatientId=prc.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_id=pat.pa_id AND pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	INNER JOIN  (
		SELECT DISTINCT pat.PatientId from #tempCMS138v10_NQF0028  pat
		INNER JOIN patients pat1 WITH(NOLOCK) ON pat.PatientId=pat1.pa_id
		INNER JOIN [cqm2022].PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = pat.PatientId
		INNER JOIN [cqm2022].[SysLookupCMS138v10_NQF0028] cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.MedicationId IS NOT NULL
		WHERE pmc.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
		AND pmc.DoctorId = @DoctorId AND QDMCategoryId = 5 AND cqm.CodeSystemId = 25 AND cqm.ValueSetId = 166
		UNION 
		SELECT DISTINCT pat.PatientId from #tempCMS138v10_NQF0028  pat
		INNER JOIN patients pat1 WITH(NOLOCK) ON pat.PatientId=pat1.pa_id
		INNER JOIN [cqm2022].PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = pat.PatientId
		INNER JOIN [cqm2022].[SysLookupCMS138v10_NQF0028] cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.PrescriptionId IS NOT NULL
		WHERE pmc.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
		AND pmc.DoctorId = @DoctorId AND QDMCategoryId = 5 AND cqm.CodeSystemId = 25 AND cqm.ValueSetId = 166
		UNION
		SELECT DISTINCT pat.PatientId from #tempCMS138v10_NQF0028  pat
		INNER JOIN patients pat1 WITH(NOLOCK) ON pat.PatientId=pat1.pa_id
		INNER JOIN [cqm2022].PatientInterventionCodes pic WITH(NOLOCK) ON pic.PatientId = pat.PatientId
		INNER JOIN [cqm2022].[SysLookupCMS138v10_NQF0028] cqm WITH(NOLOCK) ON pic.Code = cqm.code 
		WHERE pic.PerformedFromDate BETWEEN pat.PerformedFromDate AND @EndDate
		AND pic.DoctorId = @DoctorId AND QDMCategoryId = 4
	) UNI ON  IPP.PatientId=UNI.PatientId
	where dg.dc_id = @DoctorCompanyId AND IPP.RequestId = @RequestId AND ISNULL(IPP.Numerator,0)=0 AND pfd.flag_id IN (-5,-4,-2,-1,5)

	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows += @tempRowCount;
	 END
	
	SELECT @AffectedRows;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
