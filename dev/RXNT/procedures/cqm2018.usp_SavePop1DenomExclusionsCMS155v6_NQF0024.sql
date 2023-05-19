SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 1st-Feb-2018
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE PROCEDURE [cqm2018].[usp_SavePop1DenomExclusionsCMS155v6_NQF0024]
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
	
	UPDATE top(@MaxRowCount) IPP
	SET DenomExclusions = 1
	FROM [cqm2018].[DoctorCQMCalcPop1CMS155v6_NQF0024] IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN [cqm2018].[SysLookUpCMS155v6_NQF0024] cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0) 
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (5,8) AND cqm.ValueSetId = 97
	AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
