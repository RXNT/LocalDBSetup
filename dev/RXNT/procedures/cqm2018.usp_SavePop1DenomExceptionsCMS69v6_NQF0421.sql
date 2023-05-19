SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenomExceptionsCMS69v6_NQF0421]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId

	UPDATE TOP(@MaxRowCount) IPP
	SET DenomExceptions = 1
	FROM cqm2018.[DoctorCQMCalcPop1CMS69v6_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientProcedureCodes ppc  WITH(NOLOCK) ON ppc.PatientId = IPP.PatientId
	INNER JOIN cqm2018.[SysLookUpCMS69v6_NQF0421] cqm  WITH(NOLOCK) on cqm.code = ppc.code
	INNER JOIN cqm2018.PatientEncounterCodes enc  WITH(NOLOCK) ON enc.EncounterId=ppc.EncounterId 
	WHERE IPP.DoctorId = @DoctorId AND ppc.PerformedFromDate<enc.PerformedToDate AND 
	DATEDIFF(MONTH,ppc.PerformedFromDate,enc.PerformedToDate)<=12
	AND cqm.ValueSetId IN (14) AND cqm.QDMCategoryId=11
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
