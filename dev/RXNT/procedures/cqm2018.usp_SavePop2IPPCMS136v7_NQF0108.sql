SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 6th-FEB-2018
-- Description:	To save the initial patient population 2 for the measure
-- =============================================

CREATE PROCEDURE [cqm2018].[usp_SavePop2IPPCMS136v7_NQF0108]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
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
		INNER JOIN cqm2018.SysLookupCMS136v7_NQF0108 cqm WITH(NOLOCK) ON cqm.code = pmc.Code		
		LEFT JOIN cqm2018.DoctorCQMCalcPop1CMS136v7_NQF0108 IPP WITH(NOLOCK) on IPP.PatientId = pmc.PatientId AND IPP.RequestId = @RequestId
		WHERE pmc.DoctorId = @DoctorId	
		AND cqm.QDMCategoryId = 5  AND cqm.ValueSetId = 22
		AND DATEDIFF(DAY,@StartDate,pmc.PerformedFromDate) BETWEEN -90 AND 60	
		AND pmc.MedicationId IS NULL 	
		AND IPP.CalcId IS NULL
	)
	

	INSERT INTO cqm2018.DoctorCQMCalcPop2CMS136v7_NQF0108
	(PatientId, IPP, Denominator, DoctorId, RequestId)
	SELECT DISTINCT TOP(@MaxRowsCount) pat.pa_id, 1 as IPP, 1 as 'Denominator', @DoctorId, @RequestId
	FROM cqm2018.PatientEncounterCodes pec with(NOLOCK)
	INNER JOIN patients pat with(NOLOCK) ON pec.PatientId=pat.pa_id	
	INNER JOIN cqm2018.PatientMedicationCodes pmc  WITH(NOLOCK) ON pmc.EncounterId= pec.EncounterId and pmc.PatientId=pec.PatientId and pmc.MedicationId is not null	
	INNER JOIN InitialADHDMedication M ON M.pa_id=pec.PatientId			
	LEFT JOIN cqm2018.DoctorCQMCalcPop1CMS136v7_NQF0108 IPP  WITH(NOLOCK) on IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE pec.DoctorId = @DoctorId
	AND pec.PerformedFromDate between @StartDate and @EndDate AND
	NOT (pa_dob LIKE '1901-01-01') AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate)  BETWEEN  6*12 AND 12*12	 
	AND DATEDIFF(DAY,pmc.PerformedFromDate,M.PerformedFromDate) >=210		 	
	AND IPP.CalcId IS NULL
	
	
		
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
