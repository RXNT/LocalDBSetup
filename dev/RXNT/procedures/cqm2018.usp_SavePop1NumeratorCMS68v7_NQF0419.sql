SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 2nd-February-2018
-- Description:	To save the numerator for the measure

-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS68v7_NQF0419]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRowCount INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	UPDATE calc SET Numerator = 1
	FROM  cqm2018.[DoctorCQMCalcPop1CMS68v7_NQF0419] calc WITH(NOLOCK)
	INNER JOIN cqm2018.PatientMedicationCodes pmc WITH(NOLOCK) ON calc.PatientId=pmc.PatientId
	WHERE calc.RequestId = @RequestId AND calc.DoctorId = @DoctorId 
	AND (calc.Numerator IS NULL OR calc.Numerator = 0)
	AND  pmc.DoctorId = @DoctorId AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate 

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
