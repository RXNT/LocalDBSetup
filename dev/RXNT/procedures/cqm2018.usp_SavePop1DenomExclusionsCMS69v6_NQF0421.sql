SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 5th-FEB-2018
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenomExclusionsCMS69v6_NQF0421]
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
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] IPP  WITH(NOLOCK)
	INNER JOIN (
		SELECT DISTINCT ppc.PatientId FROM 
		cqm2018.PatientInterventionCodes ppc WITH(NOLOCK)
		INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm WITH(NOLOCK) on cqm.code = ppc.code
		INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK) ON pec.EncounterId = ppc.EncounterId
		WHERE ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
		AND ppc.PerformedFromDate <= pec.PerformedToDate
		AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId = 16 AND ppc.DoctorId=@DoctorId 
		UNION
		SELECT DISTINCT pdc.PatientId FROM 
		cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK)
		INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm  WITH(NOLOCK) on cqm.code = pdc.code
		WHERE cqm.QDMCategoryId = 1 AND cqm.ValueSetId = 19 AND pdc.DoctorId=@DoctorId 
	) pac ON pac.PatientId=IPP.PatientId AND IPP.DoctorId=@DoctorId
	AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0)
	
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
