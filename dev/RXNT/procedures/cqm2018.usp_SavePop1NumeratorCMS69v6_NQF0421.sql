SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 5th-FEB-2018
-- Description:	To save the numerator for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS69v6_NQF0421]
	@RequestId BIGINT  
AS
BEGIN
    DECLARE @tempRequestId BIGINT = @RequestId
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @tempRequestId
	
		
	UPDATE TOP(@MaxRowCount) IPP
	SET Numerator = 1
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientPhysicalExamCodes phec WITH(NOLOCK) ON IPP.PatientId = phec.PatientId
	INNER JOIN patient_vitals pv WITH(NOLOCK) ON pv.pa_vt_id = phec.PhysicalExamId
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON phec.EncounterId = pec.EncounterId
	WHERE  IPP.RequestId = @tempRequestId AND IPP.DoctorId = @DoctorId
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0) AND
	(IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0) AND
	(IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0) AND
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
	INSERT INTO @temp1 (PatientId,PerformedFromDate)
	SELECT DISTINCT IPP.PatientId, pec.PerformedFromDate
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientPhysicalExamCodes phec WITH(NOLOCK) ON IPP.PatientId = phec.PatientId
	INNER JOIN patient_vitals pv WITH(NOLOCK) ON pv.pa_vt_id = phec.PhysicalExamId
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON phec.EncounterId = pec.EncounterId
	WHERE IPP.RequestId = @tempRequestId AND IPP.DoctorId = @DoctorId
	AND DATEDIFF(MONTH,phec.PerformedFromDate, pec.PerformedFromDate) <=12 AND pv.pa_bmi > 25
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	

	
	UPDATE TOP(@MaxRowCount) num
	SET Numerator = 1 
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] num where 
	(num.Numerator IS NULL OR num.Numerator = 0) AND
	(num.DenomExclusions IS NULL OR num.DenomExclusions = 0) AND
	(num.DenomExceptions IS NULL OR num.DenomExceptions = 0) AND
	 num.RequestId = @tempRequestId
	AND num.PatientId IN (
		SELECT pat.PatientId FROM @temp1 pat
		INNER JOIN cqm2018.PatientMedicationCodes pmc WITH(NOLOCK) ON pat.PatientId = pmc.PatientId AND PrescriptionId IS NOT NULL
		INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm WITH(NOLOCK) on cqm.code = pmc.code
		INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON pmc.EncounterId = pec.EncounterId
		WHERE cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 9
		AND  DATEDIFF(MONTH, pmc.PerformedFromDate, pat.PerformedFromDate) <=12
		UNION
		SELECT pat.PatientId FROM @temp1 pat
		INNER JOIN cqm2018.PatientInterventionCodes pic WITH(NOLOCK) ON pic.PatientId = pat.PatientId
		INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm WITH(NOLOCK) on cqm.code = pic.code
		WHERE cqm.QDMCategoryId = 4 AND cqm.ValueSetId IN (8,20)
		AND DATEDIFF(MONTH, pic.PerformedFromDate, pat.PerformedFromDate) <=12
	)
	
	
	
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
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientPhysicalExamCodes phec  WITH(NOLOCK) ON IPP.PatientId = phec.PatientId
	INNER JOIN patient_vitals pv WITH(NOLOCK)  ON pv.pa_vt_id = phec.PhysicalExamId
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON phec.EncounterId = pec.EncounterId
	WHERE  IPP.RequestId = @tempRequestId AND IPP.DoctorId = @DoctorId
	AND DATEDIFF(MONTH,phec.PerformedFromDate, pec.PerformedFromDate) <=12 AND pv.pa_bmi < 18.5
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	
	UPDATE TOP(@MaxRowCount) num
	SET Numerator = 1 
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] num WITH(NOLOCK) where
	(num.Numerator IS NULL OR num.Numerator = 0)  AND
	(num.DenomExclusions IS NULL OR num.DenomExclusions = 0) AND
	(num.DenomExceptions IS NULL OR num.DenomExceptions = 0) AND
	num.RequestId = @tempRequestId
	AND num.PatientId IN (
		SELECT pat.PatientId FROM @temp2 pat
		INNER JOIN cqm2018.PatientMedicationCodes pmc WITH(NOLOCK) ON pat.PatientId = pmc.PatientId AND PrescriptionId IS NOT NULL
		INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm WITH(NOLOCK) on cqm.code = pmc.code
		WHERE cqm.QDMCategoryId = 5 AND cqm.ValueSetId = 11
		AND  DATEDIFF(MONTH, pmc.PerformedFromDate, pat.PerformedFromDate) <=12
		UNION
		SELECT pat.PatientId FROM @temp2 pat
		INNER JOIN cqm2018.PatientInterventionCodes pic  WITH(NOLOCK) ON pic.PatientId = pat.PatientId
		INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm WITH(NOLOCK) on cqm.code = pic.code
		WHERE cqm.QDMCategoryId = 4 AND cqm.ValueSetId IN (10,20)
		AND DATEDIFF(MONTH, pic.PerformedFromDate, pat.PerformedFromDate) <=12
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
