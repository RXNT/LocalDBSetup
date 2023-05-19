SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 15-NOV-2018
-- Description:	To save the denominator Exclusions for the measure
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop1DenomExclusionsCMS155v7_NQF0024]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	UPDATE top(@MaxRowCount) IPP
	SET DenomExclusions = 1
	FROM [cqm2019].[DoctorCQMCalcPop1CMS155v7_NQF0024] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientDiagnosisCodes pdc WITH(NOLOCK) ON pdc.PatientId = IPP.patientId
	INNER JOIN [cqm2019].[SysLookUpCMS155v7_NQF0024] cqm WITH(NOLOCK) on cqm.code = pdc.code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId
	AND (IPP.DenomExclusions IS NULL OR IPP.DenomExclusions = 0) 
	AND cqm.QDMCategoryId = 1 AND cqm.CodeSystemId IN (6,8) AND cqm.ValueSetId = 97
	AND pdc.PerformedFromDate BETWEEN @StartDate AND @EndDate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
