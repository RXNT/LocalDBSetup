SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 13-NOV-2017
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop2IPPCMS138v7_NQF0028]
	@RequestId BIGINT  
AS
BEGIN

	DECLARE @MaxRecords BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM cqm2019.DoctorCQMCalculationRequest DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,CAST((YEAR(GETDATE())-2) AS VARCHAR)+'-01-01 00:00:00');
	IF OBJECT_ID('tempdb..#usp_SavePop2IPPCMS138v7_NQF0028_1') IS NOT NULL DROP TABLE #usp_SavePop2IPPCMS138v7_NQF0028_1
	IF OBJECT_ID('tempdb..#usp_SavePop2IPPCMS138v7_NQF0028_2') IS NOT NULL DROP TABLE #usp_SavePop2IPPCMS138v7_NQF0028_2

	 SELECT DISTINCT TOP(@MaxRecords) pat.pa_id 
	INTO #usp_SavePop2IPPCMS138v7_NQF0028_1
    FROM patients pat WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientEncounterCodes pec WITH(NOLOCK) ON pec.PatientId=pat.pa_id
	WHERE dg.dc_id=@DoctorCompanyId AND pec.DoctorId = @DoctorId AND datediff(month,PAT.pa_dob,CONVERT(datetime,@StartDate)) >= 18*12 AND NOT (pa_dob LIKE '1901-01-01')

	INSERT INTO cqm2019.DoctorCQMCalcPop2CMS138v7_NQF0028
    (PatientId, IPP, DoctorId, RequestId)   
    SELECT DISTINCT TOP(@MaxRecords) T1.pa_id,  1, @DoctorId, @RequestId 
	FROM #usp_SavePop2IPPCMS138v7_NQF0028_1 T1
	LEFT JOIN [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] IPP WITH(NOLOCK) ON IPP.PatientId = T1.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL  
	
	--UPDATE TOP(@MaxRecords) IPP
	--SET IPP.Denominator = 1
	SELECT TOP(@MaxRecords) IPP.CalcId
	INTO #usp_SavePop2IPPCMS138v7_NQF0028_2
	FROM [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN [cqm2019].[PatientRiskCategoryOrAssessmentCodes] prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_id=pat.pa_id AND pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	INNER JOIN [cqm2019].[SysLookupCMS138v7_NQF0028] cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND IPP.Denominator IS NULL AND cqm_r.ValueSetId=167 AND
	prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND pfd.flag_id IN (-5,-4,-2,-1,5)
	
	UPDATE TOP(@MaxRecords) IPP
	SET IPP.Denominator = 1
	FROM [cqm2019].[DoctorCQMCalcPop2CMS138v7_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN #usp_SavePop2IPPCMS138v7_NQF0028_2 T2 ON IPP.CalcId=T2.CalcId

	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	SELECT @AffectedRows;
	IF OBJECT_ID('tempdb..#usp_SavePop2IPPCMS138v7_NQF0028_1') IS NOT NULL DROP TABLE #usp_SavePop2IPPCMS138v7_NQF0028_1
	IF OBJECT_ID('tempdb..#usp_SavePop2IPPCMS138v7_NQF0028_2') IS NOT NULL DROP TABLE #usp_SavePop2IPPCMS138v7_NQF0028_2
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
