SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--=============================================
-- Author:		Niyaz
-- Create date: 13-NOV-2018
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE PROCEDURE [cqm2019].[SavePop1DenomExceptionsCMS147v8_NQF0041]  
	@RequestId BIGINT  
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99201';
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	--Occurrence A of Diagnosis: Allergy to Eggs--
	UPDATE TOP(@MaxRowsCount) IPP
	SET DenomExceptions = 1
	FROM cqm2019.DoctorCQMCalcPop1CMS147v8_NQF0041 IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN cqm2019.SysLookUpCMS147v8_NQF0041 cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (6,8,12) AND cqm.ValueSetId = 48
	AND (pdc.PerformedFromDate BETWEEN @StartDate AND  @EndDate OR pdc.PerformedToDate BETWEEN @StartDate AND @EndDate)
	AND NOT DATEDIFF(DAY,@StartDate,pdc.PerformedFromDate) > 89 
	AND NOT DATEDIFF(DAY,@StartDate,ISNULL(pdc.PerformedToDate,DATEADD(DAY,90,@StartDate))) <= 89
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 AND IPP.RequestId = @RequestId
	
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Occurrence A of Diagnosis: Allergy to Influenza Vaccine--
	UPDATE top(@MaxRowsCount) IPP
	SET DenomExceptions = 1
	FROM cqm2019.[DoctorCQMCalcPop1CMS147v8_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN cqm2019.[SysLookUpCMS147v8_NQF0041] cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (8) AND cqm.ValueSetId = 49
	AND (pdc.PerformedFromDate BETWEEN @StartDate AND  @EndDate OR pdc.PerformedToDate BETWEEN @StartDate AND @EndDate)
	AND NOT DATEDIFF(DAY,@StartDate,pdc.PerformedFromDate) > 89 
	AND NOT DATEDIFF(DAY,@StartDate,ISNULL(pdc.PerformedToDate,DATEADD(DAY,90,@StartDate))) <= 89
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 AND IPP.RequestId = @RequestId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	--Occurrence A of Diagnosis: Intolerance to Influenza Vaccine--
	UPDATE top(@MaxRowsCount) IPP
	SET DenomExceptions = 1
	FROM cqm2019.[DoctorCQMCalcPop1CMS147v8_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN cqm2019.SysLookUpCMS147v8_NQF0041 cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 59 AND cqm.CodeSystemId IN (8)
	AND (pdc.PerformedFromDate BETWEEN @StartDate AND  @EndDate OR pdc.PerformedToDate BETWEEN @StartDate AND @EndDate)
	AND NOT DATEDIFF(DAY,@StartDate,pdc.PerformedFromDate) > 89 
	AND NOT DATEDIFF(DAY,@StartDate,ISNULL(pdc.PerformedToDate,DATEADD(DAY,90,@StartDate))) <= 89
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 AND IPP.RequestId = @RequestId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	
	--Occurrence A of Procedure, Intolerance: Influenza Vaccination--
	--Occurrence A of Substance, Allergy: Egg Substance--
	UPDATE top(@MaxRowsCount) IPP
	SET DenomExceptions = 1
	FROM cqm2019.[DoctorCQMCalcPop1CMS147v8_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.patientId = IPP.patientId
	INNER JOIN cqm2019.[SysLookUpCMS147v8_NQF0041] cqm WITH(NOLOCK) on cqm.code = ppc.code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId 
	AND cqm.QDMCategoryId IN (2110,16) AND cqm.CodeSystemId IN (10) AND cqm.ValueSetId IN (185)
	AND (ppc.PerformedFromDate BETWEEN @StartDate AND  @EndDate OR ppc.PerformedToDate BETWEEN @StartDate AND @EndDate)
	AND NOT DATEDIFF(DAY,@StartDate,ppc.PerformedFromDate) > 89
	AND NOT DATEDIFF(DAY,@StartDate,ISNULL(ppc.PerformedToDate,DATEADD(DAY,90,@StartDate))) <= 89
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 AND IPP.RequestId = @RequestId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	 --Occurrence A of Immunization, Intolerance: Influenza Vaccination-- 
	 --Occurrence A of Immunization, Allergy: Influenza Vaccine--
	UPDATE TOP(@MaxRowsCount) IPP
	SET DenomExceptions = 1
	FROM cqm2019.[DoctorCQMCalcPop1CMS147v8_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = IPP.patientId
	INNER JOIN cqm2019.[SysLookUpCMS147v8_NQF0041] cqm WITH(NOLOCK) on cqm.code = pmc.code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 21 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 185
	AND (pmc.PerformedFromDate BETWEEN @StartDate AND  @EndDate OR pmc.PerformedToDate BETWEEN @StartDate AND @EndDate)
	AND DATEDIFF(DAY,pmc.PerformedFromDate,@StartDate) > 89 
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 AND IPP.RequestId = @RequestId
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END
	
	SELECT @AffectedRows;
	
	SET NOCOUNT OFF;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
