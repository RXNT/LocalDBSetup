SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the initial patient population for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop1IPPCMS147v7_NQF0041]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	INSERT INTO cqm2018.DoctorCQMCalcPop1CMS147v7_NQF0041
	(DoctorId,RequestId,PatientId,IPP, Denominator)	
	SELECT TOP (@MaxRowsCount) @DoctorId, @RequestId, pat.pa_id, 1, 0
	FROM patients PAT WITH(NOLOCK) 
	INNER JOIN (
		SELECT ppc.PatientId,ppc.DoctorId
		FROM cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) 
		INNER JOIN cqm2018.SysLookupCMS147v7_NQF0041 cqm WITH(NOLOCK) on cqm.code = ppc.Code
		WHERE cqm.QDMCategoryId = 10 AND cqm.ValueSetId IN (112,122) AND ppc.DoctorId = @DoctorId 
		AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		GROUP BY ppc.PatientId ,ppc.DoctorId HAVING COUNT(ppc.PatientId) >= 1
		
		UNION 
		
		SELECT pec.PatientId,pec.DoctorId
		FROM cqm2018.PatientEncounterCodes pec WITH(NOLOCK) 
		INNER JOIN cqm2018.SysLookupCMS147v7_NQF0041 cqm WITH(NOLOCK) on cqm.code = pec.Code
		WHERE pec.DoctorId = @DoctorId 
		AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
		GROUP BY pec.PatientId ,pec.DoctorId HAVING COUNT(pec.PatientId) >= 1
		
	) tmp ON tmp.PatientId=PAT.pa_id
	LEFT OUTER JOIN [cqm2018].[DoctorCQMCalcPop1CMS147v7_NQF0041] IPP WITH(NOLOCK)  ON IPP.RequestId = @RequestId AND IPP.PatientId = pat.pa_id AND IPP.IPP = 1
	WHERE tmp.DoctorId = @DoctorId AND IPP.CalcId IS NULL AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate) > 6 AND NOT (PAT.pa_dob like '1901-01-01') AND NOT (pa_dob LIKE '1901-01-01') 
	
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
