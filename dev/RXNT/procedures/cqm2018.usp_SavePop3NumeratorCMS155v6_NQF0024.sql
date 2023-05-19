SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the numerator for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop3NumeratorCMS155v6_NQF0024]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100;
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	UPDATE TOP(@MaxRowCount) IPP
	SET Numerator = 1
	FROM cqm2018.[DoctorCQMCalcPop3CMS155v6_NQF0024] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientProcedureCodes ppc WITH(NOLOCK) ON IPP.PatientId = ppc.PatientId
	INNER JOIN [cqm2018].[SysLookUpCMS155v6_NQF0024] cqm WITH(NOLOCK) on cqm.code = ppc.code
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON ppc.EncounterId = pec.EncounterId
	WHERE IPP.DoctorId = @DoctorId AND IPP.RequestId = @RequestId 
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 4 AND cqm.CodeSystemId=5 AND cqm.ValueSetId = 95
	
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
