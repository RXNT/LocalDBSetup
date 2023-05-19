SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 31st-October-2018
-- Description:	To save the numerator for the measure

-- =============================================
CREATE PROCEDURE [cqm2019].[usp_SavePop1NumeratorCMS68v8_NQF0419]
	@RequestId BIGINT 
AS
BEGIN
	DECLARE @MaxRowCount INT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATETIME
	DECLARE @EndDate DATETIME
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId
	
	UPDATE calc SET Numerator = 1
	FROM  cqm2019.[DoctorCQMCalcPop1CMS68v8_NQF0419] calc WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=calc.PatientId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientMedicationCodes pmc WITH(NOLOCK) ON calc.PatientId=pmc.PatientId
	WHERE dg.dc_id=@DoctorCompanyId AND calc.RequestId = @RequestId AND calc.DoctorId = @DoctorId 
	AND (calc.Numerator IS NULL OR calc.Numerator = 0)
	AND  pmc.DoctorId = @DoctorId AND pmc.PerformedFromDate BETWEEN @StartDate AND @EndDate

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
