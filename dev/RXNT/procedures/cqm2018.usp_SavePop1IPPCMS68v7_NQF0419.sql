SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-February-2018
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1IPPCMS68v7_NQF0419]
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
	FROM cqm2018.[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	INSERT INTO cqm2018.DoctorCQMCalcPop1CMS68v7_NQF0419
	(PatientId, IPP, Denominator, DoctorId, RequestId)
	SELECT DISTINCT TOP(@MaxRowsCount) pat.pa_id, 1 as IPP, 1 as 'Denominator', @DoctorId, @RequestId
	FROM cqm2018.PatientEncounterCodes pec WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = pec.PatientId
	LEFT JOIN cqm2018.DoctorCQMCalcPop1CMS68v7_NQF0419 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE NOT (pa_dob LIKE '1901-01-01') AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate) >= 18*12
	AND pec.DoctorId = @DoctorId
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND IPP.CalcId IS NULL
	
	
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
