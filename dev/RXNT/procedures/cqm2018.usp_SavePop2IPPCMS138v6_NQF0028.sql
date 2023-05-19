SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 12-May-2017
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop2IPPCMS138v6_NQF0028] 
	@RequestId BIGINT  
AS
BEGIN

	DECLARE @MaxRecords BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM cqm2018.DoctorCQMCalculationRequest WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,'2017-01-01 00:00:00');

	INSERT INTO cqm2018.DoctorCQMCalcPop2CMS138v6_NQF0028
    (PatientId, IPP, DoctorId, RequestId)   
    SELECT DISTINCT TOP(@MaxRecords) pat.pa_id,  1, @DoctorId, @RequestId 
    FROM patients pat WITH(NOLOCK) 
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON pec.PatientId=pat.pa_id
	LEFT JOIN [cqm2018].[DoctorCQMCalcPop2CMS138v6_NQF0028] IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL AND pec.DoctorId = @DoctorId AND datediff(month,PAT.pa_dob,CONVERT(datetime,@StartDate)) >= 18*12 AND NOT (pa_dob LIKE '1901-01-01')
	
	UPDATE TOP(@MaxRecords) IPP
	SET IPP.Denominator = 1
	FROM [cqm2018].[DoctorCQMCalcPop2CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN [cqm2018].[PatientRiskCategoryOrAssessmentCodes] prc WITH(NOLOCK) ON prc.PatientId = IPP.PatientId
	INNER JOIN [dbo].[patient_flag_details] pfd WITH(NOLOCK) ON pfd.pa_flag_id=prc.RiskCategoryOrAssessmentId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm_r WITH(NOLOCK) on cqm_r.Code = prc.Code
	WHERE IPP.RequestId = @RequestId AND IPP.Denominator IS NULL AND cqm_r.ValueSetId=167 AND
	prc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate AND pfd.flag_id IN (-5,-4,-2,-1,5)
	
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
