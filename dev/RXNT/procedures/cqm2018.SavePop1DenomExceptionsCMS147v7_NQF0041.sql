SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--=============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[SavePop1DenomExceptionsCMS147v7_NQF0041]  
	@RequestId BIGINT  
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99201';
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	--Occurrence A of Diagnosis: Allergy to Eggs--
	UPDATE TOP(@MaxRowsCount) IPP
	SET DenomExceptions = 1
	FROM cqm2018.DoctorCQMCalcPop1CMS147v7_NQF0041 IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN cqm2018.SysLookUpCMS147v7_NQF0041 cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (5,8,11) AND cqm.ValueSetId = 48
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
	FROM cqm2018.[DoctorCQMCalcPop1CMS147v7_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN cqm2018.[SysLookUpCMS147v7_NQF0041] cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (5) AND cqm.ValueSetId = 49
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
	FROM cqm2018.[DoctorCQMCalcPop1CMS147v7_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN cqm2018.SysLookUpCMS147v7_NQF0041 cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 59 AND cqm.CodeSystemId IN (5)
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
	FROM cqm2018.[DoctorCQMCalcPop1CMS147v7_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON ppc.patientId = IPP.patientId
	INNER JOIN cqm2018.[SysLookUpCMS147v7_NQF0041] cqm WITH(NOLOCK) on cqm.code = ppc.code
	WHERE IPP.DoctorId = @DoctorId 
	AND cqm.QDMCategoryId IN (10,16) AND cqm.CodeSystemId IN (3,4,5) AND cqm.ValueSetId IN (53,56)
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
	FROM cqm2018.[DoctorCQMCalcPop1CMS147v7_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientImmunizationCodes pmc WITH(NOLOCK) ON pmc.PatientId = IPP.patientId
	INNER JOIN cqm2018.[SysLookUpCMS147v7_NQF0041] cqm WITH(NOLOCK) on cqm.code = pmc.code
	WHERE IPP.DoctorId = @DoctorId
	AND cqm.QDMCategoryId = 8 AND cqm.CodeSystemId = 10 AND cqm.ValueSetId = 58
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
