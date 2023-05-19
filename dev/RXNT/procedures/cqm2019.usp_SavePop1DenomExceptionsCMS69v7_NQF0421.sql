SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 29th-OCT-2019
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop1DenomExceptionsCMS69v7_NQF0421]
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

	UPDATE TOP(@MaxRowCount) IPP
	SET DenomExceptions = 1
	FROM cqm2019.[DoctorCQMCalcPop1CMS69v7_NQF0421] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientProcedureCodes ppc  WITH(NOLOCK) ON ppc.PatientId = IPP.PatientId
	INNER JOIN cqm2019.[SysLookUpCMS69v7_NQF0421] cqm  WITH(NOLOCK) on cqm.code = ppc.code
	INNER JOIN cqm2019.PatientEncounterCodes enc  WITH(NOLOCK) ON enc.EncounterId=ppc.EncounterId 
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId AND ppc.PerformedFromDate<enc.PerformedToDate AND 
	DATEDIFF(MONTH,ppc.PerformedFromDate,enc.PerformedToDate)<=12
	AND cqm.ValueSetId=14 AND cqm.QDMCategoryId=11
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
