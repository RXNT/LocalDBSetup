SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 15-NOV-2022
-- Description:	To save the numerator for the measure
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SavePop3NumeratorCMS155v11_NQF0024]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @MaxRowCount INT = 100;
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate,@DoctorCompanyId=dg.dc_id
	FROM [cqm2023].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK) 
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId

	UPDATE TOP(@MaxRowCount) IPP
	SET Numerator = 1
	FROM cqm2023.[DoctorCQMCalcPop3CMS155v11_NQF0024] IPP WITH(NOLOCK)
	INNER JOIN cqm2023.PatientProcedureCodes ppc WITH(NOLOCK) ON IPP.PatientId = ppc.PatientId
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN [cqm2023].[SysLookUpCMS155v11_NQF0024] cqm WITH(NOLOCK) on cqm.code = ppc.code
	INNER JOIN cqm2023.PatientEncounterCodes pec WITH(NOLOCK) ON ppc.EncounterId = pec.EncounterId
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.DoctorId = @DoctorId AND IPP.RequestId = @RequestId 
	AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate
	AND cqm.QDMCategoryId = 4 AND cqm.ValueSetId = 95
	
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
