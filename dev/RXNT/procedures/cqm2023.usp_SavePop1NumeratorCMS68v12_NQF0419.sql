SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 31st-October-2022
-- Description:	To save the numerator for the measure

-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SavePop1NumeratorCMS68v12_NQF0419]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRowsCount INT = 100
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
	
	INSERT INTO cqm2023.DoctorCQMCalcPop1CMS68v12_NQF0419
	(PatientId, Numerator, DoctorId, RequestId,DatePerformed)
	SELECT TOP(@MaxRowsCount) pat.pa_id, 1 as Numerator, @DoctorId, @RequestId,pmc.PerformedFromDate 
	--UPDATE calc SET Numerator = 1
	FROM  cqm2023.[DoctorCQMCalcPop1CMS68v12_NQF0419] calc WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=calc.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.PatientMedicationCodes pmc WITH(NOLOCK) ON calc.PatientId=pmc.PatientId
	WHERE dg.dc_id=@DoctorCompanyId AND calc.RequestId = @RequestId AND calc.DoctorId = @DoctorId 
	AND (calc.Numerator IS NULL OR calc.Numerator = 0)
	AND  pmc.DoctorId = @DoctorId AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate

	INSERT INTO cqm2023.DoctorCQMCalcPop1CMS68v12_NQF0419
	(PatientId, Numerator, DoctorId, RequestId,DatePerformed)
	SELECT TOP(@MaxRowsCount) pat.pa_id, 1 as Numerator, @DoctorId, @RequestId,ppc.PerformedFromDate 
	--UPDATE calc SET Numerator = 1
	FROM  patients pat WITH(NOLOCK)
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.PatientProcedureCodes ppc WITH(NOLOCK) ON pat.pa_id=ppc.PatientId AND ppc.CODE='428191000124101' AND ppc.Status='Completed' AND LEN(ISNULL(ppc.ReasonTypeCode,''))=0
	LEFT JOIN cqm2023.DoctorCQMCalcPop1CMS68v12_NQF0419 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId AND CAST(ppc.PerformedFromDate AS DATE)=CAST(IPP.DatePerformed AS DATE) AND IPP.Numerator =1
	WHERE dg.dc_id=@DoctorCompanyId AND ppc.DoctorId = @DoctorId 
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND  ppc.DoctorId = @DoctorId AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	 
	INSERT INTO cqm2023.DoctorCQMCalcPop1CMS68v12_NQF0419
	(PatientId, Numerator, DoctorId, RequestId,DatePerformed)
	SELECT DISTINCT TOP(@MaxRowsCount) pat.pa_id, 1 as Numerator, @DoctorId, @RequestId,ppc.PerformedFromDate 
	--UPDATE calc SET Numerator = 1
	FROM  patients pat WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2023.[PatientInterventionCodes] ppc WITH(NOLOCK) ON pat.pa_id=ppc.PatientId AND ppc.CODE='428191000124101' AND ppc.Status='Completed' AND LEN(ISNULL(ppc.ReasonTypeCode,''))=0
	LEFT JOIN cqm2023.DoctorCQMCalcPop1CMS68v12_NQF0419 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId AND CAST(ppc.PerformedFromDate AS DATE)=CAST(IPP.DatePerformed AS DATE) AND IPP.Numerator =1
	WHERE dg.dc_id=@DoctorCompanyId AND ppc.DoctorId = @DoctorId 
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND  ppc.DoctorId = @DoctorId AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	 
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
