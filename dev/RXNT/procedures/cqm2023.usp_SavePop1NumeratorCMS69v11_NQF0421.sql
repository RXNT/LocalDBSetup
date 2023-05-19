SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29th-OCT-2022
-- Description:	To save the numerator for the measure
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SavePop1NumeratorCMS69v11_NQF0421]
	@RequestId BIGINT  
AS
BEGIN
    DECLARE @tempRequestId BIGINT = @RequestId
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2023].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @tempRequestId
	
		
	UPDATE TOP(@MaxRowCount) IPP
	SET Numerator = 1
	FROM cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.PatientPhysicalExamCodes phec WITH(NOLOCK) ON IPP.PatientId = phec.PatientId
	INNER JOIN patient_vitals pv WITH(NOLOCK) ON pv.pa_id=pat.pa_id AND pv.pa_vt_id = phec.PhysicalExamId
	INNER JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK) ON phec.EncounterId = pec.EncounterId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @tempRequestId AND IPP.DoctorId = @DoctorId
	AND ISNULL(IPP.Numerator,0)=0 AND
	ISNULL(IPP.DenomExclusions,0)= 0 AND
	ISNULL(IPP.DenomExceptions,0)= 0 AND
	DATEDIFF(MONTH,phec.PerformedFromDate, pec.PerformedFromDate) <=12 AND pv.pa_bmi BETWEEN 18.5 AND 24.99
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate 
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Second
	DECLARE @temp1 TABLE
	(
		PatientId int,
		PerformedFromDate DATETIME
	)
	
	DECLARE @temp3 TABLE
	(
		PatientId int
	)
	INSERT INTO @temp1 (PatientId,PerformedFromDate)
	SELECT DISTINCT IPP.PatientId, pec.PerformedFromDate
	FROM cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.PatientPhysicalExamCodes phec WITH(NOLOCK) ON IPP.PatientId = phec.PatientId
	INNER JOIN patient_vitals pv WITH(NOLOCK) ON  pv.pa_id=pat.pa_id AND pv.pa_vt_id = phec.PhysicalExamId
	INNER JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK) ON phec.EncounterId = pec.EncounterId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @tempRequestId AND IPP.DoctorId = @DoctorId
	AND DATEDIFF(MONTH,phec.PerformedFromDate, pec.PerformedFromDate) <=12 AND pv.pa_bmi > 25
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
		INSERT INTO @temp3(PatientId) 
		SELECT pat.PatientId FROM @temp1 pat
		INNER JOIN patients pa WITH(NOLOCK) ON pa.pa_id=pat.PatientId
	    INNER JOIN doc_groups dg WITH(NOLOCK) ON pa.dg_id=dg.dg_id
		INNER JOIN cqm2023.PatientMedicationCodes pmc WITH(NOLOCK) ON pat.PatientId = pmc.PatientId AND PrescriptionId IS NOT NULL
		INNER JOIN cqm2023.[SysLookUpCMS69v11_NQF0421] cqm WITH(NOLOCK) on cqm.code = pmc.code
		INNER JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK) ON pmc.EncounterId = pec.EncounterId
		LEFT OUTER JOIN @temp3 t3 ON pat.PatientId=t3.PatientId
		WHERE dg.dc_id=@DoctorCompanyId  AND t3.PatientId IS NULL AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 9
		
		AND  DATEDIFF(MONTH, pmc.PerformedFromDate, pat.PerformedFromDate) <=12
		INSERT INTO @temp3(PatientId) 
		SELECT pat.PatientId 
		FROM @temp1 pat
		INNER JOIN patients pa WITH(NOLOCK) ON pa.pa_id=pat.PatientId
	    INNER JOIN doc_groups dg WITH(NOLOCK) ON pa.dg_id=dg.dg_id
		INNER JOIN cqm2023.PatientInterventionCodes pic WITH(NOLOCK) ON pic.PatientId = pat.PatientId
		INNER JOIN cqm2023.[SysLookUpCMS69v11_NQF0421] cqm WITH(NOLOCK) on cqm.code = pic.code
		LEFT OUTER JOIN @temp3 t3 ON pat.PatientId=t3.PatientId
		WHERE dg.dc_id=@DoctorCompanyId AND t3.PatientId IS NULL AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId IN (8,20)
		AND DATEDIFF(MONTH, pic.PerformedFromDate, pat.PerformedFromDate) <=12 
		
	IF OBJECT_ID('tempdb..#usp_SavePop1NumeratorCMS69v11_NQF0421_1') IS NOT NULL DROP TABLE #usp_SavePop1NumeratorCMS69v11_NQF0421_1
	SELECT TOP(@MaxRowCount) num.CalcId
	INTO #usp_SavePop1NumeratorCMS69v11_NQF0421_1
	FROM 
	patients pat WITH(NOLOCK)
	INNER JOIN @temp3 t3 ON t3.PatientId=pat.pa_id 
	INNER JOIN cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] num WITH(NOLOCK) ON pat.pa_id=num.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	
	where num.RequestId = @tempRequestId 
	AND dg.dc_id=@DoctorCompanyId 
	
	 
	UPDATE TOP(@MaxRowCount) num
	SET Numerator = 1 
	FROM cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] num 
	INNER JOIN #usp_SavePop1NumeratorCMS69v11_NQF0421_1 temp WITH(NOLOCK) ON num.CalcId=temp.CalcId
	where ISNULL(num.Numerator,0)= 0 AND
	ISNULL(num.DenomExclusions,0)= 0 AND
	ISNULL(num.DenomExceptions,0)= 0 
	DROP TABLE #usp_SavePop1NumeratorCMS69v11_NQF0421_1
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	---- Third 
	
	DECLARE @temp2 TABLE
	(
		PatientId int,
		PerformedFromDate DATETIME
	)
	
	
	INSERT INTO @temp2 (PatientId,PerformedFromDate)
	SELECT DISTINCT IPP.PatientId, pec.PerformedFromDate
	FROM cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.PatientPhysicalExamCodes phec  WITH(NOLOCK) ON IPP.PatientId = phec.PatientId
	INNER JOIN patient_vitals pv WITH(NOLOCK)  ON  pv.pa_id=pat.pa_id AND pv.pa_vt_id = phec.PhysicalExamId
	INNER JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK) ON phec.EncounterId = pec.EncounterId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @tempRequestId AND IPP.DoctorId = @DoctorId
	AND DATEDIFF(MONTH,phec.PerformedFromDate, pec.PerformedFromDate) <=12 AND pv.pa_bmi < 18.5
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	
	DECLARE @temp4 TABLE
	(
		PatientId int
	)
	INSERT INTO @temp4(PatientId)
	SELECT DISTINCT pat.PatientId FROM @temp2 pat
		INNER JOIN patients pa WITH(NOLOCK) ON pa.pa_id=pat.PatientId
	    INNER JOIN doc_groups dg WITH(NOLOCK) ON pa.dg_id=dg.dg_id
		INNER JOIN cqm2023.PatientMedicationCodes pmc WITH(NOLOCK) ON pat.PatientId = pmc.PatientId AND PrescriptionId IS NOT NULL
		INNER JOIN cqm2023.[SysLookUpCMS69v11_NQF0421] cqm WITH(NOLOCK) on cqm.code = pmc.code
		WHERE dg.dc_id=@DoctorCompanyId AND cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 11
		AND  DATEDIFF(MONTH, pmc.PerformedFromDate, pat.PerformedFromDate) <=12
		UNION
		SELECT DISTINCT pat.PatientId FROM @temp2 pat
		INNER JOIN patients pa WITH(NOLOCK) ON pa.pa_id=pat.PatientId
	    INNER JOIN doc_groups dg WITH(NOLOCK) ON pa.dg_id=dg.dg_id
		INNER JOIN cqm2023.PatientInterventionCodes pic  WITH(NOLOCK) ON pic.PatientId = pat.PatientId
		INNER JOIN cqm2023.[SysLookUpCMS69v11_NQF0421] cqm WITH(NOLOCK) on cqm.code = pic.code
		WHERE dg.dc_id=@DoctorCompanyId AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId IN (10,20)
		AND DATEDIFF(MONTH, pic.PerformedFromDate, pat.PerformedFromDate) <=12
	IF OBJECT_ID('tempdb..#usp_SavePop1NumeratorCMS69v11_NQF0421_2') IS NOT NULL DROP TABLE #usp_SavePop1NumeratorCMS69v11_NQF0421_2
	
	SELECT TOP(@MaxRowCount) num.CalcId
	INTO #usp_SavePop1NumeratorCMS69v11_NQF0421_2
	FROM cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] num WITH(NOLOCK) 
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=num.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN @temp4 t4 ON t4.PatientId=pat.pa_id
	where dg.dc_id=@DoctorCompanyId AND 
	ISNULL(num.Numerator,0)=0  AND
	ISNULL(num.DenomExclusions,0) = 0 AND
	ISNULL(num.DenomExceptions,0) = 0 AND
	num.RequestId = @tempRequestId
	UPDATE TOP(@MaxRowCount) num
	SET Numerator = 1 
	FROM cqm2023.[DoctorCQMCalcPop1CMS69v11_NQF0421] num WITH(NOLOCK) 
	INNER JOIN #usp_SavePop1NumeratorCMS69v11_NQF0421_2 temp WITH(NOLOCK) ON temp.CalcId=num.CalcId
	
	DROP TABLE #usp_SavePop1NumeratorCMS69v11_NQF0421_2
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
