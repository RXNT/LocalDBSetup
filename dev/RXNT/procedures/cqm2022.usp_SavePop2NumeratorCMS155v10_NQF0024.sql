SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 15-NOV-2022
-- Description:	To save the numerator for the measure
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SavePop2NumeratorCMS155v10_NQF0024]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2022].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId

	UPDATE TOP(@MaxRowCount) IPP
	set Numerator = 1
	FROM cqm2022.[DoctorCQMCalcPop2CMS155v10_NQF0024] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientProcedureCodes ppc WITH(NOLOCK) ON IPP.PatientId = ppc.PatientId
	INNER JOIN [cqm2022].[SysLookUpCMS155v10_NQF0024] cqm WITH(NOLOCK) on cqm.code = ppc.code
	INNER JOIN cqm2022.PatientEncounterCodes pec WITH(NOLOCK) ON ppc.EncounterId = pec.EncounterId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND IPP.DoctorId = @DoctorId 
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 4 AND cqm.CodeSystemId IN (2,5,16,27,28,29,30,31) AND cqm.ValueSetId = 94
	
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
