SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 31st-October-2022
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop1IPPCMS68v12_NQF0419]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM cqm2022.[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	INSERT INTO cqm2022.DoctorCQMCalcPop1CMS68v12_NQF0419
	(PatientId, IPP, Denominator, DoctorId, RequestId,DatePerformed)
	SELECT TOP(@MaxRowsCount) pat.pa_id, 1 as IPP, 1 as 'Denominator', @DoctorId, @RequestId,pec.PerformedFromDate 
	FROM cqm2022.PatientEncounterCodes pec WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = pec.PatientId
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id = pec.DoctorId AND pat.dg_id=dr.dg_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	LEFT JOIN cqm2022.DoctorCQMCalcPop1CMS68v12_NQF0419 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId AND CAST(pec.PerformedFromDate AS DATE)=CAST(IPP.DatePerformed AS DATE)
	WHERE NOT (pa_dob LIKE '1901-01-01') AND  DATEDIFF(MONTH,PAT.pa_dob,@StartDate) >= 18*12
	AND dg.dc_id=@DoctorCompanyId
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
