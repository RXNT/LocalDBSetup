SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the initial patient population 2 for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop2IPPCMS155v6_NQF0024]
	@RequestId BIGINT  
AS
BEGIN

	DECLARE @MaxRecords BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	INSERT INTO [cqm2018].[DoctorCQMCalcPop2CMS155v6_NQF0024]
    (PatientId, IPP, Denominator, DoctorId, RequestId)   
	SELECT DISTINCT pat.pa_id, 1, 1, @DoctorId, @RequestId 
	FROM cqm2018.PatientEncounterCodes pec WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = pec.PatientId
	LEFT JOIN cqm2018.[DoctorCQMCalcPop2CMS155v6_NQF0024] IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL AND pec.DoctorId = @DoctorId
	AND NOT (pa_dob LIKE '1901-01-01') AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate)  BETWEEN  3*12 AND 17*12
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
