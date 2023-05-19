SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 9-NOV-2018
-- Description:	To save the initial patient population 2 for the measure
-- =============================================

CREATE PROCEDURE [cqm2019].[usp_SavePop2IPPCMS136v8_NQF0108]
	@RequestId BIGINT  
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT = 100
	DECLARE @DoctorId BIGINT
	DECLARE @DoctorCompanyId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	DECLARE @dob_start DATETIME=CAST('1901-01-02' AS DATETIME)
	
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate, @DoctorCompanyId=dg.dc_id
	FROM [cqm2019].[DoctorCQMCalculationRequest] DCCR WITH(NOLOCK)
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id=DCCR.DoctorId
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id=dg.dg_id
	WHERE RequestId = @RequestId;
	
	WITH InitialADHDMedication(pa_id, PerformedFromDate)
	AS
	(
		SELECT DISTINCT pmc.PatientId, pmc.PerformedFromDate
		FROM cqm2019.PatientMedicationCodes pmc with(NOLOCK)
		INNER JOIN patients pat WITH(NOLOCK) ON pat.pa_id=pmc.PatientId
		INNER JOIN cqm2019.SysLookupCMS136v8_NQF0108 cqm WITH(NOLOCK) ON cqm.code = pmc.Code		
		LEFT JOIN cqm2019.DoctorCQMCalcPop1CMS136v8_NQF0108 IPP WITH(NOLOCK) on IPP.PatientId = pmc.PatientId AND IPP.RequestId = @RequestId
		WHERE pmc.DoctorId = @DoctorId	
		AND cqm.QDMCategoryId = 5  AND cqm.ValueSetId = 22
		AND DATEDIFF(DAY,@StartDate,pmc.PerformedFromDate) BETWEEN -90 AND 60	
		AND pmc.MedicationId IS NULL 	
		AND IPP.CalcId IS NULL
		AND DATEDIFF(MONTH,PAT.pa_dob,@StartDate)  BETWEEN  6*12 AND 12*12	 
	)
	

	INSERT INTO cqm2019.DoctorCQMCalcPop2CMS136v8_NQF0108
	(PatientId, IPP, Denominator, DoctorId, RequestId)
	SELECT DISTINCT TOP(@MaxRowsCount) pat.pa_id, 1 as IPP, 1 as 'Denominator', @DoctorId, @RequestId
	FROM cqm2019.PatientEncounterCodes pec with(NOLOCK)
	INNER JOIN patients pat with(NOLOCK) ON pec.PatientId=pat.pa_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN cqm2019.PatientMedicationCodes pmc  WITH(NOLOCK) ON pmc.EncounterId= pec.EncounterId and pmc.PatientId=pec.PatientId and pmc.MedicationId is not null	
	INNER JOIN InitialADHDMedication M ON M.pa_id=pec.PatientId			
	--LEFT JOIN cqm2019.DoctorCQMCalcPop1CMS136v8_NQF0108 IPP  WITH(NOLOCK) on IPP.PatientId = pat.pa_id AND IPP.RequestId = @RequestId
	WHERE pec.DoctorId = @DoctorId AND dg.dc_id=@DoctorCompanyId
	AND pec.PerformedFromDate between @StartDate and @EndDate 
	AND DATEDIFF(DAY,pmc.PerformedFromDate,M.PerformedFromDate) >=210		 	
	--AND IPP.CalcId IS NULL
	
	
		
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
