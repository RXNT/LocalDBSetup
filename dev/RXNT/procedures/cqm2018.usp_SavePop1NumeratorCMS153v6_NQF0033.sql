SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the numerator for the measure CMS153v6_NQF0033
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS153v6_NQF0033]
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
	
	UPDATE TOP(@MaxRowCount) IPP
	SET IPP.Numerator = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS153v6_NQF0033] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientLaboratoryTestCodes pltc  WITH(NOLOCK) ON pltc.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS153v6_NQF0033] as cqm with(NOLOCK) on pltc.Code = cqm.Code
	WHERE  IPP.RequestId = @RequestId AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 9 AND cqm.ValueSetId = 71
	AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate

	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
	SET @AffectedRows = @tempRowCount;
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
