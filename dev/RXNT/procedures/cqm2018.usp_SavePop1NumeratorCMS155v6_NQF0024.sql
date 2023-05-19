SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the numerator for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS155v6_NQF0024]  
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 10
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	UPDATE TOP(@MaxRowCount) IPP
	SET Numerator = 1 
	FROM cqm2018.[DoctorCQMCalcPop1CMS155v6_NQF0024] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientPhysicalExamCodes bmi WITH(NOLOCK) ON bmi.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookUpCMS155v6_NQF0024] cqm1 WITH(NOLOCK) ON cqm1.Code = bmi.Code
	INNER JOIN cqm2018.PatientPhysicalExamCodes height WITH(NOLOCK) ON height.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookUpCMS155v6_NQF0024] cqm2 WITH(NOLOCK) ON cqm2.Code = height.Code
	INNER JOIN cqm2018.PatientPhysicalExamCodes weight WITH(NOLOCK) ON weight.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookUpCMS155v6_NQF0024] cqm3 WITH(NOLOCK) ON cqm3.Code = weight.Code
	WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId 
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0) 	
	AND cqm1.QDMCategoryId = 12 AND cqm1.CodeSystemId = 9 AND cqm1.ValueSetId = 93
	AND	bmi.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm2.QDMCategoryId = 12 AND cqm2.CodeSystemId = 9 AND cqm2.ValueSetId = 96
	AND height.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm3.QDMCategoryId = 12 AND cqm3.CodeSystemId = 9 AND cqm3.ValueSetId = 98
	AND weight.PerformedFromDate BETWEEN @StartDate AND @EndDate
	
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
