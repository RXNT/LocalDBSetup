SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 13-NOV-2022
-- Description:	To save the Denom Exception
-- QDM data for this Calculation is not in system
-- =============================================
CREATE   PROCEDURE [cqm2022].[usp_SavePop2DenomExceptionsCMS138v10_NQF0028]
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
	FROM [cqm2022].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId;
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,@StartDate)
	
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.DenomExceptions = 1
	FROM [cqm2022].[DoctorCQMCalcPop2CMS138v10_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN [cqm2022].[PatientDiagnosisCodes] pdc WITH(NOLOCK) ON pdc.PatientId = IPP.PatientId
	INNER JOIN [cqm2022].[SysLookupCMS138v10_NQF0028] cqm WITH(NOLOCK) on cqm.Code = pdc.Code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND (IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0)
	AND pdc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate  
	AND NOT  pdc.PerformedToDate BETWEEN @measureStartDate AND @EndDate  
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN(2,27,28,29,30,31) AND cqm.ValueSetId = 158
	 
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END	

	SELECT @AffectedRows	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
