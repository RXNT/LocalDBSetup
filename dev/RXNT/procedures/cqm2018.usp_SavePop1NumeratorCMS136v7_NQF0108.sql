SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the numerator for the measure
-- 
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop1NumeratorCMS136v7_NQF0108]
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
	FROM [cqm2018].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId;
	
	WITH InitialADHDMedication(pa_id, PerformedFromDate)
	AS
	(
		SELECT DISTINCT pmc.PatientId, pmc.PerformedFromDate
		FROM cqm2018.PatientMedicationCodes pmc with(NOLOCK)
		INNER JOIN cqm2018.SysLookupCMS136v7_NQF0108 cqm WITH(NOLOCK)  ON cqm.code = pmc.Code		
		LEFT JOIN cqm2018.DoctorCQMCalcPop1CMS136v7_NQF0108 IPP WITH(NOLOCK)  on IPP.PatientId = pmc.PatientId AND IPP.RequestId = @RequestId
		WHERE pmc.DoctorId = @DoctorId	
		AND cqm.QDMCategoryId = 5  AND cqm.ValueSetId = 22
		AND DATEDIFF(DAY,@StartDate,pmc.PerformedFromDate) BETWEEN -90 AND 60	
		AND pmc.MedicationId IS NULL 	
		AND IPP.CalcId IS NULL
	)
	
	UPDATE TOP(@MaxRowCount) cqm2018.DoctorCQMCalcPOP1CMS136v7_NQF0108
	SET Numerator = 1
	FROM cqm2018.DoctorCQMCalcPOP1CMS136v7_NQF0108 IPP WITH(NOLOCK)
	INNER JOIN cqm2018.PatientEncounterCodes pec WITH(NOLOCK)  on pec.PatientId = IPP.PatientId
	INNER JOIN [cqm2018].[SysLookupCMS136v7_NQF0108] cqm WITH(NOLOCK)  ON pec.Code = cqm.code	 
	INNER JOIN InitialADHDMedication M ON M.pa_id=IPP.PatientId	
	WHERE pec.DoctorId = @DoctorId AND cqm.QDMCategoryId = 2
	AND DATEDIFF(Day,pec.PerformedFromDate, M.PerformedFromDate) <=30
	AND IPP.Numerator IS NULL OR IPP.Numerator = 0

	
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
