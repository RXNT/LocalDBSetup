SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 14-NOV-2018
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop1IPPCMS153v7_NQF0033]
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
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	IF OBJECT_ID('tempdb..#tempCMS153v7_NQF0033') IS NOT NULL 
	BEGIN  
		DROP TABLE #tempCMS153v7_NQF0033
    END
	
	SELECT DISTINCT pat.pa_id INTO #tempCMS153v7_NQF0033
	FROM cqm2019.PatientEncounterCodes pec WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = pec.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	LEFT JOIN cqm2019.DoctorCQMCalcPop1CMS153v7_NQF0033 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.CalcId IS NULL AND pec.DoctorId = @DoctorId
	AND NOT (pa_dob LIKE '1901-01-01') AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate)  BETWEEN  16*12 AND 24*12 AND pat.pa_sex = 'F'
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	
	INSERT INTO [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033]
    (PatientId, IPP, Denominator, DoctorId, RequestId)
	SELECT DISTINCT TOP(@MaxRecords) i.pa_id, 1, 1, @DoctorId, @RequestId FROM (
		SELECT tmp.pa_id FROM #tempCMS153v7_NQF0033 tmp 
		INNER JOIN patients pat WITH(NOLOCK) ON tmp.pa_id=pat.pa_id
		INNER JOIN cqm2019.PatientDiagnosisCodes pdc  WITH(NOLOCK)ON pdc.PatientId = tmp.pa_id
		INNER JOIN patient_active_diagnosis pad with(NOLOCK) ON pad.pad = pdc.DiagnosisId
		INNER JOIN [cqm2019].[SysLookupCMS153v7_NQF0033] as cqm_pad with(NOLOCK) on pdc.Code = cqm_pad.Code
		WHERE cqm_pad.QDMCategoryId = 1 AND cqm_pad.CodeSystemId IN (15,12,6,17,14,8)   AND cqm_pad.ValueSetId IN (70,72,77,78,79,80,84,90,188)
		AND pad.onset < @EndDate AND pdc.DoctorId = @DoctorId
		UNION
		SELECT tmp.pa_id FROM #tempCMS153v7_NQF0033 tmp 
		INNER JOIN patients pat WITH(NOLOCK) ON tmp.pa_id=pat.pa_id
		INNER JOIN cqm2019.PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = tmp.pa_id
		INNER JOIN cqm2019.SysLookupCMS153v7_NQF0033 cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.MedicationId IS NOT NULL
		WHERE pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND pmc.DoctorId = @DoctorId AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 7 AND cqm.ValueSetId = 73 ) i
	LEFT JOIN cqm2019.DoctorCQMCalcPop1CMS153v7_NQF0033 IPP WITH(NOLOCK) ON IPP.PatientId = i.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	INSERT INTO [cqm2019].[DoctorCQMCalcPop1CMS153v7_NQF0033]
    (PatientId, IPP, Denominator, DoctorId, RequestId)  
	SELECT DISTINCT TOP(@MaxRecords) i.pa_id, 1, 1, @DoctorId, @RequestId FROM (
		SELECT tmp.pa_id FROM #tempCMS153v7_NQF0033 tmp 
		INNER JOIN patients pat WITH(NOLOCK) ON tmp.pa_id=pat.pa_id
		INNER JOIN cqm2019.PatientLaboratoryTestCodes pltc  WITH(NOLOCK)ON pltc.PatientId = tmp.pa_id
		INNER JOIN cqm2019.SysLookupCMS153v7_NQF0033 as cqm with(NOLOCK) on pltc.Code = cqm.Code
		WHERE cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 13 AND cqm.ValueSetId IN (82,83,85,86)
		AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT tmp.pa_id FROM #tempCMS153v7_NQF0033 tmp 
		INNER JOIN patients pat WITH(NOLOCK) ON tmp.pa_id=pat.pa_id
		INNER JOIN cqm2019.PatientMedicationCodes pmc WITH(NOLOCK) ON pmc.PatientId = tmp.pa_id
		INNER JOIN cqm2019.SysLookupCMS153v7_NQF0033 cqm WITH(NOLOCK) ON pmc.Code = cqm.code AND pmc.PrescriptionId IS NOT NULL
		WHERE pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND pmc.DoctorId = @DoctorId AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 7 AND cqm.ValueSetId IN (73)
		UNION
		SELECT tmp.pa_id FROM #tempCMS153v7_NQF0033 tmp 
		INNER JOIN patients pat WITH(NOLOCK) ON tmp.pa_id=pat.pa_id
		INNER JOIN cqm2019.PatientProcedureCodes ppc_s WITH(NOLOCK) ON ppc_s.PatientId = tmp.pa_id
		INNER JOIN cqm2019.SysLookupCMS153v7_NQF0033 cqm WITH(NOLOCK) on cqm.Code = ppc_s.Code
		WHERE cqm.QDMCategoryId = 10 AND cqm.CodeSystemId IN (4,5,8) AND cqm.ValueSetId IN (74,87,88)
		AND ppc_s.PerformedFromDate BETWEEN @StartDate AND @EndDate
		UNION
		SELECT tmp.pa_id FROM #tempCMS153v7_NQF0033 tmp 
		INNER JOIN patients pat WITH(NOLOCK) ON tmp.pa_id=pat.pa_id
		INNER JOIN cqm2019.PatientDiagnosticStudyCodes pdsc WITH(NOLOCK) ON pdsc.PatientId = tmp.pa_id
		INNER JOIN cqm2019.SysLookupCMS153v7_NQF0033 as cqm with(NOLOCK) on pdsc.Code = cqm.Code
		WHERE cqm.QDMCategoryId = 15 AND cqm.CodeSystemId = 13 AND cqm.ValueSetId IN (75)
		AND pdsc.DoctorId = @DoctorId AND pdsc.PerformedFromDate BETWEEN @StartDate AND @EndDate)i
	LEFT JOIN cqm2019.DoctorCQMCalcPop1CMS153v7_NQF0033 IPP WITH(NOLOCK) ON IPP.PatientId = i.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	DROP TABLE #tempCMS153v7_NQF0033

	SELECT @AffectedRows
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
