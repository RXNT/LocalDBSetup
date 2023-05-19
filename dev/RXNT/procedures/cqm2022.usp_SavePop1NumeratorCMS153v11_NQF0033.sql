SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ============================================
-- Author:		Rasheed
-- Create date: 14-NOV-2022
-- Description:	To save the numerator for the measure CMS153v11_NQF0033
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SavePop1NumeratorCMS153v11_NQF0033]
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
	SET IPP.Numerator = 1
	FROM [cqm2022].[DoctorCQMCalcPop1CMS153v11_NQF0033] IPP WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=IPP.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2022.PatientLaboratoryTestCodes pltc  WITH(NOLOCK) ON pltc.PatientId = IPP.PatientId
	INNER JOIN [cqm2022].[SysLookupCMS153v11_NQF0033] as cqm with(NOLOCK) on pltc.Code = cqm.Code
	WHERE dg.dc_id=@DoctorCompanyId AND IPP.RequestId = @RequestId AND (IPP.Numerator IS NULL OR IPP.Numerator = 0)
	AND cqm.QDMCategoryId = 9 AND cqm.CodeSystemId = 25 AND cqm.ValueSetId = 71
	AND pltc.DoctorId = @DoctorId AND pltc.PerformedFromDate BETWEEN @StartDate AND @EndDate

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
