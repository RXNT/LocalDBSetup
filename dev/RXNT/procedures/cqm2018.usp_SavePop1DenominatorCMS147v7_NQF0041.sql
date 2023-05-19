SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenominatorCMS147v7_NQF0041]
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
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	UPDATE top(@MaxRowCount) IPP
	SET Denominator = 1
	FROM cqm2018.[DoctorCQMCalcPop1CMS147v7_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN (
		SELECT pec.PatientId,pec.DoctorId
		FROM cqm2018.PatientEncounterCodes pec WITH(NOLOCK) 
		INNER JOIN cqm2018.SysLookupCMS147v7_NQF0041 cqm WITH(NOLOCK) on cqm.code = pec.Code
		WHERE pec.DoctorId = @DoctorId 
		AND DATEDIFF(DAY,@StartDate,pec.PerformedFromDate) BETWEEN -92 AND 89
		GROUP BY pec.PatientId ,pec.DoctorId HAVING COUNT(pec.PatientId) >= 1
		
		UNION 
		
		SELECT ppc.PatientId,ppc.DoctorId
		FROM cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) 
		INNER JOIN cqm2018.SysLookupCMS147v7_NQF0041 cqm WITH(NOLOCK) on cqm.code = ppc.Code
		WHERE ppc.DoctorId = @DoctorId AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId IN (55,64)
		AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND DATEDIFF(DAY,@StartDate,ppc.PerformedFromDate) BETWEEN -92 AND 89
		GROUP BY ppc.PatientId ,ppc.DoctorId HAVING COUNT(ppc.PatientId) >= 1
		
	) tmp ON tmp.PatientId=IPP.PatientId
	WHERE tmp.DoctorId = @DoctorId 
	AND (IPP.Denominator IS NULL OR IPP.Denominator = 0) AND IPP.RequestId = @RequestId
	
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
