SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the numerator for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS117v6_NQF0038]
	@RequestId BIGINT  
AS
BEGIN
	
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM cqm2018.DoctorCQMCalculationRequest WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	
	IF OBJECT_ID('tempdb..#tempCMS117v6_NQF0038') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempCMS117v6_NQF0038
    END
	
	--and #1 
	SELECT IPP.PatientId INTO #tempCMS117v6_NQF0038
	FROM [cqm2018].[DoctorCQMCalcPop1CMS117v6_NQF0038] IPP WITH(NOLOCK)
	INNER JOIN [cqm2018].PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS117v6_NQF0038] cqm1 WITH(NOLOCK) on cqm1.code = pdc.code
	WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND cqm1.CodeSystemId IN (5,8) AND cqm1.QDMCategoryId = 1 AND cqm1.ValueSetId IN (100,116)
	AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	UNION
	SELECT DISTINCT IPP.PatientId
	FROM cqm2018.DoctorCQMCalcPop1CMS117v6_NQF0038 IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = IPP.PatientId
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
	INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = IPP.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
	INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = IPP.PatientId AND ppc2.PerformedFromDate > ppc3.PerformedFromDate
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc.Code
	INNER JOIN cqm2018.PatientProcedureCodes ppc4 WITH(NOLOCK) ON ppc4.PatientId = IPP.PatientId AND ppc3.PerformedFromDate > ppc4.PerformedFromDate
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm4 WITH(NOLOCK) ON cqm4.Code = ppc.Code
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = IPP.PatientId
	WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND cqm1.CodeSystemId IN (3,5,15) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 115
	AND cqm2.CodeSystemId IN (3,5,15) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 115
	AND cqm3.CodeSystemId IN (3,5,15) AND cqm3.QDMCategoryId = 10 AND cqm3.ValueSetId = 115
	AND cqm4.CodeSystemId IN (3,5,15) AND cqm4.QDMCategoryId = 10 AND cqm4.ValueSetId = 115
	AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc4.PerformedFromDate) <= 730
	UNION
	SELECT DISTINCT IPP.PatientId
	FROM cqm2018.DoctorCQMCalcPop1CMS117v6_NQF0038 IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = IPP.PatientId AND pmc.VaccinationRecordId IS NOT NULL
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code
	INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = IPP.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
	INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = IPP.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc3.PerformedFromDate
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code
	INNER JOIN cqm2018.PatientImmunizationCodes pmc4 WITH(NOLOCK) ON pmc4.PatientId = IPP.PatientId AND pmc4.VaccinationRecordId IS NOT NULL AND pmc3.PerformedFromDate > pmc4.PerformedFromDate
	INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm4 WITH(NOLOCK) ON cqm4.Code = pmc4.Code
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = IPP.PatientId
	WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 114
	AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 114
	AND cqm3.CodeSystemId = 12 AND cqm3.QDMCategoryId = 8 AND cqm3.ValueSetId = 114
	AND cqm4.CodeSystemId = 12 AND cqm4.QDMCategoryId = 8 AND cqm4.ValueSetId = 114
	AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, pmc4.PerformedFromDate) <= 730
	
	--and #2
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 num
	LEFT JOIN (
		SELECT DISTINCT IPP.PatientId
		FROM cqm2018.DoctorCQMCalcPop1CMS117v6_NQF0038 IPP WITH(NOLOCK)
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) on cqm1.code = pdc.code
		WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
		AND cqm1.CodeSystemId=5 AND cqm1.QDMCategoryId = 1 AND cqm1.ValueSetId IN (104,106,108,110)
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT IPP.PatientId
		FROM cqm2018.DoctorCQMCalcPop1CMS117v6_NQF0038 IPP WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = IPP.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = IPP.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = IPP.PatientId AND ppc2.PerformedFromDate > ppc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = IPP.PatientId
		WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
		AND cqm1.CodeSystemId IN (3,5) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 126
		AND cqm2.CodeSystemId IN (3,5) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 126
		AND cqm3.CodeSystemId IN (3,5) AND cqm3.QDMCategoryId = 10 AND cqm3.ValueSetId = 126
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=42 
		UNION
		SELECT DISTINCT IPP.PatientId
		FROM cqm2018.DoctorCQMCalcPop1CMS117v6_NQF0038 IPP WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = IPP.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = IPP.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = IPP.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = IPP.PatientId
		WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
		AND cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 125
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 125
		AND cqm3.CodeSystemId = 12 AND cqm3.QDMCategoryId = 8 AND cqm3.ValueSetId = 125
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=42 
		) i ON i.PatientId = num.PatientId
	WHERE i.PatientId IS NULL
	
	--and #3
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.CodeSystemId IN (13,11,5,14,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (79,106,113,130)
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId IN (3,5) AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId = 135
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038	num
		INNER JOIN cqm2018.PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pmc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId = 12 AND cqm.QDMCategoryId = 8 AND cqm.ValueSetId = 134
		AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 
		UNION
		SELECT * FROM (
			SELECT * FROM (
				SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
				INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
				INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
				WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId IN (147,148)
				AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
				UNION
				SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
				INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
				INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
				WHERE cqm.CodeSystemId IN (5,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 146
				AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate)t3
				INTERSECT
			SELECT * FROM (
				SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
				INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
				INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
				WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId IN (137,138)
				AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
				UNION
				SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
				INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
				INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
				WHERE cqm.CodeSystemId IN (5, 8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 136
				AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate)t2
				INTERSECT
			SELECT * FROM (
				SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
				INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
				INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
				WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId IN (132,133)
				AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
				UNION
				SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
				INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
				INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
				WHERE cqm.CodeSystemId IN (5,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 131
				AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate) t
			) o
	)i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	--and #4
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 num
	LEFT JOIN (
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId IN (3,5,15) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 118
		AND cqm2.CodeSystemId IN (3,5,15)  AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 118
		AND cqm3.CodeSystemId IN (3,5,15) AND cqm3.QDMCategoryId = 10 AND cqm3.ValueSetId = 118
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=10 AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc3.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code
		WHERE cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 117
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 117
		AND cqm3.CodeSystemId = 12 AND cqm3.QDMCategoryId = 8 AND cqm3.ValueSetId = 117
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, pmc3.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.CodeSystemId IN (5,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 113
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate)i ON i.PatientId = num.PatientId
	WHERE i.PatientId IS NULL
	
	--and #5
	
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
		WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId = 112
		AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
		INNER JOIN cqm2018.[SysLookupCMS117v6_NQF0038] cqm WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.CodeSystemId IN (5,8,14) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (99,103,122)
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId IN (3,5) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 124
		AND cqm2.CodeSystemId IN (3,5) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 124
		AND cqm3.CodeSystemId IN (3,5) AND cqm3.QDMCategoryId = 10 AND cqm3.ValueSetId = 124
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc3.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code
		WHERE cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 123
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 123
		AND cqm3.CodeSystemId = 12 AND cqm3.QDMCategoryId = 8 AND cqm3.ValueSetId = 123
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, pmc3.PerformedFromDate) <= 730)i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	-- and #6
	
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
		WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId IN (151,152)
		AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.CodeSystemId IN (5,13,11,14,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (79,106,113,150,130)
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId IN (3,5) AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId = 154
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038	num
		INNER JOIN cqm2018.PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pmc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId = 12 AND cqm.QDMCategoryId = 8 AND cqm.ValueSetId = 153
		AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730)i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	-- and #7
	
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pdc.Code
		WHERE cqm.QDMCategoryId = 1 AND cqm.CodeSystemId = 5 AND cqm.ValueSetId = 107
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc4 WITH(NOLOCK) ON ppc4.PatientId = num.PatientId AND ppc3.PerformedFromDate > ppc4.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm4 WITH(NOLOCK) ON cqm4.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId IN (3,5,15) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 140
		AND cqm2.CodeSystemId IN (3,5,15) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 140
		AND cqm3.CodeSystemId IN (3,5,15) AND cqm3.QDMCategoryId = 10 AND cqm3.ValueSetId = 140
		AND cqm4.CodeSystemId IN (3,5,15) AND cqm4.QDMCategoryId = 10 AND cqm4.ValueSetId = 140
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc4.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc4 WITH(NOLOCK) ON pmc4.PatientId = num.PatientId AND pmc4.VaccinationRecordId IS NOT NULL AND pmc3.PerformedFromDate > pmc4.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm4 WITH(NOLOCK) ON cqm4.Code = pmc4.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 139
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 139
		AND cqm3.CodeSystemId = 12 AND cqm3.QDMCategoryId = 8 AND cqm3.ValueSetId = 139
		AND cqm4.CodeSystemId = 12 AND cqm4.QDMCategoryId = 8 AND cqm4.ValueSetId = 139
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, pmc4.PerformedFromDate) <= 730)i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	-- and #8 
	
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
		WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId = 111
		AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.CodeSystemId IN (5,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (102,119)
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId IN (3,5) AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId = 121
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038	num
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pmc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId = 12 AND cqm.QDMCategoryId = 8 AND cqm.ValueSetId = 120
		AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730)i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	-- and #9
	
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pltc WITH(NOLOCK) ON pltc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pltc.Code
		WHERE cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (5,8) AND cqm.ValueSetId IN (109,129,149)
		AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
		INNER JOIN patients pat  WITH(NOLOCK)ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId IN (3) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 143
		AND cqm2.CodeSystemId IN (3) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 143
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc2.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1  WITH(NOLOCK) ON cqm1.Code = pmc.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 142
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 142
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, pmc2.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId = 12 AND cqm1.QDMCategoryId = 8 AND cqm1.ValueSetId = 144
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 144
		AND cqm3.CodeSystemId = 12 AND cqm3.QDMCategoryId = 8 AND cqm3.ValueSetId = 144
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, pmc3.PerformedFromDate) <= 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc3.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm1.CodeSystemId IN (3) AND cqm1.QDMCategoryId = 10 AND cqm1.ValueSetId = 145
		AND cqm2.CodeSystemId IN (3) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 145
		AND cqm3.CodeSystemId IN (3) AND cqm3.QDMCategoryId = 10 AND cqm3.ValueSetId = 145
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=42 AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc3.PerformedFromDate) <= 730
		UNION 
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code AND cqm1.ValueSetId = 144
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code AND cqm2.ValueSetId = 144
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc3.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code AND cqm3.ValueSetId = 142
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, pmc2.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, pmc3.PerformedFromDate) between 42 and 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code AND cqm1.ValueSetId = 144
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code AND cqm2.ValueSetId = 142
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc3.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code AND cqm3.ValueSetId = 144
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, pmc2.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, pmc3.PerformedFromDate) between 42 and 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = pmc.Code AND cqm1.ValueSetId = 142
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code AND cqm2.ValueSetId = 144
		INNER JOIN cqm2018.PatientImmunizationCodes pmc3 WITH(NOLOCK) ON pmc3.PatientId = num.PatientId AND pmc3.VaccinationRecordId IS NOT NULL AND pmc3.PerformedFromDate > pmc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = pmc3.Code AND cqm3.ValueSetId = 144
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, pmc2.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, pmc3.PerformedFromDate) between 42 and 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code AND cqm1.ValueSetId = 145
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc2.Code AND cqm2.ValueSetId = 145
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc3.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc3.Code AND cqm3.ValueSetId = 143
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, ppc2.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, ppc3.PerformedFromDate) between 42 and 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code AND cqm1.ValueSetId = 145
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc2.Code AND cqm2.ValueSetId = 143
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc3.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc3.Code AND cqm3.ValueSetId = 145
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, ppc2.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, ppc3.PerformedFromDate) between 42 and 730
		UNION
		SELECT DISTINCT num.PatientId
		FROM #tempCMS117v6_NQF0038 num WITH(NOLOCK)
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm1 WITH(NOLOCK) ON cqm1.Code = ppc.Code AND cqm1.ValueSetId = 143
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId AND ppc2.PerformedFromDate > ppc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc2.Code AND cqm2.ValueSetId = 145
		INNER JOIN cqm2018.PatientProcedureCodes ppc3 WITH(NOLOCK) ON ppc3.PatientId = num.PatientId AND ppc3.PerformedFromDate > ppc2.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm3 WITH(NOLOCK) ON cqm3.Code = ppc3.Code AND cqm3.ValueSetId = 145
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, ppc2.PerformedFromDate) between 42 and 730
		AND DATEDIFF(DAY,pat.pa_dob, ppc3.PerformedFromDate) between 42 and 730
		 )i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	-- and #10
	
	DELETE #tempCMS117v6_NQF0038
	FROM #tempCMS117v6_NQF0038 pnum
	LEFT JOIN (
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = num.patientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.CodeSystemId IN (13,5,11,14,8) AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId IN (79,105,106,113,130)
		AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038 num
		INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = ppc.Code
		INNER JOIN cqm2018.PatientProcedureCodes ppc2 WITH(NOLOCK) ON ppc2.PatientId = num.PatientId
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = ppc2.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId IN (3,5) AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId = 128
		AND cqm2.CodeSystemId IN (3,5) AND cqm2.QDMCategoryId = 10 AND cqm2.ValueSetId = 128
		AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) <= 730 AND DATEDIFF(DAY,pat.pa_dob, ppc.PerformedFromDate) >=180
		UNION
		SELECT DISTINCT num.PatientId FROM #tempCMS117v6_NQF0038	num
		INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = num.PatientId AND pmc.VaccinationRecordId IS NOT NULL
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm WITH(NOLOCK) ON cqm.Code = pmc.Code
		INNER JOIN cqm2018.PatientImmunizationCodes pmc2 WITH(NOLOCK) ON pmc2.PatientId = num.PatientId AND pmc2.VaccinationRecordId IS NOT NULL AND pmc2.PerformedFromDate > pmc.PerformedFromDate
		INNER JOIN cqm2018.SysLookupCMS117v6_NQF0038 cqm2 WITH(NOLOCK) ON cqm2.Code = pmc2.Code
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = num.PatientId
		WHERE cqm.CodeSystemId = 12 AND cqm.QDMCategoryId = 8 AND cqm.ValueSetId = 127
		AND cqm2.CodeSystemId = 12 AND cqm2.QDMCategoryId = 8 AND cqm2.ValueSetId = 127
		AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) >=180 
		AND DATEDIFF(DAY,pat.pa_dob, pmc.PerformedFromDate) <= 730)i ON i.PatientId = pnum.PatientId
	WHERE i.PatientId IS NULL
	
	UPDATE IPP
	set Numerator = 1
	FROM cqm2018.DoctorCQMCalcPop1CMS117v6_NQF0038 IPP WITH(NOLOCK)
	INNER JOIN #tempCMS117v6_NQF0038 num WITH(NOLOCK) ON num.PatientId = IPP.PatientId
	WHERE IPP.DoctorId = @DoctorId AND IPP.RequestId = @RequestId
	AND IPP.Numerator IS NULL OR IPP.Numerator = 0
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	DROP TABLE #tempCMS117v6_NQF0038

	SELECT @AffectedRows;
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
