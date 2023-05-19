SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 13-NOV-2018
-- Description:	To save the numerator for the measure

-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop1NumeratorCMS147v8_NQF0041]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRowCount INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	UPDATE TOP(@MaxRowCount) cqm2019.DoctorCQMCalcPOP1CMS147v8_NQF0041
	SET Numerator = 1 
	FROM [cqm2019].[DoctorCQMCalcPOP1CMS147v8_NQF0041] pat WITH(NOLOCK)
	INNER JOIN patients pa WITH(NOLOCK) ON pa.pa_id=pat.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pa.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientProcedureCodes ppc_s WITH(NOLOCK) ON ppc_s.PatientId = pat.PatientId
	INNER JOIN cqm2019.[SysLookupCMS147v8_NQF0041] cqm WITH(NOLOCK) on cqm.Code = ppc_s.Code
	WHERE dg.dc_id=@DoctorCompanyId AND cqm.QDMCategoryId = 22 AND cqm.ValueSetId = 184 
	AND ppc_s.PerformedFromDate BETWEEN @StartDate AND @EndDate 
	AND DATEDIFF(DAY,ppc_s.PerformedFromDate,@StartDate) BETWEEN -153 AND 89
	AND pat.Numerator IS NULL OR pat.Numerator = 0 
	AND (pat.DenomExceptions=0 OR pat.DenomExceptions IS NULL)  	
	

	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	 BEGIN 
		SET @AffectedRows = @tempRowCount;
	 END

	UPDATE TOP(@MaxRowCount) cqm2019.DoctorCQMCalcPOP1CMS147v8_NQF0041
	SET Numerator = 1
	FROM cqm2019.DoctorCQMCalcPOP1CMS147v8_NQF0041 pat WITH(NOLOCK)
	INNER JOIN patients pa WITH(NOLOCK) ON pa.pa_id=pat.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pa.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientImmunizationCodes pmc WITH(NOLOCK) on pmc.PatientId = pat.PatientId
	INNER JOIN [cqm2019].[SysLookupCMS147v8_NQF0041] cqm WITH(NOLOCK) ON pmc.Code = cqm.code
	WHERE dg.dc_id=@DoctorCompanyId AND cqm.QDMCategoryId = 21 AND cqm.ValueSetId = 185
	AND pmc.PerformedFromDate between @StartDate AND @EndDate 
	AND DATEDIFF(DAY,pmc.PerformedFromDate ,@StartDate) BETWEEN -153 AND 89
	AND pat.Numerator IS NULL OR pat.Numerator = 0
	AND (pat.DenomExceptions=0 OR pat.DenomExceptions IS NULL) 
	
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
