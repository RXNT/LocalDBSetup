SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1-Feb-2018
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenomExclusionsCMS117v6_NQF0038]
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
	FROM cqm2018.[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	UPDATE TOP(@MaxRowCount) IPP
	SET DenomExclusions = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS117v6_NQF0038] IPP
	INNER JOIN cqm2018.PatientInterventionCodes pic ON pic.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS117v6_NQF0038] cqm on cqm.code = pic.code
	INNER JOIN cqm2018.PatientEncounterCodes pec ON pec.EncounterId = pic.EncounterId
	WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0)
	AND pic.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId = 31 
	
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
