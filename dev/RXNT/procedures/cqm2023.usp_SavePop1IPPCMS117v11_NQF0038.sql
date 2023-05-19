SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 8th-NOV-2022
-- Description:	To save the initial patient population for the measure
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SavePop1IPPCMS117v11_NQF0038]
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
	FROM [cqm2023].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	INSERT INTO [cqm2023].[DoctorCQMCalcPop1CMS117v11_NQF0038]
	(PatientId, IPP, Denominator, DoctorId, RequestId)
	SELECT DISTINCT TOP(@MaxRowsCount) pat.pa_id, 1 as IPP, 1 as 'Denominator', @DoctorId, @RequestId
	FROM [cqm2023].[PatientEncounterCodes] pec WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id = pec.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	LEFT JOIN [cqm2023].[DoctorCQMCalcPop1CMS117v11_NQF0038] IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE IPP.CalcId IS NULL AND pec.DoctorId = @DoctorId
	AND NOT (pa_dob LIKE '1901-01-01') AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate)  BETWEEN  1*12 AND 2*12
	AND dg.dc_id=@DoctorCompanyId
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate

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
