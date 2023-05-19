SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29th-OCT-2022
-- Description:	To save the denominator exceptions for the measure
-- =============================================
CREATE    PROCEDURE [cqm2022].[usp_SavePop1DenomExceptionsCMS68v12_NQF0419]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowsCount INT = 100
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2022].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	 
	INSERT INTO cqm2022.DoctorCQMCalcPop1CMS68v12_NQF0419
	(PatientId, DenomExceptions, DoctorId, RequestId,DatePerformed)
	SELECT TOP(@MaxRowsCount) pat.pa_id, 1 as DenomExceptions, @DoctorId, @RequestId,ppc.PerformedFromDate 
	--UPDATE TOP(@MaxRowsCount) IPP
	--SET DenomExceptions = 1
	FROM patients pat WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientProcedureCodes ppc  WITH(NOLOCK) ON ppc.PatientId =  pat.pa_id
	LEFT JOIN cqm2022.DoctorCQMCalcPop1CMS68v12_NQF0419 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId AND CAST(ppc.PerformedFromDate AS DATE)=CAST(IPP.DatePerformed AS DATE) AND IPP.DenomExceptions =1
	WHERE dg.dc_id=@DoctorCompanyId AND ppc.DoctorId = @DoctorId AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND ppc.CODE='428191000124101' AND ppc.Status='Not Done'
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 

	INSERT INTO cqm2022.DoctorCQMCalcPop1CMS68v12_NQF0419
	(PatientId, DenomExceptions, DoctorId, RequestId,DatePerformed)
	SELECT TOP(@MaxRowsCount) pat.pa_id, 1 as DenomExceptions, @DoctorId, @RequestId,ppc.PerformedFromDate 
	--UPDATE TOP(@MaxRowsCount) IPP
	--SET DenomExceptions = 1
	FROM patients pat WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.[PatientInterventionCodes] ppc  WITH(NOLOCK) ON ppc.PatientId =  pat.pa_id
	LEFT JOIN cqm2022.DoctorCQMCalcPop1CMS68v12_NQF0419 IPP WITH(NOLOCK) ON IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId AND CAST(ppc.PerformedFromDate AS DATE)=CAST(IPP.DatePerformed AS DATE) AND IPP.DenomExceptions =1
	WHERE dg.dc_id=@DoctorCompanyId AND ppc.DoctorId = @DoctorId AND ppc.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND ppc.CODE='428191000124101' AND ppc.Status='Not Done'
	AND IPP.DenomExceptions IS NULL OR IPP.DenomExceptions = 0 
 
	 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
