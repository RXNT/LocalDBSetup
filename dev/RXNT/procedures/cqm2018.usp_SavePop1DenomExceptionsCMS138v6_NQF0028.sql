SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the Denom Exception
-- QDM data for this Calculation is not in system
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenomExceptionsCMS138v6_NQF0028]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRows INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId;
	
	DECLARE @measureStartDate DATETIME = DATEADD(year,-1,@StartDate)
	
	
	UPDATE TOP(@MaxRows) IPP
	SET IPP.DenomExceptions = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS138v6_NQF0028] IPP WITH(NOLOCK)
	INNER JOIN [cqm2018].[PatientDiagnosisCodes] pdc WITH(NOLOCK) ON pdc.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS138v6_NQF0028] cqm WITH(NOLOCK) on cqm.Code = pdc.Code
	WHERE IPP.RequestId = @RequestId AND (IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0)
	AND pdc.PerformedFromDate BETWEEN @measureStartDate AND @EndDate  
	AND NOT  pdc.PerformedToDate BETWEEN @measureStartDate AND @EndDate  
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId = 5 AND cqm.ValueSetId = 158
	 
	
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
