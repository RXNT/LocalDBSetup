SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 14-NOV-2022
-- Description:	To save the Denom Exclusions 
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SavePop1DenomExclusionsCMS153v11_NQF0033]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRows INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2023].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,@StartDate)
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.DenomExclusions = 1
	FROM [cqm2023].[DoctorCQMCalcPop1CMS153v11_NQF0033] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN [cqm2023].PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = IPP.PatientId
	INNER JOIN [cqm2023].[SysLookupCMS153v11_NQF0033] as cqm with(NOLOCK) on pltc.Code = cqm.Code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0) 
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId=25 AND cqm.ValueSetId = 86
	AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND EXISTS (
		SELECT 1 FROM cqm2023.PatientDiagnosticStudyCodes pdsc  WITH(NOLOCK)
		INNER JOIN patients pat1 WITH(NOLOCK) ON pdsc.PatientId=pat1.pa_id
		INNER JOIN [cqm2023].[SysLookupCMS153v11_NQF0033] as cqm with(NOLOCK) on pdsc.Code = cqm.Code
		WHERE pdsc.PatientId = IPP.PatientId AND pdsc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND cqm.QDMCategoryId = 15 AND cqm.CodeSystemId = 25 AND cqm.ValueSetId = 91
		AND DATEDIFF(day,pdsc.PerformedFromDate,pltc.PerformedFromDate) <= 7
	)
	 
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END	
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.DenomExclusions = 1
	FROM [cqm2023].[DoctorCQMCalcPop1CMS153v11_NQF0033] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN [cqm2023].PatientLaboratoryTestCodes pltc WITH(NOLOCK) ON pltc.PatientId = IPP.PatientId
	INNER JOIN [cqm2023].[SysLookupCMS153v11_NQF0033] as cqm with(NOLOCK) on pltc.Code = cqm.Code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0)
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId=25 AND cqm.ValueSetId = 86
	AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND EXISTS (
		SELECT 1 FROM cqm2023.PatientMedicationCodes pmc 
		INNER JOIN patients pat1 WITH(NOLOCK) ON pmc.PatientId=pat1.pa_id
		INNER JOIN [cqm2023].[SysLookupCMS153v11_NQF0033] as cqm with(NOLOCK) on pmc.Code = cqm.Code
		WHERE pmc.PatientId = IPP.PatientId AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND cqm.QDMCategoryId = 5 AND cqm.CodeSystemId = 26 AND cqm.ValueSetId = 81
		AND DATEDIFF(day,pmc.PerformedFromDate,pltc.PerformedFromDate) <= 7
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
