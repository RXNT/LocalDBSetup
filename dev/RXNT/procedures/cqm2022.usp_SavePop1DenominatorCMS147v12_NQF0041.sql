SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 11-MAY-2023
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop1DenominatorCMS147v12_NQF0041]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2022].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	UPDATE top(@MaxRowCount) IPP
	SET Denominator = 1
	FROM cqm2022.[DoctorCQMCalcPop1CMS147v12_NQF0041] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN (
		SELECT pec.PatientId,pec.DoctorId
		FROM cqm2022.PatientEncounterCodes pec WITH(NOLOCK) 
		INNER JOIN patients pat WITH(NOLOCK) ON  pec.PatientId=pat.pa_id
		INNER JOIN cqm2022.SysLookupCMS147v12_NQF0041 cqm WITH(NOLOCK) on cqm.code = pec.Code
		WHERE pec.DoctorId = @DoctorId 
		AND DATEDIFF(DAY,@StartDate,pec.PerformedFromDate) BETWEEN -92 AND 89
		GROUP BY pec.PatientId ,pec.DoctorId HAVING COUNT(pec.PatientId) >= 1
		
		UNION 
		
		SELECT ppc.PatientId,ppc.DoctorId
		FROM cqm2022.PatientProcedureCodes ppc WITH(NOLOCK) 
		INNER JOIN patients pat WITH(NOLOCK) ON  ppc.PatientId=pat.pa_id
		INNER JOIN cqm2022.SysLookupCMS147v12_NQF0041 cqm WITH(NOLOCK) on cqm.code = ppc.Code
		WHERE ppc.DoctorId = @DoctorId AND cqm.QDMCategoryId = 10 AND cqm.ValueSetId IN (55,64)
		AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND DATEDIFF(DAY,@StartDate,ppc.PerformedFromDate) BETWEEN -92 AND 89
		GROUP BY ppc.PatientId ,ppc.DoctorId HAVING COUNT(ppc.PatientId) >= 1
		
	) tmp ON tmp.PatientId=IPP.PatientId
	WHERE dg.dc_id=@DoctorCompanyId AND tmp.DoctorId = @DoctorId 
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
